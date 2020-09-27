using DG.Tweening;
using NaughtyAttributes;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RollSystem : MonoBehaviour
{
	public bool orderMatters = false;
	//[ShowIf("orderMatters")] public int order = -1;
	[ShowIf("orderMatters")] public RollSystem[] stayAbove = null;
	[ShowIf("orderMatters")] public RollSystem[] stayBelow = null;
	[HorizontalLine]
	[SerializeField] MeshRenderer meshRend = null;
	[SerializeField] float speed = 1;
	[ReadOnly, SerializeField] private bool isBusy = false;
	[ReadOnly, SerializeField] private bool isFolded = true;


	[BoxGroup("Shader Properties")][SerializeField] Color color = Color.yellow;
	[BoxGroup("Shader Properties")][Range(0,1),SerializeField] float unfold = 1;
	[BoxGroup("Shader Properties")][SerializeField] float xOffset = 16;
	[BoxGroup("Shader Properties")][Range(0.01f, 0.1f), SerializeField] float scale = 0.02f;


	[Foldout("Triggers")][SerializeField] GameObject foldTriggerObject = null;
	[Foldout("Triggers")][SerializeField] GameObject unfoldTriggerObject = null;

	private string foldShaderID = "_Fold";
	private string xOffsetShaderID = "_XOffset";
	private string scalehaderID = "_Scale";
	private MaterialPropertyBlock propertyBlock;
	//[ReadOnly, SerializeField] private Material mat = null;
	Tween yTween;

	private void OnEnable()
	{
		LevelManager.instance.totalRollSystemCount++;
		unfold = 0;
		isFolded = true;
		
		//Toggling touch triggers
		foldTriggerObject.SetActive(false);
		unfoldTriggerObject.SetActive(true);

		SetMaterialProperty();
	}

	private void OnValidate()
	{
		SetMaterialProperty();
	}

	private void SetMaterialProperty()
	{
		if ( propertyBlock == null )
			propertyBlock = new MaterialPropertyBlock();


		propertyBlock.SetColor("_MainColor" , color);
		propertyBlock.SetFloat(foldShaderID , unfold);
		propertyBlock.SetFloat(xOffsetShaderID , xOffset);
		propertyBlock.SetFloat(scalehaderID , scale);



		meshRend.SetPropertyBlock(propertyBlock);


		/*if ( mat == null )
			mat = meshRend.material;

		mat.SetFloat(xOffsetShaderID , xOffset);*/
	}

	[Button]
	public void Fold()
	{
		if ( isBusy || isFolded )
			return;
		//LevelManager.instance.placedCount--;
		//LevelManager.instance.placedRollSystems.Remove(this);

		LevelManager.instance.OnFold(this);

		//Toggling touch triggers
		foldTriggerObject.SetActive(false);
		unfoldTriggerObject.SetActive(true);

		yTween.Kill();
		yTween = transform.DOMoveY(0 , 1);

		StartCoroutine(_SetShaderValue(1 , 0 , speed , foldShaderID));
		
		/// Fold objects placed above
		//StartCoroutine(_Fold());
	}

	[Button]
	public void Unfold()
	{
		if ( isBusy || !isFolded )
			return;

		//LevelManager.instance.placedCount++;
		//LevelManager.instance.placedRollSystems.Add(this);

		LevelManager.instance.OnUnfold(this);

		//Toggling touch triggers
		foldTriggerObject.SetActive(true);
		unfoldTriggerObject.SetActive(false);

		yTween.Kill();
		yTween = transform.DOMoveY(LevelManager.instance.GetHeight() , speed).SetSpeedBased();

		StartCoroutine(_SetShaderValue(0 , 1 , speed / 2 , foldShaderID));


	}

	private IEnumerator _Fold()
	{
		for ( int i = 0; i < stayBelow.Length; i++ )
		{
			stayBelow[i].Fold();
			yield return new WaitForSeconds(0.3f);
		}
		//LevelManager.instance.placedCount--;
		//LevelManager.instance.placedRollSystems.Remove(this);
		LevelManager.instance.OnFold(this);

		//Toggling touch triggers
		foldTriggerObject.SetActive(false);
		unfoldTriggerObject.SetActive(true);

		yTween.Kill();
		yTween = transform.DOMoveY(0 , 1);

		StartCoroutine(_SetShaderValue(1 , 0 , speed , foldShaderID));


	}
	private IEnumerator _SetShaderValue( float startValue , float endValue , float speed , string valueTitle )
	{
		isBusy = true;
		unfold = startValue;
		SetMaterialProperty();
		
		/// Unfolding
		if ( startValue < endValue )
		{
			while ( unfold < 1 )
			{
				unfold += speed * Time.deltaTime;
				SetMaterialProperty();
				yield return null;
			}
			//LevelManager.instance.OnUnfold(this);
			LevelManager.instance.CheckAccuracy();

			isFolded = false;
		}
		/// Folding
		else
		{
			while ( unfold > 0 )
			{
				unfold -= speed * Time.deltaTime;
				SetMaterialProperty();
				yield return null;
			}
			//LevelManager.instance.OnFold(this);
			isFolded = true;
		}

		isBusy = false;

	}

	[Button]
	public bool CheckOrderAccuracy()
	{
		if ( orderMatters == false )
			return true;

		for ( int i = 0; i < stayAbove.Length; i++ )
		{
			if ( transform.position.y < stayAbove[i].transform.position.y )
			{
				return false;
			}
		}

		for ( int i = 0; i < stayBelow.Length; i++ )
		{
			if ( transform.position.y > stayBelow[i].transform.position.y )
			{
				return false;
			}
		}
		return true;
	}
}
