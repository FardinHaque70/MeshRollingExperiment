using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    public static UIManager instance;
    [SerializeField] Image referenceImage = null;
	[SerializeField] Image whiteFlashImage = null;
	private void Awake()
	{
		if ( instance == null )
			instance = this;
		else
			Destroy(gameObject);
	}
	public void SetupLevelUI(Sprite refSprite)
    {
        referenceImage.sprite = refSprite;
    }
	public void ScreenFlash()
	{
		whiteFlashImage.color = new Color(1 , 1 , 1 , 1);
		whiteFlashImage.DOFade(0 , 0.4f);
	}
}
