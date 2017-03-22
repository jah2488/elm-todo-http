module Styles exposing (..)

import Html
import Html.Attributes
import Css exposing (..)


style : List Mixin -> Html.Attribute a
style =
    asPairs >> Html.Attributes.style


todoStyles : List Mixin
todoStyles =
    [ padding (px 12)
    , width (em 15)
    , textAlign center
    ]


wrapperStyles : List Mixin
wrapperStyles =
    [ displayFlex
    , alignItems center
    , justifyContent center
    , flexDirection column
    ]


rowStyles : List Mixin
rowStyles =
    [ displayFlex
    , flex (int 1)
    , justifyContent center
    , marginBottom (em 1)
    ]


textAreaStyles : List Mixin
textAreaStyles =
    [ padding2 (em 2) (em 1)
    , color (hex "#3b0101")
    , resize none
    , textShadow3 (px 0) (px 1) (rgba 59 1 1 0.2)
    , boxShadow5 inset (px 0) (px 0) (px 30) (rgba 59 1 1 0.2)
    , borderRadius (px 3)
    , property "background" "linear-gradient(to bottom, #d9d9d9 0%, #fffdef 5%, #fffdef 95%, #d9d9d9 100%)"
    , overflow hidden
    , marginBottom (em 0.25)
    ]


type alias ButtonStyle =
    List Mixin


btnPrimary : ButtonStyle
btnPrimary =
    buttonStyles (hex "#3498DB") (hex "2980B9")


btnDefault : ButtonStyle
btnDefault =
    buttonStyles (hex "#ACACAC") (hex "#9A9A9A")


buttonStyles : Color -> Color -> List Mixin
buttonStyles bgColor shadowColor =
    [ backgroundColor bgColor
    , margin2 (em 0.1) (em 0.5)
    , cursor pointer
    , property "user-select" "none"
    , padding2 (px 8) (px 30)
    , borderRadius (px 10)
    , borderBottom3 (px 5) solid shadowColor
    , textShadow3 (px 0) (px -2) shadowColor
    , color (rgb 255 255 255)
    , flex2 (int 1) (int 1)
    , textAlign center
    , minWidth (px 123)
    ]
