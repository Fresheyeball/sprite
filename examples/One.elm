module One (..) where

import Sprite exposing (..)
import Html exposing (Html, node)
import Html.Attributes exposing (style)
import Effects exposing (..)
import StartApp exposing (..)
import Task exposing (Task)
import Time exposing (..)


type Action
    = Tick Time


sample : Sprite {}
sample =
    { sheet = "https://10firstgames.files.wordpress.com/2012/02/actionstashhd.png"
    , rows = 16
    , columns = 16
    , size = ( 2048, 2048 )
    , frame = ( 0, 0 )
    }


view : Int -> Html
view i =
    node
        "sample"
        [ style
            <| sprite
                { sample | frame = ( i % sample.columns, 0 ) }
        ]
        []


update : Action -> Int -> ( Int, Effects Action )
update _ i =
    ( i + 1, none )


app : App Int
app =
    StartApp.start
        { view = always view
        , update = update
        , init = ( 0, none )
        , inputs = [ Signal.map Tick (fps 60) ]
        }


main : Signal Html
main =
    app.html


port tasks : Signal (Task Never ())
port tasks =
    app.tasks
