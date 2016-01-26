module One (..) where

import Sprite exposing (..)
import Html exposing (Html, node)
import Html.Attributes exposing (style)
import Time


sample : Sprite {}
sample =
    { sheet = "https://10firstgames.files.wordpress.com/2012/02/actionstashhd.png"
    , rows = 16
    , columns = 16
    , size = ( 2048, 2048 )
    , frame = ( 0, 0 )
    }


main : Signal Html
main =
    let
        sprite' i =
            node
                "sample"
                [ style
                    <| sprite
                        { sample | frame = ( i % sample.columns, 0 ) }
                ]
                []

        f _ ( i, _ ) =
            ( i + 1
            , Html.div [] (List.map (always (sprite' i)) [0..10])
            )
    in
        Signal.foldp f ( 0, Html.div [] [] ) (Time.fps 60)
            |> Signal.map snd



-- main : Html
-- main =
--     render sprite [] []
