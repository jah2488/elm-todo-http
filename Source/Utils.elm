module Utils exposing (..)

import Common exposing (..)


asString : Msg -> String
asString msg =
    case msg of
        ClearTodoForm ->
            "Clear"

        SendTodoForm ->
            "Submit"

        SortTodo dir ->
            case dir of
                ASC ->
                    "Sort <"

                DESC ->
                    "Sort >"

        FinishTodo _ ->
            "Finish"

        UnFinishTodo _ ->
            "Restart"

        ShowAll ->
            "Show All"

        ShowIncomplete ->
            "Show Incomplete"

        ShowComplete ->
            "Show Complete"

        _ ->
            "Nothing"


andLog : a -> b -> b
andLog a b =
    let
        z =
            Debug.log "Debug ->" a
    in
        b


doNothing : a -> Response a
doNothing model =
    ( model, Cmd.none )
