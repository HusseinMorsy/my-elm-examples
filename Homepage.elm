module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App


main : Program Never
main =
    Html.App.program { init = ( initialModel, Cmd.none ), update = update, view = view, subscriptions = \_ -> Sub.none }



-- MODEL


type alias Model =
    { page : Page }


initialModel : Model
initialModel =
    { page = Home }


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
            Model page ! []



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
            [ a [ href "#1", onClick (ChangePage Home) ] [ text "Home" ] ]
        , li
            []
            [ a [ href "#1", onClick (ChangePage Contact) ] [ text "Contact" ] ]
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
