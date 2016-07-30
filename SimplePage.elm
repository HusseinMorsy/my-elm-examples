module Main exposing (..)

import Html exposing (..)


viewTitle title =
    h1 [] [ text title ]


model =
    [ "Apples", "Tomatos", "Banana" ]


viewItem item =
    li [] [ text item ]


viewList model =
    ul [] (List.map (\e -> viewItem e) model)


main =
    div []
        [ viewTitle "Static shopping list"
        , viewList model
        ]
