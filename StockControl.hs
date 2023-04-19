module StockControl where

data Stock = ROOTNODE [Stock] | INNERNODE Char [Stock] | INFONODE Int
  deriving (Show,Read,Eq)

-------------------------
-- FUNCIÓN CREATESTOCK --
-------------------------

-- FUNCIÓN QUE DEVUELVE UN STOCK VACÍO --
createStock :: Stock
createStock = ROOTNODE []

---------------------------
-- FUNCIÓN RETRIEVESTOCK --
---------------------------

-- FUNCIÓN QUE DEVUELVE EL NÚMERO DE UNIDADES DE UN PRODUCTO EN EL STOCK --
-- SI NO ESTÁ, DEBERÁ DEVOLVER -1                                        --

retrieveStock :: Stock         -> String -> Int
retrieveStock (INFONODE num) p 
  | p == "" = num
  | otherwise = -1
retrieveStock (INNERNODE chr (s:stocks)) (p:ps)
  | chr == p = retrieveStock s ps
  | otherwise = -1
retrieveStock (ROOTNODE l@(s:stocks)) p 
  | l == [] = -1
  | otherwise = retrieveStock s p

-------------------------
-- FUNCIÓN UPDATESTOCK --
-------------------------

-- FUNCIÓN QUE MODIFICA EL VALOR ASOCIADO A UN PRODUCTO EN EL STOCK --
-- SÓLO PUEDE ALMACENAR NÚMEROS MAYORES O IGUALES A 0               --

updateStock :: Stock         -> String -> Int -> Stock
updateStock (INFONODE num) p u
  | u >= 0 = (INFONODE u)
updateStock (INNERNODE chr (s:stocks)) (p:ps) u
  | s == [] = updateStock s p u --COMPROBAR SI ES NECESARIO CREAR UN INFONODE O UN INNERNODE
  | otherwise = updateStock s p u
updateStock (ROOTNODE l@(s:stocks)) (p:ps) u
  | l == [] = updateStock (INNERNODE p s) ps u
  | otherwise = updateStock s p u
updateStock s p u 
  | retrieveStock s p == -1 = createStock
  | s == ROOTNODE = 
  | otherwise = 
updateStock s p u
  | p /= "" = createStock


-----------------------
-- FUNCIÓN LISTSTOCK --
-----------------------

-- FUNCIÓN QUE DEVUELVE UNA LISTA PARES PRODUCTO-EXISTENCIA --
-- DEL CATÁLOGO QUE COMIENZAN POR LA CADENA PREFIJO p       --
listStock :: Stock -> String -> [(String,Int)]


-- FUNCIÓN GENÉRICA DE BACKTRACKING --
bt :: (a -> Bool) -> (a -> [a]) -> a -> [a]
bt    eS             c             n
  | eS n      = [n]
  | otherwise = concat (map (bt eS c) (c n))

