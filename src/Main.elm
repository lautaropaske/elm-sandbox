module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Random
import Time



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { card1 : Card
    , card2 : Card
    , card3 : Card
    }



-- Tipos estructurados


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model King Ace King
    , Cmd.none
    )


type Card
    = Ace
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten
    | Jack
    | Queen
    | King
    | DPOI



-- UPDATE


type Msg
    = DrawCard1
    | DrawCard2
    | DrawCard3
    | NewCard1 Card
    | NewCard2 Card
    | NewCard3 Card


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DrawCard1 ->
            ( model
            , Random.generate NewCard1 cardGenerator
            )

        DrawCard2 ->
            ( model
            , Random.generate NewCard2 cardGenerator
            )

        NewCard1 newCard1 ->
            ( { model
                | card1 = newCard1
              }
            , Cmd.none
            )

        NewCard2 newCard2 ->
            ( { model
                | card2 = newCard2
              }
            , Cmd.none
            )

        NewCard3 newCard3 ->
            ( { model
                | card3 = newCard3
              }
            , Cmd.none
            )

        DrawCard3 ->
            ( model
            , Random.generate NewCard3 cardGenerator
            )


cardGenerator : Random.Generator Card
cardGenerator =
    Random.uniform Ace
        [ Two
        , Three
        , Four
        , Five
        , Six
        , Seven
        , Eight
        , Nine
        , Ten
        , Jack
        , Queen
        , King
        , Ace
        , DPOI
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every 1000.0 (\_ -> DrawCard1)
        , Time.every 2000.0 (\_ -> DrawCard2)
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        --tagName  tagProps              tagContent
        [ button [ onClick DrawCard1 ] [ text "Draw card1" ]
        , button [ onClick DrawCard2 ] [ text "Draw card2" ]
        , button [ onClick DrawCard3 ] [ text "Draw card3" ]
        , div [ style "font-size" "12em" ] [ text (viewCard model.card1) ]
        , div [ style "font-size" "12em" ] [ text (viewCard model.card2) ]
        , div [ style "font-size" "12em" ] [ text (viewCard model.card3) ]
        ]


viewCard : Card -> String
viewCard card =
    case card of
        Ace ->
            "🂡"

        Two ->
            "🂢"

        Three ->
            "🂣"

        Four ->
            "🂤"

        Five ->
            "🂥"

        Six ->
            "🂦"

        Seven ->
            "🂧"

        Eight ->
            "🂨"

        Nine ->
            "🂩"

        Ten ->
            "🂪"

        Jack ->
            "🂫"

        Queen ->
            "🂭"

        King ->
            "🂮"

        DPOI ->
            "DPOI"
