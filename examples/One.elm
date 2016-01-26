module One (..) where

import Sprite exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes as A
import Effects exposing (..)
import StartApp exposing (..)
import Signal exposing (..)
import Time exposing (..)
import String


type Action
    = Tick Time
    | RowChange Int


init : Sprite {}
init =
    { sheet = "https://10firstgames.files.wordpress.com/2012/02/actionstashhd.png"
    , rows = 16
    , columns = 16
    , size = ( 2048, 2048 )
    , frame = ( 0, 0 )
    }


view : Address Action -> Sprite {} -> Html
view address s =
    let
        decodeIntToAction =
            String.toInt
                >> Result.withDefault 0
                >> RowChange
    in
        div
            []
            [ node
                "sprite"
                [ A.style (sprite s) ]
                []
            , label [] [ text "cycle through 16 animations on this sprite" ]
            , br [] []
            , input
                [ A.type' "number"
                , A.min "0"
                , (A.max <| toString <| s.rows - 1)
                , (A.value <| toString <| snd s.frame)
                , onInput address decodeIntToAction
                ]
                []
            ]


onInput : Signal.Address a -> (String -> a) -> Attribute
onInput address contentToValue =
    on "input" targetValue (Signal.message address << contentToValue)


update : Action -> Sprite {} -> ( Sprite {}, Effects Action )
update action s =
    let
        ( x, y ) = s.frame

        s' =
            case Debug.watch "action" action of
                Tick _ ->
                    { s | frame = ( (x + 1) % s.columns, y ) }

                RowChange row ->
                    { s | frame = ( x, row ) }
    in
        ( s', none )


app : App (Sprite {})
app =
    StartApp.start
        { view = view
        , update = update
        , init = ( init, none )
        , inputs = [ Signal.map Tick (fps 60) ]
        }


main : Signal Html
main =
    app.html



-- port tasks : Signal (Task Never ())
-- port tasks =
--     app.tasks
