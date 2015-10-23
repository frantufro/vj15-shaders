Shader "VJ15/LUT"
{
	Properties
	{
		_MainTex ( "Main Texture", 2D ) = "white" {}
		_Radius  ( "Radius", Range(0,1)) = 0.5
	}

	SubShader
	{
		
		Pass
		{
			CGPROGRAM
			#include "UnityCG.cginc"
			
			#pragma vertex vert
			#pragma fragment frag
			
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
			
			v2f vert ( appdata v )
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = v.texcoord;
				return o;
			}
			
			fixed2 lut ( fixed2 uv )
			{
				float x = -1 + 2 * uv.x;
				float y = -1 + 2 * uv.y;
				float d = sqrt( x*x + y*y );
				float a = atan2( y, x );
				
				float u = cos(a) / d;
				float v = sin(a) / d;
				
				return fixed2(fmod(u,1), fmod(v,1));
			}
			
			fixed4 frag ( v2f i ) : COLOR
			{
				fixed4 col = tex2D(_MainTex, lut(i.texcoord) + fixed2(_Time.x) );
				return col;
			}
			ENDCG
		}
	}
}