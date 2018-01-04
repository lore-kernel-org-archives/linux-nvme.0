From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 04 Jan 2018 12:24:42 -0500
Subject: [PATCH 1/1] nvme: Modify the debug level for setting shutdown
 timeout
In-Reply-To: <b46266c8-e239-ac12-d66e-33d613de597b@mellanox.com> (Max
 Gurtovoy's message of "Thu, 4 Jan 2018 19:04:19 +0200")
References: <1514727207-8460-1-git-send-email-maxg@mellanox.com>
 <20180104100440.GC4436@lst.de>
 <b46266c8-e239-ac12-d66e-33d613de597b@mellanox.com>
Message-ID: <yq11sj5v8o5.fsf@oracle.com>


Max,

> but shutdown_timeout is a module param that one can set to be 10 secs
> (for example) and then it might be == transition_time and we won't see
> the print. Then is it not a buggy device anymore ? :)

The intent was to only print when the resulting shutdown_timeout
deviated from the default value (whether the driver default or the
admin-provided module parameter).

My only concern with info over warning is that info is often dropped.
And therefore you have a harder time finding out which value was in
effect when you subsequently peak at the logs.

-- 
Martin K. Petersen	Oracle Linux Engineering
