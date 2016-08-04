module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (style, value, disabled)
import Html.Events exposing (onInput)
import Time exposing (..)


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { name : String, timeLeft : Int }


initialModel : Model
initialModel =
    { name = "Leia", timeLeft = 10 }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



--UPDATE


type Msg
    = UpdateName String
    | Tick Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateName name ->
            { model | name = name, timeLeft = initialModel.timeLeft } ! []

        Tick _ ->
            { model
                | timeLeft =
                    if (timeElapsed model.timeLeft) then
                        0
                    else
                        model.timeLeft - 1
            }
                ! []


timeElapsed : Int -> Bool
timeElapsed timeLeft =
    timeLeft <= 0



--VIEW


view : Model -> Html Msg
view model =
    let
        timeLeftColor timeLeft =
            if timeLeft > 5 then
                "green"
            else if timeLeft > 0 then
                "orange"
            else
                "red"
    in
        div []
            [ h1 [] [ text "Timeout form" ]
            , label [] [ text "Enter your Name:" ]
            , input
                [ value model.name
                , onInput UpdateName
                , disabled <| timeElapsed model.timeLeft
                ]
                []
            , p [] [ text ("Your entered Name is " ++ model.name) ]
            , p
                [ style
                    [ ( "color", timeLeftColor model.timeLeft )
                    , ( "font-weight", "bold" )
                    ]
                ]
                [ text ("Time left " ++ toString model.timeLeft) ]
            ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick
