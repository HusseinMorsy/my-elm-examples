module UuidGenerator exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Uuid exposing (Uuid)
import Random.Pcg as Random


main : Program Never Model Msg
main =
    Html.program { init = init, update = update, view = view, subscriptions = \_ -> Sub.none }



-- MODEL


type alias Model =
    Maybe Uuid


init : ( Model, Cmd Msg )
init =
    ( Nothing, Cmd.none )



-- UPDATE


type Msg
    = GenerateNewUuid
    | SetUuid Uuid


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateNewUuid ->
            ( model, Random.generate SetUuid Uuid.uuidGenerator )

        SetUuid uuid ->
            ( Just uuid, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        viewUuid =
            case model of
                Just uuid ->
                    p [] [ text <| Uuid.toString uuid ]

                Nothing ->
                    p [] [ text "" ]
    in
        div []
            [ h1 [] [ text "UUID v.4 Generator" ]
            , viewUuid
            , p []
                [ button [ onClick GenerateNewUuid ] [ text "generate new uuid" ]
                ]
            ]
