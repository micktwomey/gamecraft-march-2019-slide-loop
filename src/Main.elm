module Main exposing (main)

{-| -}

import Array
import Browser
import Element exposing (centerX, centerY, fill, image, rgba, width)
import Element.Background as Background
import Html exposing (Html)
import Keyboard exposing (Key(..))
import Keyboard.Arrows
import Time


sleepTime : Float
sleepTime =
    60000


type alias Slide =
    { name : String
    , src : String
    }


type alias Model =
    { slides : Array.Array Slide
    , currentSlide : Int
    , pressedKeys : List Key
    }


type alias Flags =
    List ( String, String )


type Msg
    = Tick Time.Posix
    | KeyMsg Keyboard.Msg


flagsToSlides : Flags -> Array.Array Slide
flagsToSlides flags =
    List.map (\flag -> Slide (Tuple.first flag) (Tuple.second flag)) flags
        |> Array.fromList


getNextSlide : Array.Array Slide -> Int -> Int
getNextSlide slides currentSlide =
    let
        nextSlide =
            currentSlide + 1
    in
    if nextSlide + 1 > Array.length slides then
        0

    else
        nextSlide


getPreviousSlide : Array.Array Slide -> Int -> Int
getPreviousSlide slides currentSlide =
    let
        previousSlide =
            currentSlide - 1
    in
    if previousSlide < 0 then
        Array.length slides - 1

    else
        previousSlide


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model (flagsToSlides flags) 0 [], Cmd.none )


view : Model -> Html Msg
view model =
    let
        currentSlide =
            model.slides |> Array.get model.currentSlide |> Maybe.withDefault (Slide "none" "none")
    in
    Element.layout
        [ Background.color (rgba 0 0 0 1) ]
    <|
        image
            [ centerX, centerY, width fill ]
            { src = currentSlide.src, description = "Slide " ++ currentSlide.name }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model | currentSlide = getNextSlide model.slides model.currentSlide }
            , Cmd.none
            )

        KeyMsg keyMsg ->
            let
                arrows =
                    Keyboard.Arrows.arrows model.pressedKeys

                nextSlide =
                    if arrows.x == -1 then
                        getPreviousSlide model.slides model.currentSlide

                    else if arrows.x == 1 then
                        getNextSlide model.slides model.currentSlide

                    else
                        model.currentSlide
            in
            ( { model | pressedKeys = Keyboard.update keyMsg model.pressedKeys, currentSlide = nextSlide }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map KeyMsg Keyboard.subscriptions
        , Time.every sleepTime Tick
        ]


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
