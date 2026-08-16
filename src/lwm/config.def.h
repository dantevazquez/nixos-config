/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const KeySym tabModKey   = XK_Super_L;
static const KeySym tabCycleKey = XK_Tab;
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=14" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=14";
static const char col_gray1[]       = "#303446";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#c6d0f5";
static const char col_gray4[]       = "#4c4f69";
static const char col_cyan[]        = "#a6d189";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       0,            0,           -1 },
};

/* layout(s) */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",         monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ Mod4Mask | ShiftMask,                       KEY,      view,           {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "termux", NULL };
static const char *browsercmd[] = {"chromium", NULL};
static const char *xcolorcmd[] = { "sh", "-c", "xcolor | xclip -selection clipboard", NULL };
static const char *brupcmd[]   = { "brightness", "up", NULL };
static const char *brdowncmd[] = { "brightness", "down", NULL };
static const char *volupcmd[]   = { "volume", "up", NULL };
static const char *voldowncmd[] = { "volume", "down", NULL };
static const char *volmutecmd[] = { "volume", "mute", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ Mod4Mask,                       XK_space,  spawn,          {.v = dmenucmd } },
	{ Mod4Mask,                       XK_Return, spawn,          {.v = termcmd } },
	{ Mod4Mask,                       XK_b, spawn,          {.v = browsercmd } },
	{ Mod4Mask,                       XK_p, spawn,          {.v = xcolorcmd } },
{ 0,                            XF86XK_MonBrightnessUp,   spawn,        {.v = brupcmd } },
	{ 0,                            XF86XK_MonBrightnessDown, spawn,        {.v = brdowncmd } },
{ 0,                            XF86XK_AudioRaiseVolume,  spawn,        {.v = volupcmd } },
	{ 0,                            XF86XK_AudioLowerVolume,  spawn,        {.v = voldowncmd } },
	{ 0,                            XF86XK_AudioMute,         spawn,        {.v = volmutecmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ Mod4Mask,                       XK_Tab,    alttab,         {0} },
	{ MODKEY,                       XK_o,      winview,        {0} },
	{ Mod4Mask,             XK_q,      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};
