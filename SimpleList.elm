module Main exposing (..)

import Html exposing (..)


type alias Model =
    { title : String, items : List Item }


type alias Item =
    String


model : Model
model =
    { title = "Shoppting List", items = [ "Apples", "Tomatos", "Banana" ] }


main : Html a
main =
    view model


view : Model -> Html a
view model =
    div []
        [ viewTitle model.title
        , viewList model.items
        ]


viewTitle : String -> Html a
viewTitle title =
    h1 [] [ text title ]


viewList : List Item -> Html a
viewList list =
    ul [] (List.map viewItem list)


viewItem : Item -> Html a
viewItem item =
    li [] [ text item ]
