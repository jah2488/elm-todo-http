module Styles exposing (..)

import Html
import Html.Attributes
import Css exposing (..)


style : List Css.Mixin -> Html.Attribute a
style =
    Css.asPairs >> Html.Attributes.style


todoStyles : List Css.Mixin
todoStyles =
    [ Css.padding (Css.px 12)
    , Css.width (Css.em 15)
    , Css.textAlign Css.center
    ]


wrapperStyles : List Css.Mixin
wrapperStyles =
    [ Css.displayFlex
    , Css.alignItems Css.center
    , Css.justifyContent Css.center
    , Css.flexDirection Css.column
    ]


rowStyles : List Css.Mixin
rowStyles =
    [ Css.displayFlex
    , Css.flex (Css.int 1)
    , Css.justifyContent Css.center
    , Css.marginBottom (Css.em 1)
    ]


textAreaStyles : List Css.Mixin
textAreaStyles =
    [ Css.padding2 (Css.em 2) (Css.em 1)
    , Css.color (Css.hex "#3b0101")
    , Css.resize Css.none
    , Css.textShadow3 (Css.px 0) (Css.px 1) (Css.rgba 59 1 1 0.2)
    , Css.boxShadow5 Css.inset (Css.px 0) (Css.px 0) (Css.px 30) (Css.rgba 59 1 1 0.2)
    , Css.borderRadius (Css.px 3)
    , Css.property "background" "linear-gradient(to bottom, #d9d9d9 0%, #fffdef 5%, #fffdef 95%, #d9d9d9 100%)"
    , Css.overflow Css.hidden
    , Css.marginBottom (Css.em 0.25)
    ]


type alias ButtonStyle =
    List Css.Mixin


btnPrimary : ButtonStyle
btnPrimary =
    buttonStyles (Css.hex "#3498DB") (Css.hex "2980B9")


btnDefault : ButtonStyle
btnDefault =
    buttonStyles (Css.hex "#ACACAC") (Css.hex "#9A9A9A")


buttonStyles : Css.Color -> Css.Color -> List Css.Mixin
buttonStyles bgColor shadowColor =
    [ Css.backgroundColor bgColor
    , Css.margin2 (Css.em 0.1) (Css.em 0.5)
    , Css.cursor Css.pointer
    , Css.property "user-select" "none"
    , Css.padding2 (Css.px 8) (Css.px 30)
    , Css.borderRadius (Css.px 10)
    , Css.borderBottom3 (Css.px 5) Css.solid shadowColor
    , Css.textShadow3 (Css.px 0) (Css.px -2) shadowColor
    , Css.color (Css.rgb 255 255 255)
    , Css.flex2 (Css.int 1) (Css.int 1)
    , Css.textAlign Css.center
    , Css.minWidth (Css.px 123)
    ]
