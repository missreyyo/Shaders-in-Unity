Shader "Unlit/Shader2"
{
    Properties
    {
      //_MainTex ("Texture", 2D) = "white" {}
      _ColorA ("Color A",Color) = (1,1,1,1)
      _ColorB ("Color B",Color) = (1,1,1,1)
      _ColorStart ("Color Start",Range(0,1) ) = 0
      _ColorEnd ("Color End", Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"
        "Queue" = "Transparent" }     //render order 
    

        Pass
        { 
            Cull Off        
            ZWrite Off       // transparent seems
            Blend One One  // additive   
         
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #define TAU 6.28318530718
            float4 _ColorA;
            float4 _ColorB;
            float _ColorStart;
            float _ColorEnd;

            struct Meshdata
            {
                float4 vertex : POSITION;
                float3 normals : NORMAL;
                float4 uv0 : TEXCOORD0;
               
            };

            struct Interpolators
            {
            float3 normal : TEXCOORD0;
            float2 uv : TEXCOORD1;         
            float4 vertex : SV_POSITION;
            };


            Interpolators vert (Meshdata v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex); 
                o.normal = UnityObjectToWorldNormal(v.normals); 
                o.uv = v.uv0;   //(v.uv0 + _Offset ) * _Scale;
                return o;
            }
            float InverseLerp(float a,float b, float v)
            {
                return (v-a) / (b-a) ;
            }

            float4 frag (Interpolators i) : SV_Target
            {   
              //  float4 outColor = lerp(_ColorA,_ColorB,i.uv.x); #blend betwwen two colors
              //  return outColor;
              float xOffSet = cos(i.uv.x * TAU*8) * 0.1;          // ZİG ZAG
              float2 t = cos((i.uv.y + xOffSet + _Time.y ) * TAU * 5) *0.5 + 0.5; //if we use i.uv.x , lines will be horizantal, if we use i.uv.y, then lines will be vertical.
              t *= i.uv.y;     //fading                                   
              return float4(t, 0,1);                  // _Time.y will be live our lines :)))                         
        
            }
            ENDCG
        }
    }
}

