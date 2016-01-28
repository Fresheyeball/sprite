module Sprite (..) where

import Array exposing (Array)


type alias Sprite a =
    { a
        | sheet : String
        , rows : Int
        , columns : Int
        , size : ( Int, Int )
        , frame : Int
        , dope : Dope
    }


type alias Dope =
    Array ( Int, Int )


sprite : Sprite a -> List ( String, String )
sprite { sheet, rows, columns, size, dope, frame } =
    let
        px x = toString x ++ "px"

        ( sizeX, sizeY ) = size

        ( frameX, frameY ) =
            case Array.get frame dope of
                Nothing ->
                    ( 0, 0 )

                Just x ->
                    x

        height = sizeY // rows

        width = Debug.log "width" <| sizeX // columns

        backgroundImage =
            ( "background-image", "url(" ++ sheet ++ ")" )

        backgroundPosition =
            let
                posX = frameX * width * -1 |> px

                posY = frameY * height * -1 |> px
            in
                ( "background-position", posX ++ " " ++ posY )
    in
        backgroundImage
            :: ( "height", px height )
            :: ( "width", px width )
            :: ( "display", "block" )
            :: ( "background-repeat", "no-repeat" )
            :: backgroundPosition
            :: []
