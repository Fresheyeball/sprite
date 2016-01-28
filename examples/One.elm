module One (..) where

import Sprite exposing (..)
import Array
import Html exposing (..)
import Html.Events exposing (on, targetValue)
import Html.Attributes as A
import Effects exposing (Effects, none)
import Signal exposing (message, Address)
import Time exposing (Time, fps)
import StartApp


type Action
    = Tick Time


init : Sprite {}
init =
    { sheet = "https://10firstgames.files.wordpress.com/2012/02/actionstashhd.png"
    , rows = 16
    , columns = 16
    , size = ( 2048, 2048 )
    , frame = 0
    , dope = idle
    }


dopeRow : Int -> List ( Int, Int )
dopeRow y =
    List.map (\x -> ( x, y )) [0..15]


idle : Dope
idle =
    dopeRow 0 |> Array.fromList


view : Address Action -> Sprite {} -> Html
view address s =
    let
        onInput address contentToValue =
            on
                "input"
                targetValue
                (message address << contentToValue)
    in
        div
            []
            [ node
                "sprite"
                [ A.style (sprite s) ]
                []
            ]


update : Action -> Sprite {} -> ( Sprite {}, Effects Action )
update action s =
    let
        s' =
            case action of
                Tick _ ->
                    advance s
    in
        ( s', none )


app : StartApp.App (Sprite {})
app =
    StartApp.start
        { view = view
        , update = update
        , init = ( init, none )
        , inputs = [ Signal.map Tick (fps 30) ]
        }


main : Signal Html
main =
    app.html
