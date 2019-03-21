module Main exposing (main)

{-| -}

import Browser
import Element exposing (centerX, centerY, image, rgba)
import Element.Background as Background
import Html exposing (Html)


-- import Element.Font as Font
-- import Element.Input
-- import Element.Lazy
-- main =
--     Element.layout
--         [ Background.color (rgba 0 0 0 1)
--         ]
--     <|
--         image
--             [ centerX, centerY ]
--             {src= "/Untitled.001.jpg", description= "Slide 1"}


type alias Model =
    (String, String)


type alias Flags =
    List (String, String)

type Msg
    = Noop

init : Flags -> ( Model, Cmd Msg )
init flags =
    ( List.head flags |> Maybe.withDefault ("none", "none") , Cmd.none )


view : Model -> Html Msg
view model =
    Element.layout
        [ Background.color (rgba 0 0 0 1)
        ]
    <|
        image
            [ centerX, centerY, Element.width Element.fill ]
            {src = model |> Tuple.second, description = "Slide " ++ (model |> Tuple.first)}

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
