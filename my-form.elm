module Main exposing (..)

import Char exposing (isDigit)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String exposing (all, any, length, toLower, toUpper)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { name : String
    , age : String
    , password : String
    , passwordAgain : String
    , messageColor : String
    , message : String
    }


model : Model
model =
    Model "" "" "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Age age ->
            { model | age = age }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Submit ->
            if model.password /= model.passwordAgain then
                { model | messageColor = "red", message = "Passwords do not match!" }
            else if length model.password < 9 then
                { model | messageColor = "red", message = "Passwords must be longer than 8 characters!" }
            else if toLower model.password == model.password then
                { model | messageColor = "red", message = "Passwords must contain at least one upper case character!" }
            else if toUpper model.password == model.password then
                { model | messageColor = "red", message = "Passwords must contain at least one lower case character!" }
            else if not (any isDigit model.password) then
                { model | messageColor = "red", message = "Passwords must contain at least one numeric character!" }
            else if not (all isDigit model.age) then
                { model | messageColor = "red", message = "Age must contain only digits!" }
            else
                { model | messageColor = "green", message = "Like a baws!" }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input [ type_ "text", placeholder "Name", onInput Name ] []
            , input [ type_ "text", placeholder "Age", onInput Age ] []
            , input [ type_ "password", placeholder "Password", onInput Password ] []
            , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
            ]
        , button [ onClick Submit ] [ text "Submit" ]
        , div [ style [ ( "color", model.messageColor ) ] ] [ text model.message ]
        ]
