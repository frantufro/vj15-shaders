using UnityEngine;
using System.Collections;

public class CameraEffect : MonoBehaviour 
{
	public Material material;

	void OnRenderImage ( RenderTexture src, RenderTexture dst)
	{
		Graphics.Blit(src, dst, material);
	}
}
