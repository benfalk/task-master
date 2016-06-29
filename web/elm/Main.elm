module Main exposing (..)

import Navigation
import Html.App
import Dict exposing (Dict)
import Project.Models exposing (ProjectList)
import Project.Messages exposing (Msg(..))
import Project.Update exposing (update)
import Project.List exposing (view)

main =
  let
    init =
      ( ProjectList Dict.empty "", Cmd.none )
  in
    Html.App.program
      { init = init
      , view = view
      , update = update
      , subscriptions = (\_ -> Sub.none )
      }
