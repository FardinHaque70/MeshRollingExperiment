using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    public static UIManager instance;
    [SerializeField] Image referenceImage = null;

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
}
