Shader "Unlit/Shader1"
{
    Properties
    {
      //_MainTex ("Texture", 2D) = "white" {}
      _Color ("Color",Color) = (1,1,1,1)
      _Scale ("UV Scale", Float) = 1
      _Offset ("UV Offset", Float) = 0
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

            float _Color;
            float _Scale;
            float _Offset;

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
                o.uv = (v.uv0 + _Offset ) * _Scale;
                return o;
            }

            float4 frag (Interpolators i) : SV_Target
            { 
                return float4(i.uv, 0, 1);
            }
            ENDCG
        }
    }
}
