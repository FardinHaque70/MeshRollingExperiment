using NaughtyAttributes;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelManager : MonoBehaviour
{
	public static LevelManager instance;
	[SerializeField] float yOffsetAmount = 0.02f;
	public int totalRollSystemCount = 0;
	public int placedCount = 0;
	public List<RollSystem> placedRollSystems;

	[ReadOnly] public bool isLevelComplete = false;
	private void Awake()
	{
		if ( instance == null )
			instance = this;
		else
			Destroy(gameObject);
	}

	public float GetHeight()
	{
		return placedCount * yOffsetAmount;
	}

	[Button]
	public void CheckAccuracy()
	{
		if ( placedCount != totalRollSystemCount || isLevelComplete)
		{
			return;
		}
		/*for ( int i = 0; i < placedRollSystems.Count; i++ )
		{
			if ( placedRollSystems[i].orderMatters )
			{
				if ( i != (placedRollSystems[i].order - 1) )
				{
					Debug.Log("Miss match: " + i + ": " + (placedRollSystems[i].order - 1).ToString());
					return;
				}
			}
		}

		Debug.Log("All placed correctly");
		*/

		for ( int i = 0; i < totalRollSystemCount; i++ )
		{
			if ( placedRollSystems[i].CheckOrderAccuracy() == false )
			{
				Debug.LogError("incorect Placement");
				return;
			}
		}

		Debug.Log("All placed correctly");
		OnLevelComplete();
	}

	public void OnUnfold(RollSystem rollSystem)
	{
		placedCount++;
		placedRollSystems.Add(rollSystem);
	}
	public void OnFold(RollSystem rollSystem)
	{
		placedCount--;
		placedRollSystems.Remove(rollSystem);
		RecalculateHeights();
	}

	public void RecalculateHeights()
	{
		for ( int i = 0; i < placedRollSystems.Count; i++ )
		{
			placedRollSystems[i].transform.position = new Vector3(placedRollSystems[i].transform.position.x , (i+1) * yOffsetAmount , placedRollSystems[i].transform.position.z);
		}
	}

	private void OnLevelComplete()
	{
		isLevelComplete = true;
		placedRollSystems.Clear();
		placedCount = 0;
		totalRollSystemCount = 0;
		GameManager.instance.hasControl = false;
		GameManager.instance.OnLevelComplete();
		UIManager.instance.ScreenFlash();
	}
}
