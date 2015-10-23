Shader "VJ15/2Textures"
{
	Properties
	{
		_Texture1 ( "Texture 1", 2D ) = "white" {}
		_Texture2 ( "Texture 2", 2D ) = "white" {}
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
			
			sampler2D _Texture1;
			sampler2D _Texture2;
			
			v2f vert ( appdata v )
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = v.texcoord;
				return o;
			}
			
			fixed4 frag ( v2f i ) : COLOR
			{
				fixed4 col1 = tex2D(_Texture1, i.texcoord);
				fixed4 col2 = tex2D(_Texture2, i.texcoord);
				return col1 + col2; // Additive
//				return col1 * col2; // Multiply
			}
			ENDCG
		}
	}
}