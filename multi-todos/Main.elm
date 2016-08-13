module Main exposing (..)

import TodoList
import Html
import Html.App


main : Program Never
main =
    Html.App.beginnerProgram
        { model = initialModel
        , update = update
        , view = view
        }



-- Model


type alias Model =
    List IndexedTodoList


type alias IndexedTodoList =
    { id : Int
    , todoList : TodoList.Model
    }


initialModel : Model
initialModel =
    [ { id = 1
      , todoList =
            { title = "Vegetables"
            , todos =
                [ { id = 1, name = "Tomatos", state = TodoList.Open }
                , { id = 2, name = "Gherkin", state = TodoList.Done }
                , { id = 4, name = "Spinach", state = TodoList.Deleted }
                , { id = 5, name = "Zucchini", state = TodoList.Done }
                ]
            }
      }
    , { id = 2
      , todoList =
            { title = "Fruits"
            , todos =
                [ { id = 1, name = "Apples", state = TodoList.Open }
                , { id = 2, name = "Bananas", state = TodoList.Done }
                ]
            }
      }
    ]



-- UPDATE


type Msg
    = Nothing
    | TodoListMsg Int TodoList.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Nothing ->
            model

        TodoListMsg id todoListMsg ->
            List.map (updateTodoList id todoListMsg) model


updateTodoList : Int -> TodoList.Msg -> IndexedTodoList -> IndexedTodoList
updateTodoList targetId msg { id, todoList } =
    IndexedTodoList id
        (if targetId == id then
            TodoList.update msg todoList
         else
            todoList
        )



-- VIEW


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.div []
            (List.map viewIndexedTodoList model)
        , Html.hr [] []
        , Html.p [] [ Html.text <| toString model ]
        ]


viewIndexedTodoList : IndexedTodoList -> Html.Html Msg
viewIndexedTodoList { id, todoList } =
    Html.App.map (TodoListMsg id) (TodoList.view todoList)
