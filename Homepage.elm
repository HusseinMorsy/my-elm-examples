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


toUrl : Page -> String
toUrl page =
    case page of
        Home ->
            "#/"

        Contact ->
            "#/contact"


fromUrl : String -> Page
fromUrl url =
    let
        _ =
            Debug.log "url: " url
    in
        case url of
            "#/" ->
                Home

            "#/contact" ->
                Contact

            _ ->
                Home


urlParser : Navigation.Parser Page
urlParser =
    Navigation.makeParser (fromUrl << .hash)



-- MODEL


type alias Model =
    { page : Page }


init : Page -> ( Model, Cmd Msg )
init page =
    urlUpdate page { page = Home }


type Page
    = Home
    | Contact



-- UPDATE


type Msg
    = ChangePage Page


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePage page ->
            Model page ! [ Navigation.newUrl (toUrl page) ]


urlUpdate : Page -> Model -> ( Model, Cmd Msg )
urlUpdate page model =
    { model | page = page } ! []



-- VIEW


view : Model -> Html Msg
view model =
    case model.page of
        Home ->
            viewPage model homepage

        Contact ->
            viewPage model contact


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
            [ a [ href (toUrl Home) ] [ text "Home" ] ]
        , li
            []
            [ a [ href (toUrl Contact) ] [ text "Contact" ] ]
        ]


homepage : Model -> Html Msg
homepage model =
    div []
        [ h1 []
            [ text "Hompage" ]
        , p
            []
            [ text "Welcome to my Homepage" ]
        ]


contact : Model -> Html Msg
contact model =
    div []
        [ h1 []
            [ text "Contact" ]
        , p
            []
            [ text "Send me a message" ]
        ]
