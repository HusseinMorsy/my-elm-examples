module Main exposing (..)

import Html exposing (..)


main : Html.Html a
main =
    Html.div []
        [ h1 []
            [ text "Simple currying example" ]
        , p
            []
            [ text
                ("2  * 5 = multi 2 5 = double 5 = "
                    ++ (toString (double 5))
                )
            , p [] [ text <| "doubleDec(5) = " ++ (toString <| doubleDec 5) ]
            ]
        ]


multi : Int -> Int -> Int
multi a b =
    a * b


double : Int -> Int
double =
    multi 2


doubleDec : Int -> Int
doubleDec =
    double >> dec


dec : Int -> Int
dec a =
    a - 1
