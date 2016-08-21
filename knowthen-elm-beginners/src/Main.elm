module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (onInput, onSubmit, onClick)
import Html.Attributes exposing (..)
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
    { players : List Player
    , name : String
    , playerId : Maybe Int
    , plays : List Play
    }


type alias Player =
    { id : Int, name : String, points : Int }


type alias Play =
    { id : Int, playerId : Int, name : String, points : Int }


initialModel : Model
initialModel =
    { players = []
    , name = ""
    , playerId = Nothing
    , plays = []
    }



-- UPDATE


type Msg
    = Input String
    | Edit Player
    | Save
    | Cancel
    | Score Player Int
    | DeletePlay Play


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input str ->
            { model | name = str }

        Save ->
            if String.isEmpty model.name then
                model
            else
                save model

        Cancel ->
            { model | name = "", playerId = Nothing }

        Edit player ->
            { model | playerId = Just player.id, name = player.name }

        Score player points ->
            score model player points

        DeletePlay play ->
            deletePlay model play


save : Model -> Model
save model =
    case model.playerId of
        Nothing ->
            add model

        Just id ->
            edit model id


edit : Model -> Int -> Model
edit model id =
    let
        changeName item =
            if item.id == id then
                { item | name = model.name }
            else
                item
    in
        { model
            | players = (List.map changeName model.players)
            , plays = (List.map changeName model.plays)
            , name = ""
            , playerId = Nothing
        }


add : Model -> Model
add model =
    let
        player =
            Player nextPlayerId model.name 0

        nextPlayerId =
            1 + List.length model.players
    in
        { model
            | name = ""
            , players = (player) :: model.players
        }


score : Model -> Player -> Int -> Model
score model player points =
    let
        changePoints currentPlayer =
            if currentPlayer.id == player.id then
                { currentPlayer | points = currentPlayer.points + points }
            else
                currentPlayer
    in
        { model
            | players = List.map changePoints model.players
            , plays = (addPlay player points model.plays)
        }


addPlay : Player -> Int -> List Play -> List Play
addPlay player points plays =
    let
        nextPlayId =
            1 + List.length plays
    in
        { id = nextPlayId, playerId = player.id, name = player.name, points = points } :: plays


deletePlay : Model -> Play -> Model
deletePlay model play =
    let
        reducePoints currentPlayer =
            if currentPlayer.id == play.playerId then
                { currentPlayer | points = currentPlayer.points - play.points }
            else
                currentPlayer
    in
        { model
            | players = List.map reducePoints model.players
            , plays = List.filter (\p -> p.id /= play.id) model.plays
        }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "Score Keeper" ]
        , viewPlayerSection model
        , playerForm model
        , viewPlaySection model
        , viewDebug model
        ]


viewPlayerSection : Model -> Html Msg
viewPlayerSection model =
    div []
        [ viewPlayerListHeader
        , viewPlayerList model
        , viewPointTotal model
        ]


viewPlayerListHeader : Html Msg
viewPlayerListHeader =
    viewHeader "Name" "Points"


viewHeader : String -> String -> Html Msg
viewHeader column1 column2 =
    header []
        [ div [] [ text column1 ]
        , div [] [ text column2 ]
        ]


viewPlayerList : Model -> Html Msg
viewPlayerList model =
    model.players
        |> List.sortBy .name
        |> List.map (viewPlayer model.playerId)
        |> ul []


viewPlayer : Maybe Int -> Player -> Html Msg
viewPlayer playerId player =
    let
        isEditMode =
            case playerId of
                Just id ->
                    id == player.id

                Nothing ->
                    False
    in
        li []
            [ i [ class "edit", onClick <| Edit player ] []
            , div [ classList [ ( "edit", isEditMode ) ] ] [ text player.name ]
            , button [ type' "button", onClick (Score player 2) ] [ text "2pt" ]
            , button [ type' "button", onClick (Score player 3) ] [ text "3pt" ]
            , div [] [ text <| toString player.points ]
            ]


viewPointTotal : Model -> Html Msg
viewPointTotal model =
    let
        totalPoints =
            List.map .points model.players
                |> List.sum
    in
        footer []
            [ div [] [ text "Total:" ]
            , div [] [ text <| toString totalPoints ]
            ]


viewDebug : Model -> Html Msg
viewDebug model =
    div []
        [ hr [] []
        , text <| toString model
        ]


playerForm : Model -> Html Msg
playerForm model =
    let
        isEditMode =
            case model.playerId of
                Just _ ->
                    True

                Nothing ->
                    False
    in
        Html.form [ onSubmit Save ]
            [ input
                [ onInput Input
                , placeholder "Please enter the player name"
                , value model.name
                , classList [ ( "edit", isEditMode ) ]
                ]
                []
            , button [ type' "submit" ] [ text "Save" ]
            , button [ type' "button", onClick Cancel ] [ text "Cancel" ]
            ]


viewPlaySection : Model -> Html Msg
viewPlaySection model =
    div []
        [ viewPlayListHeader
        , viewPlayList model.plays
        ]


viewPlayListHeader : Html Msg
viewPlayListHeader =
    viewHeader "Plays" "Points"


viewPlayList : List Play -> Html Msg
viewPlayList plays =
    plays
        |> List.map viewPlay
        |> ul []


viewPlay : Play -> Html Msg
viewPlay play =
    li []
        [ i [ class "remove", onClick <| DeletePlay play ] []
        , div [] [ text play.name ]
        , div [] [ text <| toString play.points ]
        ]
