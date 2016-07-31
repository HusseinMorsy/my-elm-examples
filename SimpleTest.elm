-- Example.elm


module Main exposing (..)

import ElmTest exposing (..)
import String


tests : ElmTest.Test
tests =
    let
        mixedTests =
            suite "diffrent varients of tests"
                [ test "assert" (assert (2 > 1))
                , test "with pipe" <| assert (2 > 1)
                , test "assert equal" <| assertEqual (2 + 1) 3
                , test "assert not equal" <| assertNotEqual 2 3
                  -- Failing:
                , test "assert equal" <| assertEqual 2 3
                , equals 2 2
                , 2 `equals` 2
                ]

        listTests =
            suite "Simple List functions"
                [ test "length" <| assertEqual (List.length [ 1, 2, 3, 4 ]) 4
                , test "isEmpty" <| assert (List.isEmpty [])
                , test "head" <| assertEqual (List.head [ 1, 2, 3 ]) (Just 1)
                , test "tails" <| assertEqual (List.tail [ 1, 2, 3, 4 ]) (Just [ 2, 3, 4 ])
                , test "List.reverse" <|
                    assertEqual (List.reverse [ 1, 2, 3 ]) [ 3, 2, 1 ]
                , test "Double reverse is identity" <|
                    let
                        list =
                            [ 1, 2, 3 ]
                    in
                        assertEqual (List.reverse (List.reverse list)) list
                ]

        stringTests =
            suite "Simple String functions"
                [ test "isEmpty" <| assert (String.isEmpty "")
                , test "String.isEmpty" <| assert (String.isEmpty "")
                , test "reverse" <| assertEqual (String.reverse "ABC") "CBA"
                ]
    in
        suite "all Tests" [ mixedTests, listTests, stringTests ]


main : Program Never
main =
    runSuiteHtml tests
