module Main exposing (..)

import Browser
import Html exposing (Html)
import Element exposing (..)
import Element.Border as Border
import Element.Background as Background
import Html.Attributes exposing (list)

main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

type alias Model =
    { x : Int
    , y : Int
    }

init : () -> (Model, Cmd msg)
init _ =
    ({ x = 20, y = 20 }, Cmd.none)

xy : Model
xy = {x = 20, y = 20}

update : msg -> Model -> (Model, Cmd msg)
update msg model =
    (model, Cmd.none)

view : Model -> Html msg
view model =
    layout
        [ width fill
        , height fill
        , Element.explain Debug.todo
        ]
    <|
        el
            [ centerX, centerY ]
        <|
            column
                []
            <|
                (List.repeat xy.y fieldRow)
                
cell : Element msg
cell = el [ Border.color <| rgb255 255 255 255, Border.width 1, Background.color <| rgb255 50 20 20, width (px 20), height (px 20) ] Element.none

fieldRow : Element msg
fieldRow = Element.row [] (List.repeat xy.x cell)

subscriptions : a -> Sub msg
subscriptions _ = Sub.none
