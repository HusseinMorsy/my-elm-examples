module Main exposing (..)

import Html exposing (..)


model =
    { title = "Shoppting List", items = [ "Apples", "Tomatos", "Banana" ] }


main =
    view model


view model =
    div []
        [ viewTitle model.title
        , viewList model.items
        ]


viewTitle title =
    h1 [] [ text title ]


viewList list =
    ul [] (List.map viewItem list)


viewItem item =
    li [] [ text item ]
