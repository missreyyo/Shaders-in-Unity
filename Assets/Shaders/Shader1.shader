Shader "Unlit/Shader1"
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
        Tags { "RenderType"="Opaque" }
    

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _ColorA;
            float4 _ColorB;
            float _ColorStart;
            float _ColorEnd;

            struct Meshdata
            {
                float4 vertex : POSITION;
                float3 normals : NORMAL;
                //float3 tangent : TANGENT;
                //float4 color : COLOR;
                float4 uv0 : TEXCOORD0;
               // float2 uv1 : TEXCOORD1;
            };

            struct Interpolators
            {
           // float2 tangent : TEXCOORD1;
            float3 normal : TEXCOORD0;
           // float2 value : TEXCOORD2;
            float2 uv : TEXCOORD1;
              //  float4 uv : TEXCOORD2;
              //  float4 uv : TEXCOORD3;
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
              float t = saturate(InverseLerp(_ColorStart,_ColorEnd,i.uv.x)) ;
              t = frac(t);                                             //if we write number which less than 0, result will be equal to the 0.
                                                                       //if we write number which bigger than 1, result wil be  equal to the 1,
              float4 outColor = lerp(_ColorA,_ColorB,t);
              return outColor;
            }
            ENDCG
        }
    }
}
