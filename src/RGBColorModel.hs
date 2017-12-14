module RGBColorModel where

-- Types -----------------------------------

data ColorIntensity = ColorIntensity Integer

data Component =
  Red ColorIntensity
  | Blue ColorIntensity
  | Green ColorIntensity

type RGBColorIntensity = (ColorIntensity, ColorIntensity, ColorIntensity)

data RGBColor = RGBColor { redComponent::Component
                         , greenComponent::Component
                         , blueComponent::Component }

data Error =
  InvalidRedComponent
  | InvalidGreenComponent
  | InvalidBlueComponent
  | InvalidRGBColor
  | ColorIntensityNotInRange
  | Invalid256Range

-- Type Classes -----------------------------

instance Show ColorIntensity where
  show (ColorIntensity intensity) = show intensity

instance Show Component where
  show (Blue intensity) = "Blue: " ++ (show intensity)
  show (Red intensity) = "Red: " ++ (show intensity)
  show (Green intensity) = "Red: " ++ (show intensity)

instance Show RGBColor where
  show (RGBColor { redComponent = (Red redCode)
                 , greenComponent = (Green greenCode)
                 , blueComponent = (Blue blueCode) }
       ) = "r" ++ (show redCode) ++ "g" ++ (show greenCode) ++ "b" ++ (show blueCode)

instance Show Error where
  show InvalidRedComponent = "invalid_red_component"
  show InvalidGreenComponent = "invalid_green_component"
  show InvalidBlueComponent = "invalid_blue_component"
  show InvalidRGBColor = "invalid_colors"
  show ColorIntensityNotInRange = "color_intensity_not_in_range"
  show Invalid256Range = "invalid_256_range"

-- Smart Constructors

mkColorIntensity :: Integer -> Either Error ColorIntensity
mkColorIntensity x = if (in256Range x) then Right $ (ColorIntensity x) else Left $ Invalid256Range


mkRGBColor :: Component -> Component -> Component -> Either Error RGBColor
mkRGBColor (Red redCode) (Green greenCode) (Blue blueCode)
  | otherwise = Right $ RGBColor { redComponent = Red redCode
                         , greenComponent = Green greenCode
                         , blueComponent = Blue blueCode }
mkRGBColor _ (Green greenCode) (Blue blueCode) = Left InvalidRedComponent
mkRGBColor (Red redCode) _ (Blue blueCode) = Left InvalidGreenComponent
mkRGBColor (Red redCode) (Green greenCode) _ = Left InvalidBlueComponent
mkRGBColor _ _ _ = Left InvalidRGBColor

mkRGBColor' :: (Integer, Integer, Integer) -> Either Error RGBColor
mkRGBColor' (redColorIntensity, greenColorIntensity, blueColorIntensity) = do
  -- WITH CASES -----------------
  -- case (mkColorIntensity redColorIntensity) of
  --   (Left redError) -> Left $ error "error"
  --   (Right red) -> case (mkColorIntensity greenColorIntensity) of
  --     (Left greenError) -> Left $ error "error"
  --     (Right green) -> case (mkColorIntensity blueColorIntensity) of
  --       (Left blueError) -> Left $ error "error"
  --       (Right blue) -> case (mkRGBColor (Red red) (Green green) (Blue blue)) of
  --         (Left rgbError) -> Left rgbError
  --         (Right rgbColor) -> Right rgbColor
  -- WITH >>= Monads -----------------
  -- (mkColorIntensity redColorIntensity) >>= (\red ->
  --   (mkColorIntensity greenColorIntensity) >>= (\green ->
  --     (mkColorIntensity blueColorIntensity) >>= (\blue ->
  --       (mkRGBColor (Red red) (Green green) (Blue blue))
  --       )
  --     )
  --   )
  -- WITH do-syntax Monads -----------------
  red <- (mkColorIntensity redColorIntensity)
  green <- (mkColorIntensity greenColorIntensity)
  blue <- (mkColorIntensity blueColorIntensity)
  rgb <- mkRGBColor (Red red) (Green green) (Blue blue)
  return rgb

-- Functions --------------------------------

in256Range :: Integer -> Bool
in256Range x = elem x [1..255]
