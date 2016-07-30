module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Html.App as App


main : Program Never
main =
    App.beginnerProgram { model = model, update = update, view = view }



-- MODEL


type alias Model =
    { title : String, items : List Item }


type alias Item =
    { name : String, done : Bool }


model : Model
model =
    { title = "Shoppting List"
    , items =
        [ { name = "Apples", done = False }
        , { name = "Tomatos", done = True }
        , { name = "Banana", done = False }
        , { name = "Nuts", done = False }
        ]
    }



-- UPDATE


type Msg
    = Check String
    | CheckAll
    | DeleteChecked


update : Msg -> Model -> Model
update msg model =
    case msg of
        CheckAll ->
            let
                checkItem item =
                    { item | done = True }
            in
                { model | items = List.map checkItem model.items }

        DeleteChecked ->
            let
                isNotChecked item =
                    not item.done
            in
                { model | items = List.filter isNotChecked model.items }

        Check name ->
            let
                checkItem item =
                    if item.name /= name then
                        item
                    else
                        { item | done = True }
            in
                { model | items = List.map checkItem model.items }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewTitle model.title
        , viewControlls
        , viewList model.items
        ]


viewTitle : String -> Html Msg
viewTitle title =
    h1 [] [ text title ]


viewControlls : Html Msg
viewControlls =
    div []
        [ button [ onClick CheckAll ] [ text "Check all" ]
        , button [ onClick DeleteChecked ] [ text "Delete Checked" ]
        ]


viewList : List Item -> Html Msg
viewList list =
    ul [] (List.map viewItem list)


viewItem : Item -> Html Msg
viewItem item =
    if item.done then
        li [ style [ ( "text-decoration", "line-through" ) ] ] [ text item.name ]
    else
        li [ onClick (Check item.name), style [ ( "cursor", "pointer" ) ] ] [ text item.name ]
