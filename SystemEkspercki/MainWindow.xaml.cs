using System.Windows;
using Mommosoft.ExpertSystem;
using System.Windows.Controls;

namespace SystemEkspercki
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
		private readonly Environment _theEnv = new Environment();

		public MainWindow()
		{
			InitializeComponent();
			InitializeClips();
		}

		private void InitializeClips()
		{
			var file = "Franchaise.clp";

			_theEnv.AddRouter(new DebugRouter());
			_theEnv.Clear();
			_theEnv.Load(file);
			_theEnv.Reset();
			_theEnv.Run();
		}

		private void AddQAndA(string question, MultifieldValue answers)
		{
			ResetStackPanel();
			AddQuestion(question);
			AddAnswers(answers);
		}

		private void ResetStackPanel()
		{
			QuestionStackPnl.Children.Clear();
		}

		private void AddAnswers(MultifieldValue answers)
		{
			for(int i = 0; i < answers.Count; i++)
			{
				var rb = new RadioButton { Margin = new Thickness(3), Content = answers[i] };
				QuestionStackPnl.Children.Add(rb);
			}
			if (answers.Count > 0)
			{
				(QuestionStackPnl.Children[1] as RadioButton).IsChecked = true;
			}
		}

		private void AddQuestion(string question)
		{
			var lbl = new Label { Content = question, FontWeight = FontWeights.Bold };
			QuestionStackPnl.Children.Add(lbl);
		}

		private void PrepareForAskingQuestions()
		{
			StartBtn.Visibility = Visibility.Collapsed;
			NextBtn.Visibility = Visibility.Visible;
			NextBtn.Content = "Dalej";
			QuestionStackPnl.Visibility = Visibility.Visible;
		}

		private void StartBtn_Click(object sender, RoutedEventArgs e)
		{
			PrepareForAskingQuestions();
			_theEnv.Run();

			var evalStr = "(find-all-facts ((?f state)) TRUE)";
			using (var evalFact = (FactAddressValue)((MultifieldValue)_theEnv.Eval(evalStr))[0])
			{
				var step = evalFact.GetFactSlot("step").ToString();
				switch (step)
				{
					case "final":
						NextBtn.Content = "Reset";
						break;

					default:
						NextBtn.Content = "Dalej";
						break;
				}

				using (var validAnswers = (MultifieldValue)evalFact.GetFactSlot("answers"))
				using (var symbol = (SymbolValue)evalFact.GetFactSlot("display"))
					AddQAndA(symbol, validAnswers);
			}
		}

		private string GetAnswer()
		{
			foreach (var child in QuestionStackPnl.Children)
			{
				var radio = child as RadioButton;
				if (radio == null) continue;
				if (radio.IsChecked.HasValue && radio.IsChecked.Value)
					return radio.Content.ToString();
			}
			return null;
		}

		private void NextBtn_Click(object sender, RoutedEventArgs e)
		{
			NextStep();
		}

		private void NextStep()
		{
			var evalStr = "(find-all-facts ((?f state)) TRUE)";
			using (var evalFact = (FactAddressValue)((MultifieldValue)_theEnv.Eval(evalStr))[0])
			{
				var step = evalFact.GetFactSlot("step").ToString();
				evalStr = "(find-all-facts ((?f state)) TRUE)";
				using (var f = (FactAddressValue)((MultifieldValue)_theEnv.Eval(evalStr))[0])
				{
					if (step == "question")
					{
						var answer = string.Format("(answer {0})", GetAnswer());
						_theEnv.AssertString(answer);
					}
				}
				_theEnv.Run();
			}

			using (var evalFact = (FactAddressValue)((MultifieldValue)_theEnv.Eval(evalStr))[0])
			{
				using (var validAnswers = (MultifieldValue)evalFact.GetFactSlot("answers"))
				using (var symbol = (SymbolValue)evalFact.GetFactSlot("display"))
				{
					AddQAndA(symbol, validAnswers);
					var step = evalFact.GetFactSlot("step").ToString();
					if(step == "finish")
					{
						NextBtn.Content = "Reset";
						NextBtn.Click -= NextBtn_Click;
						NextBtn.Click += NextBtn_ClickFinish;
					}
				}
			}
		}

		private void NextBtn_ClickFinish(object sender, RoutedEventArgs e)
		{
			_theEnv.Reset();
			ResetStackPanel();
			StartBtn_Click(null, null);
			NextBtn.Click += NextBtn_Click;
			NextBtn.Click -= NextBtn_ClickFinish;
		}
	}
}