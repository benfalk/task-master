module Project.List exposing (..)

import Dict
import Html exposing (Html, div, span, ul, li, button, text, input)
import Html.Attributes exposing (class, value)
import Html.Events exposing (onInput, onClick)
import Project.Models exposing (ProjectList, Project, new)
import Project.Messages exposing (Msg(..))

view : ProjectList -> Html Msg
view list =
  let
    new_name =
      list.new_name

    new_project =
      { new | name = new_name }

    project_list =
      Dict.values list.projects
  in
    div [ class "project-list" ]
      [ div [ class "new" ]
        [ input [ onInput UpdateNewName, value new_name ] []
        , button [ onClick (CreateProject new_project) ] [ text "Add Project" ]
        ]
      , ul [ class "projects" ]
        (List.map project_list_item project_list)
      ]

project_list_item : Project -> Html Msg
project_list_item project =
  let
    name =
      project.name

    item_count =
      Dict.values project.items |> List.length |> toString
  in
    li [ class "project-item" ]
      [ span [ class "name" ] [ text name]
      , span [ class "item-count" ] [ text item_count ]
      , button [ onClick (RemoveProject project.id) ] [ text "x" ]
      ]
