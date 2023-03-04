Shader "Unlit/VertexShader"
{
    Properties
    {
      //_MainTex ("Texture", 2D) = "white" {}
      _ColorA ("Color A",Color) = (1,1,1,1)
      _ColorB ("Color B",Color) = (1,1,1,1)
      _ColorStart ("Color Start",Range(0,1) ) = 0
      _ColorEnd ("Color End", Range(0,1)) = 1
      _WaveAmp ("Wave Amplitude", Range(0,0.2)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque"
       }     //render order 
    

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
            float _WaveAmp;

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
                 float wave = cos((v.uv0.y - _Time.y * 0.1)* TAU * 5) * 0.5 + 0.5;
                 v.vertex.y = wave * _WaveAmp;

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
                float wave = cos((i.uv.y - _Time.y * 0.1)* TAU * 5) * 0.5 + 0.5;
                  return wave;      
        
            }
            ENDCG
        }
    }
}
