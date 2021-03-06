module Main exposing (main)

import Browser
import Browser.Navigation
import Element exposing (Element)
import Url exposing (Url)
import Url.Parser as Route


type alias Flags =
    {}


type alias Model =
    { navKey : Browser.Navigation.Key
    , route : Route
    }


type Msg
    = ChangeUrl Browser.UrlRequest
    | UrlChanged Url


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ChangeUrl
        , onUrlChange = UrlChanged
        }


init : Flags -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { navKey = key
      , route = Maybe.withDefault Home (Route.parse route url)
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeUrl request ->
            case request of
                Browser.Internal url ->
                    ( model
                    , Browser.Navigation.pushUrl model.navKey (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Browser.Navigation.load url
                    )

        UrlChanged url ->
            ( { model | route = Maybe.withDefault model.route (Route.parse route url) }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "PWA"
    , body =
        [ Element.layout []
            (Element.column []
                [ viewNavigation
                , viewRoute model.route
                ]
            )
        ]
    }


viewNavigation : Element Msg
viewNavigation =
    Element.row []
        [ Element.text "Elm PWA"
        ]



-- Route


type Route
    = Home
    | About


route : Route.Parser (Route -> a) a
route =
    Route.oneOf
        [ Route.map Home Route.top
        , Route.map About (Route.s "about")
        ]


viewRoute : Route -> Element Msg
viewRoute route =
    case route of
        Home ->
            viewHome

        About ->
            viewAbout


viewHome : Element Msg
viewHome =
    Element.column []
        [ Element.text "Home"
        , Element.link []
            { url = "/about"
            , label = Element.text "Go to About"
            }
        ]


viewAbout : Element Msg
viewAbout =
    Element.column []
        [ Element.text "About"
        , Element.link []
            { url = "/"
            , label = Element.text "Go to Home"
            }
        ]
