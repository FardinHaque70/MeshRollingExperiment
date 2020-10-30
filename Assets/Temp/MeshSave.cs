using NaughtyAttributes;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Parabox.CSG;

public class MeshSave : MonoBehaviour
{
	[SerializeField] Material mat = null;
	[SerializeField] GameObject ground = null;
	[SerializeField] MeshFilter refMeshFilter = null;

	private GameObject newGO;
	private Mesh mesh;
	private Vector3[] vertices;
	private int[] triangles;
	private Vector3[] normals;

	[Button]
	private void GetMeshData()
	{
		if ( refMeshFilter == null )
			return;

		// Get Mesh Data
		mesh = refMeshFilter.sharedMesh;
		vertices = mesh.vertices;
		triangles = mesh.triangles;
		normals = mesh.normals;
	}
	[Button]
	private void CreateMesh()
	{
		Mesh newMesh = new Mesh();
		newMesh.vertices = vertices;
		newMesh.triangles = triangles;
		newMesh.normals = normals;

		newGO = new GameObject("NewShape");
		newGO.AddComponent<MeshFilter>().mesh = newMesh;
		newGO.AddComponent<MeshRenderer>().material = mat;
		newGO.transform.parent = transform;
	}

	[Button]
	private void BoolOperation()
	{
		//GameObject cube = GameObject.CreatePrimitive(PrimitiveType.Cube);
		//GameObject sphere = GameObject.CreatePrimitive(PrimitiveType.Sphere);
		//sphere.transform.localScale = Vector3.one * 1.3f;

		// Perform boolean operation
		CSG_Model result = Boolean.Subtract(ground, newGO);

		// Create a gameObject to render the result
		GameObject composite = new GameObject();
		composite.AddComponent<MeshFilter>().sharedMesh = result.mesh;
		composite.AddComponent<MeshRenderer>().sharedMaterials = result.materials.ToArray();
	}
}
