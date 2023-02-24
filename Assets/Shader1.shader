Shader "Unlit/Shader1"
{
    Properties
    {
      //_MainTex ("Texture", 2D) = "white" {}
      _Value ("Value",Float) = 1.0
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

            float _Value;
            
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
                float2 uv : TEXCOORD0;
              //  float4 uv : TEXCOORD1;
              //  float4 uv : TEXCOORD2;
              //  float4 uv : TEXCOORD3;
                float4 vertex : SV_POSITION;
            };


            Interpolators vert (Meshdata v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);   
                return o;
            }

            float4 frag (Interpolators i) : SV_Target
            { 
                return float4(1,0,0,1);
            }
            ENDCG
        }
    }
}
