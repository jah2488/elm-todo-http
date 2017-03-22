module Todo exposing (..)

import Json.Encode as JE
import Json.Decode as JD
import Json.Decode.Extra exposing ((|:))

type alias Todo =
    { id : Maybe String
    , body : String
    , dueIn : Int
    , complete : Bool
    , important : Bool
    }


todoEncoder : Todo -> JE.Value
todoEncoder todo =
    JE.object
        [ ( "body", JE.string todo.body )
        , ( "dueIn", JE.int todo.dueIn )
        , ( "complete", JE.bool todo.complete )
        , ( "important", JE.bool todo.important )
        ]


todoDecoder : JD.Decoder Todo
todoDecoder =
    JD.succeed Todo
        |: (JD.field "_id" (JD.maybe JD.string))
        |: (JD.field "body" JD.string)
        |: (JD.field "dueIn" JD.int)
        |: (JD.field "complete" JD.bool)
        |: (JD.field "important" JD.bool)
