module Main exposing (..)

import Char exposing (isDigit)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
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
    }


model : Model
model =
    Model "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String


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



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "text", placeholder "Age", onInput Age ] []
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []

        -- , [ button [ onClick Submit ] [ text "Submit" ]
        -- TODO only show messages when submitted!
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    let
        ( color, message ) =
            if model.password /= model.passwordAgain then
                ( "red", "Passwords do not match!" )
            else if length model.password < 9 then
                ( "red", "Passwords must be longer than 8 characters!" )
            else if toLower model.password == model.password then
                ( "red", "Passwords must contain at least one upper case character!" )
            else if toUpper model.password == model.password then
                ( "red", "Passwords must contain at least one lower case character!" )
            else if not (any isDigit model.password) then
                ( "red", "Passwords must contain at least one numeric character!" )
            else if not (all isDigit model.age) then
                ( "red", "Age must contain only digits!" )
            else
                ( "green", "OK" )
    in
    div [ style [ ( "color", color ) ] ] [ text message ]
