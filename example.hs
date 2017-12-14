import RGBColorModel

main :: IO ()
main = do
  case (mkRGBColor' (255, 100, 22)) of
    Left x -> putStr $ show x
    Right x -> putStr $ show x
