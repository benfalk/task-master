module Project.Messages exposing (..)

import Project.Models exposing (ProjectItem, Project, ProjectId)

type Msg
  -- Messages that update state
  = ProjectAdded Project
  | ProjectRemoved ProjectId
  | ProjectUpdated Project
  -- Messages requesting updates to be made
  | UpdateNewName String
  | CreateProject Project
  | UpdateProject Project
  | RemoveProject ProjectId
