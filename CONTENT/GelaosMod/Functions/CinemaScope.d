// ----------------------------------------------------------------
// CinemaScope
// adds bars to dialogues to give them more of a 'cinematic' effect
// ----------------------------------------------------------------
//
// authors: 
//   Lehona (et al.) - ScreenFade from ScriptBin
//   mud-freak - modified version of ScreenFade
//   Fawkes - modified version of mud-freak's script
//   L-Titan (Gelaos) - slightly modified version of Fawkes' script
//
//   https://forum.worldofplayers.de/forum/threads/1543213-Cinema-scope-f%C3%BCr-dx11render?p=26941823&viewfull=1#post26941823
//

const int CINEMASCOPE_EFFECT_FADE = 0;
const int CINEMASCOPE_EFFECT_SLIDE = 1;
const int CINEMASCOPE_EFFECT_APPEAR = 2;

const int CINEMASCOPE_EFFECT_FADE_TIME = 300; // miliseconds
const int CINEMASCOPE_EFFECT_SLIDE_TIME = 300; // miliseconds

const int CINEMASCOPE_SCREEN_TOP_HEIGHT = PS_VMAX / 6; // set in virtual coordinates (they're somehow mapped to pixels)
const int CINEMASCOPE_SCREEN_BOTTOM_HEIGHT = PS_VMAX / 5; // set in virtual coordinates (they're somehow mapped to pixels)

func void CinemaScopeFadeHandler(var int view, var int alpha) {
    View_SetColor(view, RGBA(0, 0, 0, alpha));
};

func void CinemaScopeTopSlideHandler(var int view, var int sizeY) {
    View_MoveTo (view, 0, 0);
    View_Resize (view, PS_VMAX, sizeY);
};

func void CinemaScopeBottomSlideHandler(var int view, var int sizeY) {
    var int Y; Y = PS_VMAX - sizeY;
    if (Y > PS_VMAX) { Y = PS_VMAX; };
    sizeY = PS_VMAX - Y;
    View_MoveTo (view, 0, 0);
    View_Resize (view, PS_VMAX, sizeY);
    View_MoveTo (view, 0, Y);
};

func void CinemaScope (var int cinemaScopeEffect, var int startMS, var int waitMS, var int endMs) {
    //View handles
    var int hCinemaScopeTop;
    var int hCinemaScopeBottom;

    //Appear / disappear
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_APPEAR) {
        //Disappear
        if (endMs != -1) {
            //Remove views
            if (Hlp_IsValidHandle (hCinemaScopeTop)   ) { View_Delete (hCinemaScopeTop);    };
            if (Hlp_IsValidHandle (hCinemaScopeBottom)) { View_Delete (hCinemaScopeBottom); };
            return;
        };
    };

    //Create views
    // top view
    if (!Hlp_IsValidHandle (hCinemaScopeTop)) {
        hCinemaScopeTop = View_Create(0, 0, PS_VMAX, 1);
        View_SetTexture (hCinemaScopeTop, "default.tga");
        View_Open (hCinemaScopeTop);
    };
    // bottom view
    if (! Hlp_IsValidHandle (hCinemaScopeBottom)) {
        hCinemaScopeBottom = View_Create(0, PS_VMAX - CINEMASCOPE_SCREEN_BOTTOM_HEIGHT, PS_VMAX, PS_VMAX);
        View_SetTexture (hCinemaScopeBottom, "default.tga");
        View_Open (hCinemaScopeBottom);
    };

    //Appear
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_APPEAR) {
        View_SetColor (hCinemaScopeTop, 0);
        View_MoveTo (hCinemaScopeTop, 0, 0);
        View_Resize (hCinemaScopeTop, PS_VMAX, CINEMASCOPE_SCREEN_TOP_HEIGHT);
        View_SetColor(hCinemaScopeTop, RGBA(0, 0, 0, 255));

        View_SetColor (hCinemaScopeBottom, 0);
        View_MoveTo (hCinemaScopeBottom, 0, PS_VMAX - CINEMASCOPE_SCREEN_BOTTOM_HEIGHT);
        View_Resize (hCinemaScopeBottom, PS_VMAX, CINEMASCOPE_SCREEN_BOTTOM_HEIGHT);
        View_SetColor(hCinemaScopeBottom, RGBA(0, 0, 0, 255));

        //We don't need A8 here - just create views and exit
        return;
    };

    //Fade in/out
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_FADE) {
        View_SetColor (hCinemaScopeTop, 0);
        View_MoveTo (hCinemaScopeTop, 0, 0);
        View_Resize (hCinemaScopeTop, PS_VMAX, CINEMASCOPE_SCREEN_TOP_HEIGHT);

        View_SetColor (hCinemaScopeBottom, 0);
        View_MoveTo (hCinemaScopeBottom, 0, PS_VMAX - CINEMASCOPE_SCREEN_BOTTOM_HEIGHT);
        View_Resize (hCinemaScopeBottom, PS_VMAX, CINEMASCOPE_SCREEN_BOTTOM_HEIGHT);
    } else
    //Slide in/out
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_SLIDE) {
        View_SetColor (hCinemaScopeTop, RGBA (0, 0, 0, 255));
        View_MoveTo (hCinemaScopeTop, 0, 0);
        View_Resize (hCinemaScopeTop, PS_VMAX, 0);

        View_SetColor (hCinemaScopeBottom, RGBA (0, 0, 0, 255));
        View_MoveTo (hCinemaScopeBottom, PS_VMAX, PS_VMAX);
        View_Resize (hCinemaScopeBottom, PS_VMAX, 0);
    };

    // A8 trades 
    var  int a8Top;
    var  int a8Bottom;

    if (Hlp_IsValidHandle (a8Top)) {
        if (endMs != -1) {
            Anim8_RemoveIfEmpty(a8Top, true);
            Anim8_RemoveDataIfEmpty(a8Top, true);
            //Anim8_CallOnRemove(a8Top, TurnScreenBackOn);
        };
    };

    //create new a8Top handle
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_FADE) {
        a8Top = Anim8_NewExt(0, CinemaScopeFadeHandler, hCinemaScopeTop, false);
    } else
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_SLIDE) {
        a8Top = Anim8_NewExt(0, CinemaScopeTopSlideHandler, hCinemaScopeTop, false);
    };

    if (endMs != -1) {
        Anim8_RemoveIfEmpty(a8Top, true);
        Anim8_RemoveDataIfEmpty(a8Top, true);
        //Anim8_CallOnRemove(a8Top, TurnScreenBackOn);
    };

    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_FADE) {
        Anim8(a8Top, 255, startMS, A8_Constant);
        Anim8q(a8Top, 255, waitMS, A8_Wait);
    } else
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_SLIDE) {
        Anim8(a8Top, CINEMASCOPE_SCREEN_TOP_HEIGHT, startMS, A8_Constant);
        Anim8q(a8Top, CINEMASCOPE_SCREEN_TOP_HEIGHT, waitMS, A8_Wait);
    };

    if (endMs != -1) {
        Anim8q(a8Top, 0, endMs, A8_Constant);
    };

    if (Hlp_IsValidHandle (a8Top)) {
        if (endMs != -1) {
            Anim8_RemoveIfEmpty(a8Top, true);
            Anim8_RemoveDataIfEmpty(a8Top, true);
            //Anim8_CallOnRemove(a8Top, TurnScreenBackOn);
        };
    };

    //create new a8Bottom handle
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_FADE) {
        a8Bottom = Anim8_NewExt(0, CinemaScopeFadeHandler, hCinemaScopeBottom, false);
    } else
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_SLIDE) {
        a8Bottom = Anim8_NewExt(0, CinemaScopeBottomSlideHandler, hCinemaScopeBottom, false);
    };

    if (endMs != -1) {
        Anim8_RemoveIfEmpty(a8Bottom, true);
        Anim8_RemoveDataIfEmpty(a8Bottom, true);
        //Anim8_CallOnRemove(a8Bottom, TurnScreenBackOn);
    };

    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_FADE) {
        Anim8(a8Bottom, 255, startMS, A8_Constant);
        Anim8q(a8Bottom, 255, waitMS, A8_Wait);
    } else
    if (cinemaScopeEffect == CINEMASCOPE_EFFECT_Slide) {
        Anim8(a8Bottom, CINEMASCOPE_SCREEN_BOTTOM_HEIGHT, startMS, A8_Constant);
        Anim8q(a8Bottom, CINEMASCOPE_SCREEN_BOTTOM_HEIGHT, waitMS, A8_Wait);
    };

    if (endMs != -1) {
        Anim8q(a8Bottom, 0, endMs, A8_Constant);
    };
};

func void CinemaScopeAppear () {
    CinemaScope (CINEMASCOPE_EFFECT_APPEAR, 0, 0, -1);
};

func void CinemaScopeDisappear () {
    CinemaScope (CINEMASCOPE_EFFECT_APPEAR, 0, 0, 0);
};

func void CinemaScopeSlideIn () {
    CinemaScope (CINEMASCOPE_EFFECT_SLIDE, CINEMASCOPE_EFFECT_SLIDE_TIME, 0, -1);
};

func void CinemaScopeSlideOut () {
    CinemaScope (CINEMASCOPE_EFFECT_SLIDE, 0, 0, CINEMASCOPE_EFFECT_SLIDE_TIME);
};

func void CinemaScopeFadeIn () {
    CinemaScope (CINEMASCOPE_EFFECT_FADE, CINEMASCOPE_EFFECT_FADE_TIME, 0, -1);
};

func void CinemaScopeFadeOut () {
    CinemaScope (CINEMASCOPE_EFFECT_FADE, 0, 0, CINEMASCOPE_EFFECT_FADE_TIME);
};