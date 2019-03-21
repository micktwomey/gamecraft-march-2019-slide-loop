module Main exposing (main)

{-| -}

import Array
import Browser
import Element exposing (centerX, centerY, fill, image, rgba, width)
import Element.Background as Background
import Html exposing (Html)


type alias Slide =
    { name : String
    , src : String
    }


type alias Model =
    { slides : Array.Array Slide
    , currentSlide : Int
    }


type alias Flags =
    List ( String, String )


type Msg
    = Noop


flagsToSlides : Flags -> Array.Array Slide
flagsToSlides flags =
    List.map (\flag -> Slide (Tuple.first flag) (Tuple.second flag)) flags
        |> Array.fromList


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model (flagsToSlides flags) 0, Cmd.none )


view : Model -> Html Msg
view model =
    let
        currentSlide =
            model.slides |> Array.get model.currentSlide |> Maybe.withDefault (Slide "none" "none")
    in
    Element.layout
        []
    <|
        image
            [ centerX, centerY, width fill ]
            { src = currentSlide.src, description = "Slide " ++ currentSlide.name }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


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
