module Main exposing (..)

import Browser
import Html exposing (Html)
import Element exposing (..)
import Element.Border as Border
import Element.Background as Background
import Time exposing (..)

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
    , snakeHeadX : Int
    , snakeHeadY : Int
    }

type Msg = Tick Time.Posix

init : () -> (Model, Cmd msg)
init _ =
    ({ x = 20
    , y = 20
    , snakeHeadX = 4
    , snakeHeadY = 4 
    }, 
    Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
   case msg of
     Tick newTime ->
       ( { model | snakeHeadX = model.snakeHeadX + 1 }
       , Cmd.none
       )


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
                List.indexedMap (\i _ -> fieldRow i model.x model.snakeHeadX) (List.repeat model.y cell)

cell : Element msg
cell = el [ Border.color <| rgb255 255 255 255, Border.width 2, Background.color <| rgb255 50 20 20, width (px 20), height (px 20) ] Element.none

foo : Int -> Int -> Int -> Element msg
foo xx yy xxSnake = el [ Border.color <| rgb255 255 255 255, Border.width 2, (if (xx == xxSnake) && (yy == 4) then Background.color <| rgb255 100 200 0 else Background.color <| rgb255 50 20 20), width (px 20), height (px 20) ] Element.none

fieldRow : Int -> Int -> Int -> Element msg
fieldRow m repeatX mSnake = Element.row [] (List.indexedMap (\j _ -> foo m j mSnake) (List.repeat repeatX cell))

subscriptions : a -> Sub Msg
subscriptions _ =
   Time.every 1000 Tick
   