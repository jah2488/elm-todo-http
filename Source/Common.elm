module Common exposing (..)

import Http
import Array exposing (Array)
import Todo exposing (Todo)


type Filter
    = All
    | Incomplete
    | Complete


type Dir
    = ASC
    | DESC


type Msg
    = NoOp
    | UpdateTodoForm String
    | ClearTodoForm
    | SendTodoForm
    | SortTodo Dir
    | FinishTodo Todo
    | UnFinishTodo Todo
    | ShowAll
    | ShowIncomplete
    | ShowComplete
    | LoadTodos (Result Http.Error (Array Todo))
    | SavedTodo (Result Http.Error Todo)
    | UpdatedTodo (Result Http.Error Todo)


type alias Response a =
    ( a, Cmd Msg )
