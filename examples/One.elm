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
        sprite' i =
            render
                { sprite | frame = ( i % sprite.columns, 0 ) }
                []
                []

        f _ ( i, _ ) =
            ( i + 1
            , Html.div [] (List.map (always (sprite' i)) [0..3000])
            )
    in
        Signal.foldp f ( 0, Html.div [] [] ) (Time.fps 60)
            |> Signal.map snd



-- main : Html
-- main =
--     render sprite [] []
