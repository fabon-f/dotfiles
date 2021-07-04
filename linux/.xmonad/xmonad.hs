import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Fullscreen
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.Simplest
import XMonad.Layout.TwoPane
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import qualified XMonad.StackSet as W

import XMonad.Hooks.DebugStack

myterm = "alacritty"
launcher = "rofi -modi combi,window,calc,run,ssh -combi-modi system:rofi_system.sh,drun -show combi -sidebar-mode"
filemanager = "thunar"

myKeymaps =
    [
        ("M-p", spawn launcher),
        ("M-f", spawn filemanager),
        ("M-o", spawn "firefox"),

        ("<Print>", spawn "maim-screenshot all"),
        ("S-<Print>", spawn "maim-screenshot select"),
        ("S-C-4", spawn "maim-screenshot select"),
        ("S-C-3", spawn "maim-screenshot current"),

        ("M-S-p", spawn "bwmenu"),

        ("M-a", sendMessage MirrorShrink),
        ("M-z", sendMessage MirrorExpand),

        ("M-C-h", sendMessage $ pullGroup L),
        ("M-C-j", sendMessage $ pullGroup D),
        ("M-C-k", sendMessage $ pullGroup U),
        ("M-C-l", sendMessage $ pullGroup R),

        ("M-C-m", withFocused (sendMessage . MergeAll)),
        ("M-C-u", withFocused (sendMessage . UnMerge)),

        ("M-C-.", onGroup W.focusUp'),
        ("M-C-,", onGroup W.focusDown'),

        ("<XF86AudioPlay>", spawn "playerctl play-pause")
    ]

myHandleEventHook = XMonad.Layout.Fullscreen.fullscreenEventHook

-- myManageHook = fullscreenManageHook
myManageHook = composeAll
    [
        className =? "mpv" --> doFloat,
        isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]

myTabConfig = def { fontName = "xft:Noto Sans Mono JP:size=11" }

myLayout = windowNavigation $ avoidStruts $ subTabbedTall ||| Mirror subTabbedTall ||| tabbed shrinkText myTabConfig
  where
    tall = ResizableTall 1 (3/100) (1/2) []
    subTabbedTall = addTabs shrinkText myTabConfig $ subLayout [] Simplest tall

main :: IO ()
main = do
    myStatusBar <- spawnPipe "polybar main"
    xmonad ( docks $ ewmh def {
        terminal = myterm,
        modMask = mod4Mask,
        handleEventHook = myHandleEventHook,
        manageHook = myManageHook,
        layoutHook = myLayout
    } `additionalKeysP` myKeymaps )
