module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- import Html.Events exposing (onClick)

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


toUrl : Maybe Page -> String
toUrl page =
    case page of
        Just Home ->
            "#/"

        Just Contact ->
            "#/contact"

        Nothing ->
            "#/"


fromUrl : String -> Maybe Page
fromUrl url =
    case url of
        "#/" ->
            Just Home

        "#/contact" ->
            Just Contact

        _ ->
            Nothing


urlParser : Navigation.Parser (Maybe Page)
urlParser =
    Navigation.makeParser (fromUrl << .hash)



-- MODEL


type alias Model =
    { page : Maybe Page }


init : Maybe Page -> ( Model, Cmd Msg )
init page =
    urlUpdate page { page = Just Home }


type Page
    = Home
    | Contact



-- UPDATE


type Msg
    = ChangePage Page


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    -- ChangePage page ->
    --     Model page ! [ Navigation.newUrl (toUrl page) ]
    model ! []


urlUpdate : Maybe Page -> Model -> ( Model, Cmd Msg )
urlUpdate page model =
    { model | page = page } ! []



-- VIEW


view : Model -> Html Msg
view model =
    case model.page of
        Nothing ->
            viewPage model viewPageNotFound

        Just page ->
            case page of
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
    Html.footer [] [ text "Copyright 2016" ]


navigation : Model -> Html Msg
navigation model =
    ul []
        [ li []
            [ a [ href (toUrl (Just Home)) ] [ text "Home" ] ]
        , li
            []
            [ a [ href (toUrl (Just Contact)) ] [ text "Contact" ] ]
        ]


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
        , p [] [ a [ href (toUrl (Just Home)) ] [ text "Homepage" ] ]
        ]
