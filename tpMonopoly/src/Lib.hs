module Lib where
import Text.Show.Functions ()

data Jugador = Unjugador {
    nombre :: String,
    dinero :: Int,
    tactica :: String, 
    propiedades :: [Propiedad],
    acciones :: [Accion]
} deriving (Show)

type Propiedad = (String, Int)
type Accion = Jugador -> Jugador

carolina :: Jugador
carolina = (Unjugador "Carolina" 500 "Accionista" [] [pasarPorElBanco, pagarAAccionistas])

manuel :: Jugador
manuel = (Unjugador "Manuel" 500 "Oferente singular" [] [pasarPorElBanco, enojarse]) 

sumarDinero :: Int -> Jugador -> Jugador
sumarDinero valor unjugador = unjugador {dinero = dinero unjugador + valor}

cambiarTactica :: String -> Jugador -> Jugador
cambiarTactica unatactica unjugador = unjugador {tactica = unatactica}

pasarPorElBanco :: Accion
pasarPorElBanco = sumarDinero (40).cambiarTactica ("Comprador Compulsivo")

enojarse :: Accion
enojarse unjugador = sumarDinero 50 unjugador {acciones = [gritar]}

gritar :: Accion 
gritar unjugador = unjugador {nombre = "AHHHH" ++ nombre unjugador}

sumarPropiedad :: Propiedad -> Jugador -> Jugador
sumarPropiedad unapropiedad unjugador = unjugador {propiedades = [unapropiedad] ++ propiedades unjugador}

ganarPropiedad :: Propiedad -> Jugador -> Jugador
ganarPropiedad unapropiedad unjugador = (sumarDinero (- snd unapropiedad).sumarPropiedad (unapropiedad)) unjugador

subastar :: Propiedad -> Accion
subastar unapropiedad unjugador | tactica unjugador == "Oferente singular" || tactica unjugador == "Accionista" = ganarPropiedad unapropiedad unjugador 
                                | otherwise = unjugador  
 
cantidadDePropiedades :: Jugador -> (Int -> Bool) -> Int
cantidadDePropiedades unjugador condicionPrecio = (length . filter (condicionPrecio.snd)) (propiedades unjugador)

cobrarAlquileres :: Accion
cobrarAlquileres unjugador = sumarDinero ((cantidadDePropiedades unjugador (<150)) * 10 + (cantidadDePropiedades  unjugador (>=150)) *20) unjugador

pagarAAccionistas :: Accion
pagarAAccionistas unjugador | tactica unjugador == "Accionista" = sumarDinero 200 unjugador
                            | otherwise = sumarDinero (-100) unjugador

hacerBerrinchePor :: Propiedad -> Accion
hacerBerrinchePor unapropiedad unjugador | dinero unjugador >= snd unapropiedad = ganarPropiedad unapropiedad unjugador
                                         | otherwise = hacerBerrinchePor unapropiedad (gritar $ sumarDinero (10) unjugador )

ultimaRonda :: Jugador -> Accion
ultimaRonda unjugador = foldl1 (.) (acciones unjugador)

juegoFinal :: Jugador -> Jugador -> String
juegoFinal unjugador otrojugador |  dinero ((ultimaRonda unjugador) unjugador) > dinero ((ultimaRonda otrojugador) otrojugador) = nombre unjugador
                                 | otherwise = nombre otrojugador 

