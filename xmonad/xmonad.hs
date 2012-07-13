-- Imports
import XMonad
import Data.Monoid
import System.Exit
-- import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops

-- Main
main :: IO ()
main = do
    xmonad $ ewmh defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
 
      -- key bindings
        -- keys               = myKeys,
        -- mouseBindings      = myMouseBindings,
 
      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook
        -- startupHook        = myStartupHook
    }
 
myTerminal      = "urxvtc -e fish"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth   = 0
myModMask       = mod4Mask
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
myNormalBorderColor  = colorGray
myFocusedBorderColor = colorBlue

-- Colors {{{
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
-- }}}
-- Layouts: {{{
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio
 
    -- The default number of windows in the master pane
    nmaster = 1
 
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
 
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100
-- }}}
-- Window rules: {{{
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "mplayer2"       --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]
-- }}}
-- Event handling {{{
 
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
myEventHook = mempty
-- }}}
-- Status bars and logging {{{
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
myLogHook = return ()
-- }}}
-- Startup hook {{{
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
-- myStartupHook = setWMName "LG3D"
-- }}}
-- vim:foldmethod=marker:foldmarker={{{,}}}:ft=haskell:
