module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { dieFaceOne : Int
    , dieFaceTwo : Int
    }


type Msg
    = Roll
    | NewFaceOne Int
    | NewFaceTwo Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFaceOne (Random.int 1 6) )

        NewFaceOne newFace ->
            ( { model | dieFaceOne = newFace }, Random.generate NewFaceTwo (Random.int 1 6) )

        NewFaceTwo newFace ->
            ( { model | dieFaceTwo = newFace }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ img [ src <| "Images/DieFace" ++ toString model.dieFaceOne ++ ".jpg" ] []
        , img [ src <| "Images/DieFace" ++ toString model.dieFaceTwo ++ ".jpg" ] []
        , button [ onClick Roll ] [ text "Roll" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( Model 1 2, Cmd.none )
