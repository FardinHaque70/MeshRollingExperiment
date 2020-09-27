using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class RollTrigger : MonoBehaviour
{
	public UnityEvent onTap;

	private void OnMouseDown()
	{
		if ( GameManager.instance.hasControl )
			onTap?.Invoke();
	}
}
