module Project.Update exposing (..)

import Project.Models exposing (..)
import Project.Messages exposing (Msg(..))
import Dict exposing (Dict)

update : Msg -> ProjectList -> ( ProjectList, Cmd Msg )
update msg model =
  case msg of
    ProjectAdded project ->
      { model | projects = Dict.insert project.id project model.projects } ! []

    ProjectUpdated project ->
      { model | projects = Dict.insert project.id project model.projects } ! []

    ProjectRemoved id ->
      { model | projects = Dict.remove id model.projects } ! []

    UpdateNewName name ->
      { model | new_name = name } ! []

    CreateProject project ->
      let
        model' =
          { model | new_name = "" }

        next_id =
          case (Dict.keys model.projects |> List.maximum) of
            Just num ->
              num + 1

            Nothing ->
              1
        
        project' =
          { project | id = next_id }
      in
        update (ProjectAdded project') model'

    RemoveProject id ->
      update (ProjectRemoved id) model

    _ ->
      model ! []
