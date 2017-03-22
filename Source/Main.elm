module Main exposing (..)

import Http
import Json.Decode as JD
import Html exposing (Html, div, br, hr, h1, span, text, textarea)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Array exposing (Array)
import Todo exposing (..)
import Common exposing (..)
import Utils exposing (..)
import Styles exposing (..)


type alias Model =
    { todos : List Todo
    , filter : Filter
    , todoFormMessage : String
    }


init : Response Model
init =
    ( Model [] All "", getExistingTodos )



-- Update (API calls)


url : String
url =
    "http://tiny-za-server.herokuapp.com/collections/justin-elm/"


createTodo : Model -> Cmd Msg
createTodo model =
    let
        data =
            todoEncoder
                { id = Nothing
                , complete = False
                , body = model.todoFormMessage
                , dueIn = 0
                , important = False
                }
    in
        Http.post url (Http.jsonBody data) todoDecoder
            |> Http.send SavedTodo


updateTodo : Todo -> Cmd Msg
updateTodo todo =
    case todo.id of
        Just todoID ->
            Http.request
                { method = "put"
                , headers = []
                , url = url ++ todoID
                , body = (Http.jsonBody (todoEncoder todo))
                , expect = (Http.expectJson todoDecoder)
                , timeout = Nothing
                , withCredentials = False
                }
                |> Http.send UpdatedTodo

        Nothing ->
            Cmd.none


getExistingTodos : Cmd Msg
getExistingTodos =
    Http.get url (JD.array todoDecoder)
        |> Http.send LoadTodos


toggleComplete : Model -> Todo -> Bool -> Response Model
toggleComplete model todo bool =
    let
        updatedTodos =
            List.map
                (\current ->
                    if current.id == todo.id then
                        { current | complete = bool }
                    else
                        current
                )
                model.todos
    in
        ( { model | todos = updatedTodos }, updateTodo ({ todo | complete = bool }) )



-- Update (core)


update : Msg -> Model -> Response Model
update msg model =
    case msg of
        NoOp ->
            doNothing model

        ShowAll ->
            ( { model | filter = All }, Cmd.none )

        ShowIncomplete ->
            ( { model | filter = Incomplete }, Cmd.none )

        ShowComplete ->
            ( { model | filter = Complete }, Cmd.none )

        UpdateTodoForm string ->
            ( { model | todoFormMessage = string }, Cmd.none )

        UnFinishTodo todo ->
            toggleComplete model todo False

        FinishTodo todo ->
            toggleComplete model todo True

        ClearTodoForm ->
            ( { model | todoFormMessage = "" }, Cmd.none )

        SendTodoForm ->
            ( { model | todoFormMessage = "" }, createTodo model )

        SortTodo dir ->
            doNothing model

        LoadTodos (Ok todos) ->
            ( { model | todos = Array.toList todos }, Cmd.none )

        LoadTodos (Err err) ->
            doNothing model |> andLog err

        SavedTodo (Ok todo) ->
            ( { model | todos = (todo :: model.todos) }, Cmd.none )

        SavedTodo (Err err) ->
            doNothing model |> andLog err

        UpdatedTodo (Ok todo) ->
            doNothing model

        UpdatedTodo (Err err) ->
            doNothing model |> andLog err



-- Viewwwww


activeButton : Msg -> Bool -> Html Msg
activeButton msg isActive =
    if isActive then
        buttonBase msg btnPrimary
    else
        button msg


button : Msg -> Html Msg
button msg =
    buttonBase msg btnDefault


buttonBase : Msg -> ButtonStyle -> Html Msg
buttonBase msg styles =
    div [ style styles, onClick msg ] [ text <| asString msg ]


row : List (Html Msg) -> Html Msg
row html =
    div [ style rowStyles ] html


viewTodo : Todo -> Html Msg
viewTodo todo =
    let
        action =
            if todo.complete then
                UnFinishTodo
            else
                FinishTodo
    in
        row
            [ div
                [ style todoStyles ]
                [ text todo.body ]
            , button <| action todo
            ]


view : Model -> Html Msg
view model =
    div [ style wrapperStyles ]
        [ h1 [] [ text "My Todo List" ]
        , br [] []
        , textarea [ style textAreaStyles, onInput UpdateTodoForm, value model.todoFormMessage ] []
        , row
            [ button ClearTodoForm
            , button SendTodoForm
            ]
        , br [] []
        , row
            [ activeButton ShowAll (model.filter == All)
            , activeButton ShowComplete (model.filter == Complete)
            , activeButton ShowIncomplete (model.filter == Incomplete)
            ]
        , br [] []
        , div [] (List.map viewTodo (filteredTodos model))
        ]


filteredTodos : Model -> List Todo
filteredTodos model =
    case model.filter of
        All ->
            model.todos

        Incomplete ->
            List.filter (\todo -> todo.complete == False) model.todos

        Complete ->
            List.filter (\todo -> todo.complete == True) model.todos


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }
