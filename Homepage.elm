module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Navigation


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , update = update
        , urlUpdate = urlUpdate
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- URL PARSERS


toUrl : Maybe Location -> String
toUrl location =
    case location of
        Just Home ->
            "#/"

        Just Contact ->
            "#/contact"

        Nothing ->
            "#/"


fromUrl : String -> Maybe Location
fromUrl url =
    case url of
        "#/" ->
            Just Home

        "#/contact" ->
            Just Contact

        _ ->
            Nothing


urlParser : Navigation.Parser (Maybe Location)
urlParser =
    Navigation.makeParser (fromUrl << .hash)



-- MODEL


type alias Model =
    { location : Maybe Location }


init : Maybe Location -> ( Model, Cmd Msg )
init location =
    urlUpdate location { location = Just Home }


type Location
    = Home
    | Contact



-- UPDATE


type Msg
    = NoOp
    | GoBack


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GoBack ->
            model ! [ Navigation.back 1 ]

        NoOp ->
            model ! []


urlUpdate : Maybe Location -> Model -> ( Model, Cmd Msg )
urlUpdate location model =
    { model | location = location } ! []



-- VIEW


view : Model -> Html Msg
view model =
    case model.location of
        Nothing ->
            viewPage model viewPageNotFound

        Just location ->
            case location of
                Home ->
                    viewPage model viewHomepage

                Contact ->
                    viewPage model viewContact


viewPage : Model -> (Model -> Html Msg) -> Html Msg
viewPage model content =
    div []
        [ navigation model
        , content model
        , footer
        ]


footer : Html Msg
footer =
    Html.footer []
        [ button [ onClick GoBack ]
            [ text "Go Back" ]
        , p
            []
            [ text "Copyright 2016" ]
        ]


navigation : Model -> Html Msg
navigation model =
    ul []
        [ li []
            [ viewLinkTo Home ]
        , li
            []
            [ viewLinkTo Contact ]
        ]


viewLinkTo : Location -> Html Msg
viewLinkTo location =
    let
        title =
            case location of
                Home ->
                    "Home"

                Contact ->
                    "Contact"
    in
        a [ href (toUrl (Just location)) ] [ text title ]


viewHomepage : Model -> Html Msg
viewHomepage model =
    div []
        [ h1 []
            [ text "Hompage" ]
        , p
            []
            [ text "Welcome to my Homepage" ]
        ]


viewContact : Model -> Html Msg
viewContact model =
    div []
        [ h1 []
            [ text "Contact" ]
        , p
            []
            [ text "Send me a message" ]
        ]


viewPageNotFound : Model -> Html Msg
viewPageNotFound model =
    div []
        [ h1 []
            [ text "404" ]
        , p [] [ viewLinkTo Home ]
        ]
