module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = initialModel, update = update, view = view }



-- MODEL


type alias Model =
    Int


initialModel : Model
initialModel =
    0



-- UPDATE


type Msg
    = Increase
    | Decrease
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increase ->
            model + 1

        Decrease ->
            if model > 0 then
                model - 1
            else
                model

        Reset ->
            initialModel



----


view : Model -> Html Msg
view model =
    section []
        [ h1 [] [ text "Counter" ]
        , button [ onClick Decrease ] [ text "-" ]
        , span [] [ text (toString model) ]
        , button [ onClick Increase ] [ text "+" ]
        , br [] []
        , button [ onClick Reset ] [ text "Reset" ]
        ]
