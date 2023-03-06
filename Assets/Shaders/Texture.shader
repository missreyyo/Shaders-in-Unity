Shader "Unlit/Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _secondTex ("Texture", 2D) = "white" {}
     _pattern ("Pattern", 2D) = "white" {}
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

            struct Meshdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Interpolators
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 worldCoords: TEXCOORD1;
            };

            sampler2D _MainTex;
            sampler2D _secondTex;
            sampler2D _pattern;
            float4 _MainTex_ST;
 
            Interpolators vert (Meshdata v)
            {
                Interpolators o;
                o.worldCoords = mul (UNITY_MATRIX_M, float4(v.vertex.xyz, 1));
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
           //     o.uv = TRANSFORM_TEX(v.uv, _MainTex);
           //     o.uv.x += _Time.y * 0.1;
                return o;
            }

            fixed4 frag (Interpolators i) : SV_Target
            {
                float2 topDownProjection = i.worldCoords.xz;
                float4 moss = tex2D(_MainTex, topDownProjection);
                float4 second = tex2D(_secondTex, topDownProjection);
                float pattern = tex2D(_pattern, i.uv).x;
                float4 finalColor = lerp(second, moss,pattern);
                // sample the texture
                return finalColor;
             return float4(i.worldCoords.xyz, 1);   // color changing with position 
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;  // texture sample
            }
            ENDCG
        }
    }
}
