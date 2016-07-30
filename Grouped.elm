module Main exposing (..)

import Html exposing (..)
import List.Extra exposing (unique)


-- MODEL


type alias Model =
    List Airport


type alias Airport =
    { country : String, name : String }


type alias CountryGroup =
    { country : String, airports : List Airport }


type alias ListCountryGroup =
    List CountryGroup


initialModel : Model
initialModel =
    [ { country = "Luxemburg", name = "Luxembourg Airport" }
    , { country = "Germany", name = "Aiport Hahn" }
    , { country = "Belgium", name = "Aiport Charleroi" }
    , { country = "Germany", name = "Frankfurt Airport" }
    , { country = "Belgium", name = "Aiport Bru" }
    ]


convertGroup : Model -> ListCountryGroup
convertGroup model =
    let
        countries =
            List.map (\e -> e.country) model |> unique

        airportIn country =
            List.filter (\x -> x.country == country) model
    in
        List.map (\c -> { country = c, airports = (airportIn c) }) countries



-- VIEW


view : Model -> Html a
view model =
    let
        listCountryGroup =
            convertGroup model
    in
        div [] (List.map (\e -> viewGroup e) listCountryGroup)


viewAirport : Airport -> Html a
viewAirport airport =
    li [] [ text (airport.country ++ ": " ++ airport.name) ]


viewGroup : CountryGroup -> Html a
viewGroup airportGroup =
    div []
        [ h1 [] [ text airportGroup.country ]
        , ul [] (List.map (\e -> (viewAirport e)) airportGroup.airports)
        ]


main : Html a
main =
    view initialModel
