{----}


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (type', value)
import Html.Events exposing (onClick, onInput)
import Html.App as App
import String


main : Program Never
main =
    App.beginnerProgram
        { model = initialModel
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { calories : Int
    , input : Int
    , error : Maybe String
    }


initialModel : Model
initialModel =
    { calories = 0
    , input = 0
    , error = Nothing
    }



-- UPDATE


type Msg
    = Add
    | Clear
    | ChangeInput String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            { model | calories = model.calories + model.input, input = 0 }

        Clear ->
            initialModel

        ChangeInput input ->
            case String.toInt input of
                Ok val ->
                    { model | input = val, error = Nothing }

                Err err ->
                    { model | input = 0, error = Just err }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text <| "Total Calories " ++ (toString model.calories) ]
        , div []
            [ input
                [ type' "text"
                , onInput ChangeInput
                , value
                    (if model.input == 0 then
                        ""
                     else
                        toString model.input
                    )
                ]
                []
            , text <| Maybe.withDefault "OK" model.error
            ]
        , div
            []
            [ button [ type' "button", onClick Add ] [ text "Add" ]
            , button [ type' "button", onClick Clear ] [ text "Clear" ]
            ]
        , viewDebug model
        ]


viewDebug : Model -> Html Msg
viewDebug model =
    div []
        [ hr [] []
        , text <| toString model
        ]
