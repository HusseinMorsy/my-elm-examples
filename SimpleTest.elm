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
                , test "greater" <| assertEqual True (2 > 1)
                , test "lower" <| assertEqual False (2 < 1)
                , test "assert not equal" <| assertNotEqual 2 3
                  -- Failing:  max: FAILED. Expected: 2; got: 3
                , test "max" <| assertEqual 2 (max 2 3)
                , equals 2 2
                , 2 `equals` 2
                ]

        listTests =
            suite "Simple List functions"
                [ test "length" <| assertEqual 4 (List.length [ 1, 2, 3, 4 ])
                , test "isEmpty" <| assert (List.isEmpty [])
                , test "head" <| assertEqual (Just 1) (List.head [ 1, 2, 3 ])
                , test "tails" <| assertEqual (Just [ 2, 3, 4 ]) (List.tail [ 1, 2, 3, 4 ])
                , test "List.reverse" <|
                    assertEqual [ 3, 2, 1 ] (List.reverse [ 1, 2, 3 ])
                , test "Double reverse is identity" <|
                    let
                        list =
                            [ 1, 2, 3 ]
                    in
                        assertEqual list (List.reverse (List.reverse list))
                ]

        stringTests =
            suite "Simple String functions"
                [ test "isEmpty" <| assert (String.isEmpty "")
                , test "String.isEmpty" <| assert (String.isEmpty "")
                , test "reverse" <| assertEqual "CBA" (String.reverse "ABC")
                ]
    in
        suite "all Tests" [ mixedTests, listTests, stringTests ]


main : Program Never
main =
    runSuiteHtml tests
