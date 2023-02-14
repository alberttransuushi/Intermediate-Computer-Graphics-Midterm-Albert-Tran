using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SimpleRotation : MonoBehaviour
{
    public GameObject target;
    void Update()
    {
        transform.RotateAround(target.transform.position / 300, Vector3.up, 20 * Time.deltaTime);
    }
}
