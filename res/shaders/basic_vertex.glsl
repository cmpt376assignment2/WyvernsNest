#version 330 core
layout(location = 0) in vec2 position;
layout(location = 1) in vec2 texCoord;

uniform vec2 screenDimensions;
uniform mat4 u_Model;
uniform mat4 u_View;
uniform mat4 u_texMap;
out vec2 vTexCoord;

mat4 ortho(float left, float right, float bottom, float top) {
    return mat4(vec4(2.0 / (right - left), 0, 0, 0), 
                vec4(0, 2.0 / top - bottom, 0, 0), 
                vec4(0, 0, 1.0 / (1000.0 - 0.01), 0), 
                vec4(-(right + left) / (right - left), -(top + bottom) / (top - bottom), 0, 1));
}

void main() {
    mat4 translate = mat4(
        vec4(1, 0, 0, 0),
        vec4(0, 1, 0, 0),
        vec4(0, 0, 1, 0),
        vec4(screenDimensions.x / 2.0, screenDimensions.y / 2.0, 0, 1)
    );

    gl_Position =  ortho(0, screenDimensions.x, 0, screenDimensions.y) * translate * u_View * u_Model * vec4(position, 0.0f, 1.0f);
    vTexCoord = vec2(u_texMap * vec4(texCoord, 0.0, 1.0));
}