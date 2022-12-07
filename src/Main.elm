module Main exposing (..)

import Browser
import Html exposing (Html)
import Element exposing (..)
import Element.Border as Border
import Element.Background as Background


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
type alias Snake =
    { head:
        { rowIndex : RowIndex
        , cellIndex : CellIndex
        },
      body: List
        { rowIndex : RowIndex
        , cellIndex : CellIndex
        }
    }

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
                },
                body = [
                    { rowIndex = 5
                    , cellIndex = 4
                    },
                    { rowIndex = 6
                    , cellIndex = 4
                    }
                ]
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

update : msg -> Model -> (Model, Cmd msg)
update msg model =
    (model, Cmd.none)

putSnakeOnField : Snake -> Field -> Field
putSnakeOnField snake oldField =
    List.indexedMap (putSnakeOnRow snake) oldField

putSnakeOnRow : Snake -> RowIndex -> Row -> Row
putSnakeOnRow snake rowIndex oldRow =
    List.indexedMap (putSnakeOnCell snake rowIndex) oldRow

putSnakeOnCell : Snake -> RowIndex -> CellIndex -> Cell -> Cell
putSnakeOnCell snake rowIndex cellIndex oldCell =
    { color = 
        if (rowIndex == snake.head.rowIndex && cellIndex == snake.head.cellIndex ) 
            then (rgb255 100 200 0) 
            else
                if (rowIndex == snake.body.rowIndex && cellIndex == snake.body.cellIndex) 
                    then (rgb255 255 165 0)
            else 
                oldCell.color 
    }

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


-- SUBSCRIPTIONS

subscriptions : a -> Sub msg
subscriptions _ = Sub.none
