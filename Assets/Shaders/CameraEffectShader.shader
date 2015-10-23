Shader "VJ15/CameraEfect"
{
	Properties
	{
		_MainTex ( "Main Texture", 2D ) = "white" {}
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
			
			fixed4 frag ( v2f i ) : COLOR
			{
				fixed4 col1 = float4(1,0,0,1) * sin(_Time.y);
				fixed4 col = tex2D(_MainTex, i.texcoord);
				return col + col1;
			}
			ENDCG
		}
	}
}