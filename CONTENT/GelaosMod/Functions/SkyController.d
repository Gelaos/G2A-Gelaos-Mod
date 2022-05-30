// Script to manipulate the sky/fog colors
// author: Gottfried
// https://forum.worldofplayers.de/forum/threads/1466665-zCSkyState-in-G2?p=24902060&viewfull=1#post24902060
//
// WARNING: if using DX11, Atmospheric Scattering must be disabled, otherwise custom color won't show

// small class that's needed
class zCSkyState {
    var int time;                //zREAL
    var int polyColor[3];        //zVEC3
    var int fogColor[3];         //zVEC3
    var int domeColor1[3];       //zVEC3
    var int domeColor0[3];       //zVEC3
    var int fogDist;             //zREAL
    var int sunOn;               //zBOOL
    var int cloudShadowOn;       //int
    var int layer0_skyMode;      //zESkyLayerMode
    var int layer0_tex;          //zCTexture*
    var string layer0_texName;   //zSTRING
    var int layer0_texAlpha;     //zREAL
    var int layer0_texScale;     //zREAL
    var int layer0_texSpeed[2];  //zVEC2
    var int layer1_skyMode;      //zESkyLayerMode
    var int layer1_tex;          //zCTexture*
    var string layer1_texName;   //zSTRING
    var int layer1_texAlpha;     //zREAL
    var int layer1_texScale;     //zREAL
    var int layer1_texSpeed[2];  //zVEC2
};

// Indicates which color is displayed at what time.
// Gaps are interpolated cleanly
// IMPORTANT: Night must start < 24 and end > 0!
const int SkyTimes[8] = {
// from, to,
     6,   7,    // sunrise
     9,  18,    // day
    19,  20,    // dusk
    21,   3     // night
};

// Same again for the colors
const int SkyColors[12] = {
//  r,   g,   b
    134, 104, 125,  // sunrise
     //82, 109, 198,  // day
     115, 115, 115,
    139,  46,   0,  // dusk
     18,  16,  60   // night
};

const int SkyColorsFlt = 0;

func void SetCurrentSkyColor(var int r, var int g, var int b) {
    var zCSkyState s;
    
    // check pointer
    if (MEM_SkyController.state0) {
        s = _^ (MEM_SkyController.state0);
        s.fogColor[0] = r;
        s.fogColor[1] = g;
        s.fogColor[2] = b;
    };

    // check pointer
    if (MEM_SkyController.state1) {
        s = _^ (MEM_SkyController.state1);
        s.fogColor[0] = r;
        s.fogColor[1] = g;
        s.fogColor[2] = b;
    };
};

func void SetSkyColor() {
    var int i; var int p;

    if(!SkyColorsFlt) {
        i = 0;
        p = MEM_StackPos.position;
        if(i < 12) {
            if(i < 8) {
                MEM_WriteStatArr(SkyTimes, i, mulf(mkf(MEM_ReadStatArr(SkyTimes, i)), mkf(250000)));
            };
            MEM_WriteStatArr(SkyColors, i, mkf(MEM_ReadStatArr(SkyColors, i)));
            i += 1;
            MEM_StackPos.position = p;
        };
        SkyColorsFlt = 1;
    };

    var int hour; hour = MEM_WorldTimer.worldTime;

    var int r; var int g; var int b;

   // Exception at night because of the jump
    if(lef(hour, SkyTimes[7])||gef(hour, SkyTimes[6])) {
        r = SkyColors[9];
        g = SkyColors[10];
        b = SkyColors[11];
    }
    else {
        i = 0;
        p = MEM_StackPos.position;
        if(i < 8) {
            if(lef(hour, MEM_ReadStatArr(SkyTimes, i))) {
                if(i == 1||i == 3||i == 5) {
                    i = ((i-1)/2)*3;
                    r = MEM_ReadStatArr(SkyColors, i);
                    g = MEM_ReadStatArr(SkyColors, i+1);
                    b = MEM_ReadStatArr(SkyColors, i+2);
                    i = 8;
                    MEM_StackPos.position = p;
                };
                var int start; var int end;
                start = MEM_ReadStatArr(SkyTimes, i);
                if(!i) {
                    end = SkyTimes[7];
                }
                else {
                    end = MEM_ReadStatArr(SkyTimes, i-1);
                };
                end = subf(end, start);
                hour = subf(hour, start);
                var int pm; pm = subf(floateins, divf(hour, end));
                i = (i/2)*3;
                var int j; j = i-3;
                if(j < 0) { j = 9; };
                r = addf(MEM_ReadStatArr(SkyColors, j), mulf(subf(MEM_ReadStatArr(SkyColors, i), MEM_ReadStatArr(SkyColors, j)), pm));
                g = addf(MEM_ReadStatArr(SkyColors, j+1), mulf(subf(MEM_ReadStatArr(SkyColors, i+1), MEM_ReadStatArr(SkyColors, j+1)), pm));
                b = addf(MEM_ReadStatArr(SkyColors, j+2), mulf(subf(MEM_ReadStatArr(SkyColors, i+2), MEM_ReadStatArr(SkyColors, j+2)), pm));
                i = 8;
                MEM_StackPos.position = p;
            };
            i += 1;
            MEM_StackPos.position = p;
        };
    };

    SetCurrentSkyColor(r,g,b);
};
