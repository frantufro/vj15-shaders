Shader "VJ15/Texture"
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
			float _Radius;
			
			v2f vert ( appdata v )
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = v.texcoord;
				return o;
			}
			
			fixed4 frag ( v2f i ) : COLOR
			{
				fixed4 col = tex2D(_MainTex, i.texcoord);
				return col;
			}
			ENDCG
		}
	}
}