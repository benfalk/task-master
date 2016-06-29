module Project.Models exposing (..)

import Dict exposing (Dict)

type alias ProjectId =
  Int

type alias ProjectItemId =
  Int

type alias ProjectItem =
  { id : ProjectItemId
  , title : String
  , description : String
  , size : Maybe Int
  }

type alias Project =
  { id : ProjectId
  , name : String
  , items : Dict ProjectItemId ProjectItem
  }

type alias ProjectDict =
  Dict ProjectId Project

type alias ProjectList =
  { projects : ProjectDict
  , new_name : String
  }

new : Project
new =
  { id = 0
  , name = ""
  , items = Dict.empty
  }
