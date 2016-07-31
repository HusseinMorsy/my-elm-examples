-- Example.elm


module Main exposing (..)

import ElmTest exposing (..)
import String


listTests =
    suite "List Test Suite"
        [ test "List.Length" (assertEqual (List.length [ 1, 2, 3, 4 ]) 4)
        , test "List.isEmpty" <| assert (List.isEmpty [])
        , test "List.head" <| assertEqual (List.head [ 1, 2, 3 ]) (Just 1)
          -- Failing:
        , equals (List.tail [ 1, 2, 3, 4 ]) (Just [ 2, 3 ])
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
    suite "String Test Suite"
        [ defaultTest <| assert (String.isEmpty "")
        , test "String.isEmpty" <| assert (String.isEmpty "")
        , (String.reverse "ABC") `equals` "CBA"
        ]


tests =
    suite "all Tests" [ listTests, stringTests ]


main : Program Never
main =
    runSuite tests
