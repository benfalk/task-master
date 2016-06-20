module App exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Random

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL
type alias Project =
  { name : String
  , id : Int
  }

type alias Model =
  { projects : List Project
  }

init : (Model, Cmd Msg)
init =
  (Model [], Cmd.none)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- UPDATE
type Msg
  = Add Project
  | Remove Project
  | Update Project


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Add project ->
      ({ model | projects = project :: model.projects }, Cmd.none)

    Remove project ->
      ({ model | projects = List.filter (\p -> p.id /= project.id) model.projects}, Cmd.none)

    Update project ->
      ({ model | projects = List.map (\p -> if p.id == project.id then project else p) model.projects}, Cmd.none)


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "Projects..." ]
    ]
