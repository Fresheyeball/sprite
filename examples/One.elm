module One exposing (..)

import Sprite exposing (..)
import Array
import Html exposing (..)
import Html.Attributes as A
import Browser exposing (element)
import Time exposing (Posix, every)


type Msg
    = Tick Posix 


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
    List.range 0 15 |> List.map (\x -> ( x, y ))


idle : Dope
idle =
    dopeRow 0 |> Array.fromList


view : Sprite {} -> Html Msg
view s =
    div
        []
        [ node
            "sprite"
            (sprite s |> List.map (\(n, v) -> A.style n v)) 
            []
        ]


update : Msg -> Sprite {} -> ( Sprite {}, Cmd Msg)
update action s =
    let
        s_ =
            case action of
                Tick _ ->
                    advance s
    in
        ( s_, Cmd.none )

main : Program () (Sprite {}) Msg
main =
    element
        { init = always ( init, Cmd.none )
        , update = update
        , view = view
        , subscriptions = always <| every 33 Tick
        }
