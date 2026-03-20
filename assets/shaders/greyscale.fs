vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
{
    vec4 pixel = Texel(tex, texture_coords) * color;
    
    float gray = dot(pixel.rgb, vec3(0.299, 0.587, 0.114));
    
    return vec4(gray, gray, gray, pixel.a);
}