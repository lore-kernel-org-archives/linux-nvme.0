From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 4 Jan 2018 19:48:04 +0200
Subject: [PATCH 1/1] nvme: Modify the debug level for setting shutdown
 timeout
In-Reply-To: <yq11sj5v8o5.fsf@oracle.com>
References: <1514727207-8460-1-git-send-email-maxg@mellanox.com>
 <20180104100440.GC4436@lst.de>
 <b46266c8-e239-ac12-d66e-33d613de597b@mellanox.com>
 <yq11sj5v8o5.fsf@oracle.com>
Message-ID: <fd7305d1-e76c-bcce-ccfb-07f4be27f3ab@mellanox.com>

Hi Martin,


On 1/4/2018 7:24 PM, Martin K. Petersen wrote:
> 
> Max,
> 
>> but shutdown_timeout is a module param that one can set to be 10 secs
>> (for example) and then it might be == transition_time and we won't see
>> the print. Then is it not a buggy device anymore ? :)
> 
> The intent was to only print when the resulting shutdown_timeout
> deviated from the default value (whether the driver default or the
> admin-provided module parameter).
> 
> My only concern with info over warning is that info is often dropped.
> And therefore you have a harder time finding out which value was in
> effect when you subsequently peak at the logs.
> 

Ok, it just bothered me to see this print every time I probed the device.
But I can live with that. You can ignore this patch.

-Max.
