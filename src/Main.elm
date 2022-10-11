module Main exposing (..)

import Browser
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
view model =
    layout
        [ width fill
        , height fill
        --, Element.explain Debug.todo
        ]
    <|
        el
            [ centerX, centerY ]
        <|
            column
                []
            <|
                List.indexedMap (\i row -> foo i ) ((List.repeat model.x cell))

                -- List.indexedMap (\i row -> List.indexedMap (\j row2 -> foo i j) (List.repeat model.x cell)) 
                --     ((List.repeat model.y (List.repeat model.x cell)))

cell : Element msg
cell = el [ Border.color <| rgb255 255 255 255, Border.width 1, Background.color <| rgb255 50 20 20, width (px 20), height (px 20) ] Element.none

-- foo : Int -> Int -> Element msg
-- foo xx yy = el [ Border.color <| rgb255 255 255 255, Border.width 1, (if (xx == 5) && (yy == 5) then Background.color <| rgb255 150 20 20 else Background.color <| rgb255 50 20 20), width (px 20), height (px 20) ] Element.none

foo : Int -> Element msg
foo xx = el [ Border.color <| rgb255 255 255 255, Border.width 1, (if (xx == 5) then Background.color <| rgb255 150 20 20 else Background.color <| rgb255 50 20 20), width (px 20), height (px 20) ] Element.none


fieldRow : Int -> Element msg
fieldRow n = Element.row [] (List.repeat n cell)

subscriptions : a -> Sub msg
subscriptions _ = Sub.none






                --(List.repeat model.y (fieldRow model.x))
               --List.map (\i row -> List.indexedMap i List.repeat model.x foo(i)))

               --         List.map (\i -> foo(i)) (List.repeat model.x cell)

                --foo (i))) 
                 --   (List.repeat model.y (fieldRow model.x))
                
                ---(List.repeat model.x cell)

                --List.Index.Map (\i row -> List.Index.Map (\j cell -> foo i j row) (List.repeat model.y (fieldRow model.x)))