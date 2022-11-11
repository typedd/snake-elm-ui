module Main exposing (..)

import Browser
import Html exposing (Html)
import Element exposing (..)
import Element.Border as Border
import Element.Background as Background
import Time exposing (..)



-- MAIN
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


-- MODEL

type alias Cell =
    { color : Color
    }

type alias Row = List Cell
type alias Field = List Row
type alias RowIndex = Int
type alias CellIndex = Int

-- type Direction =
--       Up
--     | Down
--     | Left
--     | Right
type alias Snake =
    { head:
        { rowIndex : RowIndex
        , cellIndex : CellIndex
        }
      --, direction : Direction
    }


type Msg = Tick Time.Posix

type alias Model =
    { field : Field
    , snake : Snake
    }

defaultCell : Cell
defaultCell =
    { color = rgb255 50 20 20 }

init : () -> (Model, Cmd msg)
init _ =
    let snake =
            { head =
                { rowIndex = 4
                , cellIndex = 4
                }
            }
        field = List.repeat 20 (List.repeat 20 defaultCell)
    in
        (
            { field = putSnakeOnField snake field
            , snake = snake
            }
        , Cmd.none
        )


-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
     case msg of
         Tick _ -> 
          let snake = moveSnake model.snake
            
              field = List.repeat 20 (List.repeat 20 defaultCell)
          in
            (
              { field = putSnakeOnField snake field
              , snake = snake
              }
              , Cmd.none
            )
            
            
            
            
            
            -- ( { model | field = putSnakeOnField (moveSnake model.snake) model.field
            --   }
            --   , Cmd.none
            -- )

moveSnake : Snake -> Snake
moveSnake oldSnake = 
 --   if ( !gameOver ) then
        { head =
           { rowIndex = oldSnake.head.rowIndex
           , cellIndex = oldSnake.head.cellIndex + 1
           }
        }
  --   else ()

putSnakeOnField : Snake -> Field -> Field
putSnakeOnField snake oldField =
    List.indexedMap (putSnakeOnRow snake) oldField

putSnakeOnRow : Snake -> RowIndex -> Row -> Row
putSnakeOnRow snake rowIndex oldRow =
    List.indexedMap (putSnakeOnCell snake rowIndex) oldRow

putSnakeOnCell : Snake -> RowIndex -> CellIndex -> Cell -> Cell
putSnakeOnCell snake rowIndex cellIndex oldCell =
    { color = if (rowIndex == snake.head.rowIndex && cellIndex == snake.head.cellIndex ) then (rgb255 100 200 0) else oldCell.color }

-- gameOver : Snake -> Bool
-- gameOver snake = (snake.head.cellIndex == 20) || (snake.head.rowIndex == 20)

-- VIEW

view : Model -> Html msg
view model =
    layout
        [ width fill
        , height fill
        -- , Element.explain Debug.todo
        ]
    <|
        el
            [ centerX, centerY ]
        <|
            Element.column
                []
            <|
                viewField model.field

viewField : Field -> List (Element msg)
viewField field =
    List.map viewRow field

viewRow : Row -> Element msg
viewRow row =
    Element.row [] (List.map viewCell row)

viewCell : Cell -> Element msg
viewCell cell =
    el [ Border.color <| rgb255 255 255 255, Border.width 2, Background.color <| cell.color, width (px 20), height (px 20) ] Element.none

-- viewGameOver : Element msg
-- viewGameOver = text "GAME OVER"

-- SUBSCRIPTIONS

subscriptions : a -> Sub Msg
subscriptions model = 
    Time.every 1000 Tick
