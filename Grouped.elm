module Main exposing (..)

import Html exposing (..)
import List.Extra


-- MODEL


type alias Model =
    List Airport


type alias Airport =
    { country : String, name : String }


type alias CountryGroup =
    { country : String, airports : List Airport }


initialModel : Model
initialModel =
    [ { country = "Luxemburg", name = "Luxembourg Airport" }
    , { country = "Germany", name = "Aiport Hahn" }
    , { country = "Belgium", name = "Aiport Charleroi" }
    , { country = "Germany", name = "Frankfurt Airport" }
    , { country = "Belgium", name = "Aiport Bru" }
    ]


groupByCountry : Model -> List CountryGroup
groupByCountry model =
    let
        airportIn country =
            List.filter (\x -> x.country == country) model
    in
        model
            |> List.map .country
            |> List.Extra.unique
            |> List.map (\c -> { country = c, airports = (airportIn c) })



-- VIEW


view : Model -> Html a
view model =
    let
        viewGroup airportGroup =
            div []
                [ h1 [] [ text airportGroup.country ]
                , ul [] (List.map viewAirport airportGroup.airports)
                ]

        viewAirport airport =
            li [] [ text (airport.country ++ ": " ++ airport.name) ]
    in
        groupByCountry model
            |> List.map viewGroup
            |> div []


main : Html a
main =
    view initialModel
