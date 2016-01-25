module One (..) where

import Sprite exposing (..)
import Html exposing (Html)
import Time


sprite : Sprite {}
sprite =
    { sheet = "/examples/One.jpg"
    , rows = 1
    , columns = 10
    , size = ( 300, 25 )
    , frame = ( 0, 0 )
    }


main : Signal Html
main =
    let
        f _ ( i, _ ) =
            ( i + 1
            , render
                { sprite | frame = ( 0, i % (sprite.columns + 2) ) }
                []
                []
            )
    in
        Signal.foldp f ( 0, Html.div [] [] ) (Time.fps 2)
            |> Signal.map snd



-- main : Html
-- main =
--     render sprite [] []
