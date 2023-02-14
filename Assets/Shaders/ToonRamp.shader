Shader "Custom/ToonRamp"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _RampTex ("Ramp Texture", 2D) = "white" {}
        _RimColor("Rim Color", Color) = (0,0.5,0.5,0)
        _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
    }
        SubShader
    {
        Tags {"RenderType" = "Opaque"}
        LOD 200

        CGPROGRAM
        #pragma surface surf ToonRamp

        sampler2D _MainTex;
        sampler2D _RampTex;
        float4 _RimColor;
        float _RimPower;

        float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            float diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 ramp = tex2D(_RampTex, rh).rgb;

            float4 t;
            t.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            t.a = s.Alpha;
            return t;
        }

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_RampTex;
            float3 viewDir;

        };


    
        void surf (Input IN, inout SurfaceOutput o)
        {
            half4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = 0.1 - _RimColor.rgb * pow(rim, _RimPower);



        }
        ENDCG
    }
    FallBack "Diffuse"
}
