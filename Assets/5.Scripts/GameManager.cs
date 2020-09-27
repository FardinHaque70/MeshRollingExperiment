using NaughtyAttributes;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
	[System.Serializable]
	public struct LevelData
	{
		public GameObject levelblock;
		public Sprite referenceSprite;
	}


	public static GameManager instance;
	public int currentLevelIndex = 0;
	[ReadOnly] public bool hasControl = true;
	[SerializeField] ParticleSystem winParticle = null;
	[ReorderableList][SerializeField] LevelData[] levelData = null;


	private void Awake()
	{
		if ( instance == null )
			instance = this;
		else
			Destroy(gameObject);
	}

	private void Start()
	{
		for ( int i = 0; i < levelData.Length; i++ )
		{
			if ( i == currentLevelIndex )
				levelData[currentLevelIndex].levelblock.SetActive(true);
			else
				levelData[i].levelblock.SetActive(false);
		}
	}

	[Button]
	public void OnLevelComplete()
	{
		StartCoroutine(_LoadNextLevel());
	}

	private IEnumerator _LoadNextLevel()
	{
		yield return new WaitForSeconds(0.3f);
		winParticle.Play();

		yield return new WaitForSeconds(2);

		winParticle.Stop();

		levelData[currentLevelIndex].levelblock.SetActive(false);

		currentLevelIndex++;
		if ( currentLevelIndex >= levelData.Length )
			currentLevelIndex = 0;

		levelData[currentLevelIndex].levelblock.SetActive(true);

		hasControl = true;
		LevelManager.instance.isLevelComplete = false;

		UIManager.instance.SetupLevelUI(levelData[currentLevelIndex].referenceSprite);
	}

}
