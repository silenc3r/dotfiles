-- Imports
import XMonad
import XMonad.Layout.Spacing            -- Allow spaces around windows
import XMonad.Layout.NoBorders          -- No border for fullscreen layout
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog          -- Status output for dock
import XMonad.Util.EZConfig (additionalKeysP)


-- Main
main :: IO ()
main = do
    xmonad $ ewmh defaultConfig
        { terminal              = "urxvtc"
        , modMask               = mod4Mask
        , borderWidth           = 1
        , normalBorderColor     = colorGray
        , focusedBorderColor    = colorBlue
        , focusFollowsMouse     = True
        , startupHook           = setWMName "LG3D"
        }


-- Colors
colorBlack          = "#000000"
colorBlackAlt       = "#050505"
colorGray           = "#484848"
colorGrayAlt        = "#b8bcb8"
colorDarkGray       = "#161616"
colorWhite          = "#ffffff"
colorWhiteAlt       = "#9d9d9d"
colorDarkWhite      = "#444444"
colorMagenta        = "#8e82a2"
colorMagentaAlt     = "#a488d9"
colorBlue           = "#60a0c0"
colorBlueAlt        = "#007b8c"
colorRed            = "#d74b73"
