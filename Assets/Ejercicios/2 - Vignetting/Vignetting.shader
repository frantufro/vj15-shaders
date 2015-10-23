Shader "VJ15/Vignetting" {
	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_Range   ("Range", Range(0,1)) = 0.5
	}
	
	SubShader 
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			
			struct appdata 
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f 
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};
			
			sampler2D _MainTex;
			float _Range;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = v.texcoord;
				return o;
			}
			
			fixed2 lut ( fixed2 uv )
			{
				float x = -1.00 + 2.00 * uv.x;
				float y = -1.00 + 2.00 * uv.y;
				float d = sqrt( x*x + y*y);
				float a = atan2(y, x);
				
				float u = cos ( a ) / d;
				float v = sin ( a ) / d;
				
				return fixed2(fmod( u, 1.0f), fmod(v, 1.0f));
			}
			
			fixed4 frag (v2f i) : COLOR
			{				
				fixed4 col = tex2D(_MainTex, i.texcoord );
				fixed vignetting = _Range - length(i.texcoord - 0.5);
				return vignetting;
			}

			ENDCG
		}
	} 
}
