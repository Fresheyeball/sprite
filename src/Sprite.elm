module Sprite (..) where

{-|
A few simple things for Sprite rendering with elm-html.

Usage is intended to be via the `sprite` function generating
styles for `Html.Attributes.style`. For example

```
node
    "sprite"
    [ style (sprite s) ]
    []
```

@docs Sprite, Dope, sprite, advance, advanceClamp

-}

import Array exposing (Array)


{-|
A sprite sheet
-}
type alias Sprite a =
    { a
        | sheet : String
        , rows : Int
        , columns : Int
        , size : ( Int, Int )
        , frame : Int
        , dope : Dope
    }


{-|
The ordered frame cordinates representing an animation
-}
type alias Dope =
    Array ( Int, Int )


{-|
Process a sprite into styles for application with
`elm-html`. Styles place the sprite sheet as a `background-image`
and animate by altering the `background-position`. `height`, `width`
are used for sizing, along with `display:block` for custom nodes.
-}
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

        width = sizeX // columns

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


{-|
Move the sprite forward one frame, such that it will loop when it reaches the end
-}
advance : Sprite a -> Sprite a
advance s =
    { s | frame = (s.frame + 1) % Array.length s.dope }


{-|
Move the sprite forward one frame, such that it will stop when it reaches the end
-}
advanceClamp : Sprite a -> Sprite a
advanceClamp s =
    { s
        | frame =
            let
                len = Array.length s.dope - 1
            in
                if
                    s.frame >= len
                then
                    len
                else
                    s.frame + 1
    }
