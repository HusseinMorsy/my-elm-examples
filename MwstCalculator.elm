module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import String


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { brutto : Float
    , netto : Float
    , steuersatz : Float
    , inputBrutto : String
    , inputNetto : String
    , inputSteuersatz : String
    }


initModel : Model
initModel =
    { brutto = 0.0
    , netto = 0.0
    , steuersatz = 19.0
    , inputBrutto = "0.0"
    , inputNetto = "0.0"
    , inputSteuersatz = "19"
    }



-- UPDATE


type Msg
    = ChangeNetto String
    | ChangeBrutto String
    | ChangeSteuersatz String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeNetto value ->
            let
                netto =
                    strToFloat value model.netto

                brutto =
                    nettoToBrutto model.steuersatz netto
            in
                { model | inputNetto = value, netto = netto, brutto = brutto, inputBrutto = toString brutto }

        ChangeBrutto value ->
            let
                brutto =
                    strToFloat value model.brutto

                netto =
                    bruttoToNetto model.steuersatz brutto
            in
                { model | inputBrutto = value, netto = netto, brutto = brutto, inputNetto = toString netto }

        ChangeSteuersatz value ->
            let
                steuersatz =
                    strToFloat value model.steuersatz

                brutto =
                    nettoToBrutto steuersatz model.netto
            in
                { model | inputSteuersatz = value, steuersatz = steuersatz, brutto = brutto, inputBrutto = toString brutto }


strToFloat : String -> Float -> Float
strToFloat str default =
    case String.toFloat str of
        Ok val ->
            val

        Err _ ->
            default


roundFloat : Int -> Float -> Float
roundFloat digits num =
    let
        factor =
            10 ^ (toFloat digits)
    in
        (toFloat (round (num * factor))) / factor


nettoToBrutto : Float -> Float -> Float
nettoToBrutto steuersatz netto =
    netto * (1 + steuersatz / 100) |> roundFloat 2


bruttoToNetto : Float -> Float -> Float
bruttoToNetto steuersatz brutto =
    brutto / (1 + steuersatz / 100) |> roundFloat 2



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Mehrwertsteuer-Rechner" ]
        , formField "Netto" model.inputNetto ChangeNetto
        , formField "Steuersatz" model.inputSteuersatz ChangeSteuersatz
        , formField "Brutto" model.inputBrutto ChangeBrutto
        ]


formField : String -> String -> (String -> Msg) -> Html Msg
formField labelStr valueField changeMsg =
    let
        labelStyle =
            Html.Attributes.style
                [ ( "display", "inline-block" )
                , ( "width", "7em" )
                , ( "font-weight", "bold" )
                , ( "margin", "5px" )
                ]
    in
        div
            []
            [ label [ labelStyle ] [ text labelStr ]
            , input [ onInput changeMsg, value valueField ] []
            ]
