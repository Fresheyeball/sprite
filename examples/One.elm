module One exposing (..)

import Sprite exposing (..)
import Array
import Html.Attributes as A
import Html exposing (..)
import Time exposing (Time, every, millisecond)


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
    List.map (\x -> ( x, y )) (List.range 0 15)


idle : Dope
idle =
    dopeRow 0 |> Array.fromList


view : Sprite {} -> Html Action
view s =
    div
        []
        [ node
            "sprite"
            [ A.style (sprite s) ]
            []
        ]


update : Action -> Sprite {} -> ( Sprite {}, Cmd Action )
update action s =
    let
        newS =
            case action of
                Tick _ ->
                    advance s
    in
        ( newS, Cmd.none )


main : Program Never (Sprite {}) Action
main =
    program
        { init = ( init, Cmd.none )
        , update = update
        , view = view
        , subscriptions = always <| every (millisecond * 33) Tick
        }
