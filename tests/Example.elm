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
            , test "toInt success" <|
                \_ ->
                    "24"
                        |> String.toInt
                        |> Expect.equal (Ok 24)
            , test "toInt failure" <|
                \_ ->
                    "24X"
                        |> String.toInt
                        |> Expect.equal (Err "could not convert string '24X' to an Int")
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
