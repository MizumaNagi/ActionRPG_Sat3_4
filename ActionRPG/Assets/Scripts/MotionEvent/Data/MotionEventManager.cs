using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MotionEventManager
{
    private static MotionEventManager instance = null;
    public static MotionEventManager Instance
    {
        get
        {
            if(instance == null)
            {
                instance = new MotionEventManager();
            }

            return instance;
        }
    }

    private MotionEventManager() { }

    public void Execute(string[] dataList)
    {
        if (dataList == null) { return; }

        foreach(var eventId in dataList)
        {
            uint targetEventId = 0U;
            if(!uint.TryParse(eventId, out targetEventId))
            {
                Debug.LogError("Executed Fail Event ID:" + targetEventId);
                continue;
            }

            Debug.Log("Executed Event ID:" + targetEventId);
        }
    }

}
