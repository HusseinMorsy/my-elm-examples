module Example exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, string)


suite : Test
suite =
    describe "varous tests"
        [ describe "String tests"
            [ test "reverses a string" <|
                \_ ->
                    "Hello World"
                        |> String.reverse
                        |> Expect.equal "dlroW olleH"
            , test "empty string" <|
                \_ ->
                    ""
                        |> String.isEmpty
                        |> Expect.true "Expected empty string"
            ]
        , describe "List tests"
            [ test "length" <|
                \_ ->
                    [ 1, 2, 3, 4 ]
                        |> List.length
                        |> Expect.equal 4
            , test "isEmpty" <|
                \_ ->
                    []
                        |> List.isEmpty
                        |> Expect.true "Exepcted empty string"
            , test "head" <|
                \_ ->
                    [ 1, 2, 3 ]
                        |> List.head
                        |> Expect.equal (Just 1)
            , test "tail" <|
                \_ ->
                    [ 1, 2, 3 ]
                        |> List.tail
                        |> Expect.equal (Just [ 2, 3 ])
            , test "reverse" <|
                \_ ->
                    [ 1, 2, 3 ]
                        |> List.reverse
                        |> Expect.equal [ 3, 2, 1 ]
            ]
        , describe "fuzzy tests"
            [ fuzz string "double reverse string" <|
                \randomString ->
                    randomString
                        |> String.reverse
                        |> String.reverse
                        |> Expect.equal randomString
            ]
        ]
