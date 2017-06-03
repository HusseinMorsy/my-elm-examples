module RandomCoin exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Random


main : Program Never Model Msg
main =
    Html.program { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { coin : Coin
    }


type Coin
    = Head
    | Tail


init : ( Model, Cmd Msg )
init =
    { coin = Head } ! []



-- UPDATE


type Msg
    = NoOp
    | FlibCoin
    | SetCoin Coin
    | RandomizeCoin


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FlibCoin ->
            { model | coin = switch model.coin } ! []

        SetCoin coin ->
            { model | coin = coin } ! []

        RandomizeCoin ->
            model ! [ Random.generate SetCoin coinGenerator ]

        NoOp ->
            model ! []



-- HELPERS


switch : Coin -> Coin
switch coin =
    case coin of
        Head ->
            Tail

        Tail ->
            Head


coinGenerator : Random.Generator Coin
coinGenerator =
    Random.map
        (\b ->
            if b then
                Head
            else
                Tail
        )
        Random.bool



--- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Random Coin" ]
        , viewCoin model.coin
        , button [ onClick FlibCoin ] [ text "flib coin" ]
        , button [ onClick RandomizeCoin ] [ text "randomize" ]
        ]


viewCoin : Coin -> Html Msg
viewCoin coin =
    case coin of
        Head ->
            text "Head"

        Tail ->
            text "Tail"
