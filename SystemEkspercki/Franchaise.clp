(deftemplate state
    (slot display)
    (slot step)
    (multislot answers)
)

(deftemplate question
    (slot preceding-question)
    (slot preceding-answer)
    (slot display)
    (multislot answers
        (default "Yes" "No")
    )
    (slot resolution)
    (slot is-final
        (default no)
    )
)

(deffacts init
    (state
        (step question)
        (display "Which franchise is the best for you?")
        (answers
            "Knowledge is my wealth"
            "I am a health freak"
            "People and things fascinate me"
            "I live for food"
        )
    )

    (question
        (preceding-question "Which franchise is the best for you?")
        (preceding-answer "Knowledge is my wealth")
        (display "Do you like kids?")
    )

        (question
            (preceding-question "Do you like kids?")
            (preceding-answer "Yes")
            (display "Do you have lots of patience?")
        )

            (question
                (preceding-question "Do you have lots of patience?")
                (preceding-answer "Yes")
                (resolution "Pre-k school")
                (is-final yes)
            )
            (question
                (preceding-question "Do you have lots of patience?")
                (preceding-answer "No")
                (resolution "K-12 school, coaching class")
                (is-final yes)
            )

        (question
            (preceding-question "Do you like kids?")
            (preceding-answer "No")
            (display "Do you have good people skills?")
        )

            (question
                (preceding-question "Do you have good people skills?")
                (preceding-answer "Yes")
                (resolution "Vocational training")
                (is-final yes)
            )
            (question
                (preceding-question "Do you have good people skills?")
                (preceding-answer "No")
                (resolution "Books stationery")
                (is-final yes)
            )


    (question
        (preceding-question "Which franchise is the best for you?")
        (preceding-answer "I am a health freak")
        (display "Are you willing to try the offbeat?")
    )

        (question
            (preceding-question "Are you willing to try the offbeat?")
            (preceding-answer "Yes")
            (resolution "Alternate therapy")
            (is-final yes)
        )
        (question
            (preceding-question "Are you willing to try the offbeat?")
            (preceding-answer "No")
            (display "Are you an excercise addict?")
        )

            (question
                (preceding-question "Are you an excercise addict?")
                (preceding-answer "Yes")
                (display "Do you like to sweat it out?")
            )

                (question
                    (preceding-question "Do you like to sweat it out?")
                    (preceding-answer "Yes")
                    (resolution "Gym: zumba classes")
                    (is-final yes)
                )
                (question
                    (preceding-question "Do you like to sweat it out?")
                    (preceding-answer "No")
                    (resolution "Yoga, pilates, tai-chi")
                    (is-final yes)
                )

            (question
                (preceding-question "Are you an excercise addict?")
                (preceding-answer "No")
                (display "Does body care interest you?")
            )
                (question
                    (preceding-question "Does body care interest you?")
                    (preceding-answer "Yes")
                    (resolution "Salon SPA")
                    (is-final yes)
                )
                (question
                    (preceding-question "Does body care interest you?")
                    (preceding-answer "No")
                    (resolution "Slimming centre, pharmacy")
                    (is-final yes)
                )

    (question
        (preceding-question "Which franchise is the best for you?")
        (preceding-answer "People and things fascinate me")
        (display "Do you like to give advice?")
    )

        (question
            (preceding-question "Do you like to give advice?")
            (preceding-answer "Yes")
            (display "Do you have a passion for fashion?")
        )
            (question
                (preceding-question "Do you have a passion for fashion?")
                (preceding-answer "Yes")
                (display "Are you a clothes horse?")
            )
                (question
                    (preceding-question "Are you a clothes horse?")
                    (preceding-answer "Yes")
                    (display "Can you invest more than 50 lakh?")
                )
                    (question
                        (preceding-question "Can you invest more than 50 lakh?")
                        (preceding-answer "Yes")
                        (resolution "Luxury and high-fashion")
                        (is-final yes)
                    )
                    (question
                        (preceding-question "Can you invest more than 50 lakh?")
                        (preceding-answer "No")
                        (resolution "Retail apparel")
                        (is-final yes)
                    )
                (question
                    (preceding-question "Are you a clothes horse?")
                    (preceding-answer "No")
                    (resolution "Jewellery, home furnishing")
                    (is-final yes)
                )

            (question
                (preceding-question "Do you have a passion for fashion?")
                (preceding-answer "No")
                (display "Are you a tech guru?")
            )
                (question
                    (preceding-question "Are you a tech guru?")
                    (preceding-answer "Yes")
                    (resolution "Consumer electronics, mobiles")
                    (is-final yes)
                )
                (question
                    (preceding-question "Are you a tech guru?")
                    (preceding-answer "No")
                    (display "Are you meticulous planner?")
                )
                    (question
                        (preceding-question "Are you meticulous planner?")
                        (preceding-answer "Yes")
                        (display "Do you love to spend more than save?")
                    )
                        (question
                            (preceding-question "Do you love to spend more than save?")
                            (preceding-answer "Yes")
                            (resolution "Travel services")
                            (is-final yes)
                        )
                        (question
                            (preceding-question "Do you love to spend more than save?")
                            (preceding-answer "No")
                            (resolution "Finnancial services")
                            (is-final yes)
                        )
                    (question
                        (preceding-question "Are you meticulous planner?")
                        (preceding-answer "No")
                        (resolution "Matrimony services")
                        (is-final yes)
                    )

        (question
            (preceding-question "Do you like to give advice?")
            (preceding-answer "No")
            (resolution "Courier service, car cleaning, laundry, shoe spa")
            (is-final yes)
        )

    (question
        (preceding-question "Which franchise is the best for you?")
        (preceding-answer "I live for food")
        (display "Do you like to cook?")
    )
        (question
            (preceding-question "Do you like to cook?")
            (preceding-answer "Yes")
            (display "Are you quick and like crowds?")
        )
            (question
                (preceding-question "Are you quick and like crowds?")
                (preceding-answer "Yes")
                (display "Do you have more than 300 sq ft of space?")
            )
                (question
                    (preceding-question "Do you have more than 300 sq ft of space?")
                    (preceding-answer "Yes")
                    (resolution "Quick-service restaurant, casual dining")
                    (is-final yes)
                )
                (question
                    (preceding-question "Do you have more than 300 sq ft of space?")
                    (preceding-answer "No")
                    (resolution "Kiosk, food count")
                    (is-final yes)
                )
            (question
                (preceding-question "Are you quick and like crowds?")
                (preceding-answer "No")
                (resolution "Fine-dine restaurant")
                (is-final yes)
            )
        (question
            (preceding-question "Do you like to cook?")
            (preceding-answer "No")
            (display "Do you have more than 500 sq ft of space?")
        )
            (question
                (preceding-question "Do you have more than 500 sq ft of space?")
                (preceding-answer "Yes")
                (resolution "Food and grocery store")
                (is-final yes)
            )
            (question
                (preceding-question "Do you have more than 500 sq ft of space?")
                (preceding-answer "No")
                (resolution "Ice cream parlour, bakery")
                (is-final yes)
            )
)


(defrule answer
    ?oldAnswer <- (answer ?answer)
    ?currentState <- (state
        (display ?currentQuestion)
    )
    (question
        (preceding-question ?currentQuestion)
        (preceding-answer ?answer)
        (display ?display)
        (answers $?answers)
    )
    =>
    (retract ?currentState)
    (assert
        (state
            (step question)
            (display ?display)
            (answers $?answers)
        )
    )
    (retract ?oldAnswer)
)

(defrule end
    (declare (salience 1))
    ?oldAnswer <- (answer ?answer)
    ?currentState <- (state
        (display ?currentQuestion)
    )
    (question
        (preceding-question ?currentQuestion)
        (preceding-answer ?answer)
        (resolution ?resolution)
        (is-final yes)
    )
    =>
    (retract ?currentState)
    (assert
        (state
            (step finish)
            (display ?resolution)
        )
    )
    (retract ?oldAnswer)
)