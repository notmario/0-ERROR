#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define MY_HIGHP_OR_MEDIUMP highp
#else
	#define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 occult;
extern MY_HIGHP_OR_MEDIUMP number dissolve;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;
extern bool shadow;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2;


vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);

	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

number hue(number s, number t, number h)
{
	number hs = mod(h, 1.)*6.;
	if (hs < 1.) return (t-s) * hs + s;
	if (hs < 3.) return t;
	if (hs < 4.) return (t-s) * (4.-hs) + s;
	return s;
}

vec4 RGB(vec4 c)
{
	if (c.y < 0.0001)
		return vec4(vec3(c.z), c.a);

	number t = (c.z < .5) ? c.y*c.z + c.z : -c.y*c.z + (c.y+c.z);
	number s = 2.0 * c.z - t;
	return vec4(hue(s,t,c.x + 1./3.), hue(s,t,c.x), hue(s,t,c.x - 1./3.), c.w);
}

vec4 HSL(vec4 c)
{
	number low = min(c.r, min(c.g, c.b));
	number high = max(c.r, max(c.g, c.b));
	number delta = high - low;
	number sum = high+low;

	vec4 hsl = vec4(.0, .0, .5 * sum, c.a);
	if (delta == .0)
		return hsl;

	hsl.y = (hsl.z < .5) ? delta / sum : delta / (2.0 - sum);

	if (high == c.r)
		hsl.x = (c.g - c.b) / delta;
	else if (high == c.g)
		hsl.x = (c.b - c.r) / delta + 2.0;
	else
		hsl.x = (c.r - c.g) / delta + 4.0;

	hsl.x = mod(hsl.x / 6., 1.);
	return hsl;
}

vec4 RGBtoHSV(vec4 rgb)
{
    vec4 hsv;
    float minVal = min(min(rgb.r, rgb.g), rgb.b);
    float maxVal = max(max(rgb.r, rgb.g), rgb.b);
    float delta = maxVal - minVal;

    // Value
    hsv.z = maxVal;

    // Saturation
    if (maxVal != 0.0)
        hsv.y = delta / maxVal;
    else {
        // r = g = b = 0, s = 0, v is undefined
        hsv.y = 0.0;
        hsv.x = -1.0;
        return hsv;
    }

    // Hue
    if (rgb.r == maxVal)
        hsv.x = (rgb.g - rgb.b) / delta;      // between yellow & magenta
    else if (rgb.g == maxVal)
        hsv.x = 2.0 + (rgb.b - rgb.r) / delta;  // between cyan & yellow
    else
        hsv.x = 4.0 + (rgb.r - rgb.g) / delta;  // between magenta & cyan

    hsv.x = hsv.x * (1.0 / 6.0);
    if (hsv.x < 0.0)
        hsv.x += 1.0;

    // Alpha
    hsv.w = rgb.a;

    return hsv;
}

vec4 HSVtoRGB(vec4 hsv) {
    vec4 rgb;

    float h = hsv.x * 6.0;
    float c = hsv.z * hsv.y;
    float x = c * (1.0 - abs(mod(h, 2.0) - 1.0));
    float m = hsv.z - c;

    if (h < 1.0) {
        rgb = vec4(c, x, 0.0, hsv.a);
    } else if (h < 2.0) {
        rgb = vec4(x, c, 0.0, hsv.a);
    } else if (h < 3.0) {
        rgb = vec4(0.0, c, x, hsv.a);
    } else if (h < 4.0) {
        rgb = vec4(0.0, x, c, hsv.a);
    } else if (h < 5.0) {
        rgb = vec4(x, 0.0, c, hsv.a);
    } else {
        rgb = vec4(c, 0.0, x, hsv.a);
    }

    rgb.rgb += m;

    return rgb;
}


float mod2(float val1, float mod1)
{
    val1 /= mod1;
    val1 -= floor(val1);
    return(mod1 * val1);
}

float msin(float x)
{
    float temp1 = sin(x) - sin(3.14141 * x + 2) - sin(0.1765 * x + 1) + sin(5.17 * x - 2)
    + cos(x) + cos(1.13141 * x + 2.5) + cos(1.1765 * x - 1) - cos(3.17 * x + 2);
    return(temp1/3);
}

float swirl(float xcor, float ycor, float twist, float tset)
{
    float dBase = pow(xcor * xcor + ycor * ycor, 0.5);
    float spart1 = xcor * sin(twist * dBase + tset);
    float spart2 = ycor * cos(twist * dBase + tset);
    float spart12 = (spart1 + spart2)/(dBase * dBase + 1);
    spart12 = max(0, log(abs(spart12) + 1) - dBase/100);
    return(spart12);
}

float logSign(float val1)
{
    return(sign(val1));
    //return(pow(2, 8*val1 + 2)/(1 + pow(2, 8*val1 + 2)));
}

float drawRect(vec4 cor, float width, float xcord, float ycord, float thresh)
{
    cor.z = cor.z + 0.001;
    cor.w = cor.w + 0.001;
    float slope1 = (cor.y - cor.w)/(cor.x - cor.z);
    float offs1 = cor.y - slope1 * cor.x;
    float slope2 = (cor.x - cor.z)/(cor.w - cor.y);
    float offs2 = (cor.y + cor.w + (cor.x*cor.x - cor.z*cor.z)/(cor.y - cor.w))/2;
    float radius = pow(pow(cor.x - cor.z, 2) + pow(cor.y - cor.w, 2), 0.5)/2;
    width = width - 1;
    float dirct1 = atan(slope1);
    float dirct2 = atan(slope2);
    float bound11 = slope1 * (xcord - (1+width) * sin(dirct1)) + offs1 - (1+width) * cos(dirct1);
    float bound12 = slope1 * (xcord + (1+width) * sin(dirct1)) + offs1 + (1+width) * cos(dirct1);
    bound12, bound11 = min(bound11, bound12), max(bound11, bound12);
    float bound21 = slope2 * (xcord - (radius+width) * sin(dirct2)) + offs2 - (radius+width) * cos(dirct2);
    float bound22 = slope2 * (xcord + (radius+width) * sin(dirct2)) + offs2 + (radius+width) * cos(dirct2);
    bound22, bound21 = min(bound21, bound22), max(bound21, bound22);
    float total = (logSign(ycord - bound11) + logSign(bound12 - ycord) + logSign(ycord - bound21) + logSign(bound22 - ycord))/4 - thresh;
    float result = ceil(max(total, 0));
    return(result);
}

float drawRect(vec4 cor, float xcord, float ycord)
{
    return(drawRect(cor, 1, xcord, ycord, 0.8));
}

const int runC = 26;
const int runLen = runC * 5;

vec4 runes[runLen] = vec4[]
    (
        //BLANK
        vec4(999, 999, 999, 999), 
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //OTHALA
        vec4(3, 13, 11, 5),
        vec4(12, 7, 6, 1),
        vec4(9, 1, 3, 7),
        vec4(4, 5, 12, 13),
        vec4(999, 999, 999, 999),

        //PERTHRO
        vec4(12, 2, 8, 6),
        vec4(9, 6, 5, 2),
        vec4(5, 2, 5, 13),
        vec4(5, 13, 9, 9),
        vec4(8, 9, 12, 13),

        //MANNAZ
        vec4(4, 13, 4, 2),
        vec4(3, 2, 12, 11),
        vec4(11, 13, 11, 2),
        vec4(12, 2, 3, 11),
        vec4(999, 999, 999, 999),
        
        //DAGAZ
        vec4(2, 2, 13, 13),
        vec4(12, 13, 12, 2),
        vec4(13, 2, 2, 13),
        vec4(3, 13, 3, 2),
        vec4(999, 999, 999, 999),

        //INGUZ
        vec4(7, 2, 13, 8), 
        vec4(13, 7, 7, 13),
        vec4(8, 13, 2, 7),
        vec4(2, 8, 8, 2),
        vec4(999, 999, 999, 999),

        //LAGUZ
        vec4(5, 13, 5, 2), 
        vec4(4, 2, 11, 9),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //EHWAZ
        vec4(3, 13, 3, 2), 
        vec4(3, 2, 8, 7),
        vec4(7, 7, 12, 2),
        vec4(12, 2, 12, 13),
        vec4(999, 999, 999, 999),

        //BERKANO
        vec4(4, 2, 4, 13), 
        vec4(4, 2, 11, 5),
        vec4(4, 13, 11, 10),
        vec4(10, 5, 4, 8),
        vec4(10, 10, 4, 7),

        //TIWAZ
        vec4(7.5, 2, 7.5, 13), 
        vec4(8, 2, 3, 7),
        vec4(7, 2, 12, 7),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        
        //SOWILO
        vec4(5, 2, 5, 11), 
        vec4(4, 11, 11, 4),
        vec4(10, 4, 10, 13),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //ISA
        vec4(7, 2, 7, 12), 
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //ALGIZ
        vec4(7.5, 2, 7.5, 12), 
        vec4(7, 7, 12, 2),
        vec4(3, 2, 8, 7),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //EIWAZ
        vec4(7.5, 2, 7.5, 12), 
        vec4(3, 9, 8, 12),
        vec4(7, 2, 12, 5),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //JERA
        vec4(7, 3, 3, 7), 
        vec4(3, 6, 7, 10),
        vec4(9, 5, 13, 9),
        vec4(13, 8, 9, 12),
        vec4(999, 999, 999, 999),

        //LESAZ
        vec4(2, 2, 12, 12), 
        vec4(5, 5, 12, 5),
        vec4(5, 5, 5, 12),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //HAGALAZ
        vec4(5, 2, 5, 13), 
        vec4(4, 5, 11, 12),
        vec4(10, 2, 10, 13),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //FEHU
        vec4(3, 2, 3, 13), 
        vec4(2, 7, 7, 2),
        vec4(2, 12, 12, 2),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //URUZ
        vec4(3, 2, 3, 13), 
        vec4(2, 2, 13, 7.5),
        vec4(12, 7, 12, 13),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        
        //BATRO
        vec4(5, 2, 5, 13), 
        vec4(9, 8, 9, 13),
        vec4(8, 9, 12, 5),
        vec4(11, 2, 11, 6),
        vec4(999, 999, 999, 999),

        //ANSUZ
        vec4(6, 2, 6, 13), 
        vec4(5, 1, 10, 6),
        vec4(5, 6, 10, 11),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //RAIDO
        vec4(4, 2, 4, 13), 
        vec4(4, 2, 11, 5),
        vec4(11, 4, 7, 8),
        vec4(7, 7, 10, 13),
        vec4(999, 999, 999, 999),

        //KAUNAZ
        vec4(10, 2, 4, 8), 
        vec4(4, 7, 10, 13),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //GEBO
        vec4(2, 2, 13, 13), 
        vec4(2, 13, 13, 2),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //WUNJO
        vec4(5, 2, 5, 13), 
        vec4(4, 2, 9, 7),
        vec4(10, 6, 4, 12),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),

        //NAUDIZ
        vec4(7, 2, 7, 13), 
        vec4(4, 6, 11, 10),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999),
        vec4(999, 999, 999, 999)
    );


float drawRune(int runeNum, float offX, float offY, float basex, float basey)
{
    float rune1 = 0;
    for(int i = 0; i < 5; i++)
    {
        rune1 += drawRect(runes[i + runeNum * 5], 0.5, basex + offX + 8, basey + offY + 8, 0.6);
    }
    return(rune1);
}

float drawRuneBorder(int runeNum, float offX, float offY, float basex, float basey)
{
    float rune2 = 0;
    for(int i = 0; i < 5; i++)
    {
        rune2 += drawRect(runes[i + runeNum * 5], 1.5, basex + offX + 8, basey + offY + 8, 0.6);
    }
    return(rune2);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
	vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

	// Dummy, doesn't do anything but at least it makes the shader useable
    if (uv.x > uv.x * 2.){
        uv = occult;
    }


	number low = min(tex.r, min(tex.g, tex.b));
    number high = max(tex.r, max(tex.g, tex.b));
	number delta = high - low;

	//vec4 hsl = HSL(vec4(tex.r, tex.g, tex.b, tex.a));

	float t = occult.y*2.221 + time;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/texture_details.ba;
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 50.;

	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;


    vec4 pixel = Texel(texture, texture_coords);

    float cx = uv_scaled_centered.x * 2 * 0.75;
    float cy = uv_scaled_centered.y * 2;

    t *= 1;
    vec2 atlasScaleXY = 1/image_details.xy;
    vec4 linecord = vec4(-sin(t/4), -cos(t/4), sin(t/4), cos(t/4))*10;



    float word1 = 0;
    float border1 = 0;
    float word1len = 2.37;
    float tw1 = floor(t/15);
    int runenum = 4;
    float wordoff = 0;

    float wordSum = 0;
    float bordSum = 0;

    for (int j = 0; j < 5; j++)
    {
        wordoff = 35*sin((j + 1)*23);
        t += 3*j;
        tw1 = floor(t/15);
        runenum = 3 + j;
        word1len = 2.37;

        for(int i = 0; i < 7; i++)
        {   
            word1len = word1len * 7.41 * max(0, 1 + sin(tw1) - i * 0.2);
            runenum = int(mod2((tw1 + i * 3 + j * 41.83 + runenum)*runenum, 26));
            word1   += drawRune      (runenum, 4*sin(t + i) + 3*sin(t/3 + i*3), mod2(16 * (i + 1.0*t - 2), 240) - 120, cx+wordoff, cy);
            border1 += drawRuneBorder(runenum, 4*sin(t + i) + 3*sin(t/3 + i*3), mod2(16 * (i + 1.0*t - 2), 240) - 120, cx+wordoff, cy);
        }

        t -= 3*j;
        tw1 = floor(t/15);
        wordSum += word1 * (2+sin(j))/5;
        word1 = 0;
        bordSum += border1 * (2+sin(j))/5;
        border1 = 0;
    }

    float swirlclumps = 21;
    float sw1 = 0;

    cx /= 2;
    cy /= -2;

    for(int i = 0; i < swirlclumps; i++)
    {
        sw1 += 20/swirlclumps * (1 + msin(i + t/20)) * (1 - pow((mod2(t*1.5 + i, 20) - 10)/10, 2)) * 
            swirl(
                cx/2 - 10 * msin(i*13 + t/30), 
                cy/2 + 10 * msin(i*21 - t/30), 
                msin(i * 7)/3, 
                t/5
            );
    }


    float avgcol = (tex.r + tex.g + tex.b)/4;

    tex.r = avgcol * 1.4;
    tex.g = avgcol;
    tex.b = avgcol;

    tex.rgb -= pow(abs(sw1), 0.2) * 0.5 + 0.3;

    tex.rgb += wordSum;
    tex.r += bordSum;
    
    tex.rgb *= 1.3;
    tex.gb -= 0.1;


	return dissolve_mask(tex*colour, texture_coords, uv);
}

extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif
