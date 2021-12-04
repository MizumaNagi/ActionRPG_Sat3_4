Shader "Unlit/UnlitMulTexCol"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BlendTex ("Blend", 2D) = "white" {}
        _BlendRate("Blend Rate", Range(0.01, 1.0)) = 0.5
        _MaskTex("Mask", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _BlendTex;
            float _BlendRate;

            sampler2D _MaskTex;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 blendCol = tex2D(_BlendTex, i.uv);
                fixed4 maskCol = tex2D(_MaskTex, i.uv)

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);

                // ŒÅ’è”ä—¦
                fixed4 finalCol = lerp(col, blendCol, _BlendRate);

                fixed4 finalCol = lerp(col, blendCol, maskCol);
                return finalCol;
            }
            ENDCG
        }
    }
}
