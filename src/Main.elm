module Main exposing (..)

import Browser
import Html exposing (Html)
import Element exposing (..)
import Element.Border as Border
import Element.Background as Background

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

update : msg -> Model -> (Model, Cmd msg)
update msg model =
    (model, Cmd.none)

view : Model -> Html msg
view model =
    layout
        [ width fill
        , height fill
        -- , Element.explain Debug.todo
        ]
    <|
        el
            [ centerX, alignBottom ]
        <|
            column
                []
            <|
                List.indexedMap (\i _ -> fieldRow i model.x) (List.repeat model.y cell)

cell : Element msg
cell = el [ Border.color <| rgb255 255 255 255, Border.width 2, Background.color <| rgb255 50 20 20, width (px 20), height (px 20) ] Element.none

foo : Int -> Int -> Element msg
foo xx yy = el [ Border.color <| rgb255 255 255 255, Border.width 2, (if (xx == 4) && (yy == 4) then Background.color <| rgb255 150 20 20 else Background.color <| rgb255 50 20 20), width (px 20), height (px 20) ] Element.none

fieldRow : Int -> Int -> Element msg
fieldRow m repeatX = Element.row [] (List.indexedMap (\j _ -> foo m j) (List.repeat repeatX cell))

subscriptions : a -> Sub msg
subscriptions _ = Sub.none
