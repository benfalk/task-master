module App exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Dict exposing (Dict)
import WebSocket

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
  { projects : Dict.Dict Int Project
  }

init : (Model, Cmd Msg)
init =
  (Model Dict.empty, Cmd.none)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  (Debug.log "Connecting to websocket...")
  WebSocket.listen "ws://localhost:4000/socket/websocket" sub_to_msg

sub_to_msg sub =
  case sub of
    "add" ->
      Add (Project "test" 1)
    _ ->
      Debug.crash "This line is here to make it compile...."
      


-- UPDATE
type Msg
  = Add Project
  | Remove Project
  | Update Project


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Add project ->
      ({ model | projects = (Dict.insert project.id project model.projects)}, Cmd.none)

    Remove project ->
      ({ model | projects = (Dict.remove project.id model.projects)}, Cmd.none)

    Update project ->
      ({ model | projects = (Dict.insert project.id project model.projects)}, Cmd.none)


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "Projects..." ]
    ]
