module Sprite (..) where

import Html.Attributes exposing (..)
import Html exposing (..)


type alias Sprite a =
    { a
        | sheet : String
        , rows : Int
        , columns : Int
        , size : ( Int, Int )
        , frame : ( Int, Int )
    }


type alias Dope =
    List ( Int, Int )


render : Sprite a -> List Attribute -> List ( String, String ) -> Html
render { sheet, rows, columns, size, frame } attrs baseStyle =
    let
        px x = toString x ++ "px"

        ( sizeX, sizeY ) = size

        ( frameX, frameY ) = frame

        height = sizeY // rows

        width = sizeX // columns

        backgroundImage =
            ( "background-image", "url(" ++ sheet ++ ")" )

        backgroundPosition =
            let
                posX = frameX * width * -1 |> px

                posY = frameY * height * -1 |> px
            in
                ( "background-position", posY ++ " " ++ posX )

        style' =
            style
                <| backgroundImage
                :: ( "height", px height )
                :: ( "width", px width )
                :: ( "display", "block" )
                :: ( "background-repeat", "no-repeat" )
                :: backgroundPosition
                :: baseStyle
    in
        node "sprite" (style' :: attrs) []
