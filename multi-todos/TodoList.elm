module TodoList exposing (..)

import Html as H
import Html.Attributes as HA
import Html.Events


-- MODEL


type alias Model =
    { title : String, todos : List TodoItem }


type alias TodoItem =
    { id : Int, name : String, state : State }


type State
    = Open
    | Done
    | Deleted



-- UPDATE


type Msg
    = Nothing
    | Check Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Nothing ->
            model

        Check id ->
            let
                updateTodo todo =
                    if todo.id == id then
                        toggleCheck todo
                    else
                        todo
            in
                { model | todos = List.map (updateTodo) model.todos }


toggleCheck : TodoItem -> TodoItem
toggleCheck todo =
    if todo.state == Open then
        { todo | state = Done }
    else
        { todo | state = Open }



-- VIEW


view : Model -> H.Html Msg
view model =
    H.div []
        [ H.h1 []
            [ H.text model.title ]
        , H.ul
            []
            (List.map viewListItem model.todos)
        ]


viewListItem : TodoItem -> H.Html Msg
viewListItem item =
    let
        style state =
            case state of
                Open ->
                    HA.style [ ( "font-weight", "bold" ) ]

                Done ->
                    HA.style [ ( "text-decoration", "line-through" ) ]

                Deleted ->
                    HA.style []
    in
        H.li [ style item.state, Html.Events.onClick (Check item.id) ] [ H.text item.name ]
