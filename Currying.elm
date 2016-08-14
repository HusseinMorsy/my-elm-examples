module Main exposing (..)

import Html


main : Html.Html a
main =
    Html.div []
        [ Html.h1 []
            [ Html.text "Simple currying example" ]
        , Html.p
            []
            [ Html.text
                ("2  * 5 = multi 2 5 = double 5 = "
                    ++ (toString (double 5))
                )
            ]
        ]


multi : Int -> Int -> Int
multi a b =
    a * b


double : Int -> Int
double =
    multi 2
