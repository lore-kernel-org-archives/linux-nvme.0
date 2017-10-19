From: jsmart2021@gmail.com (James Smart)
Date: Thu, 19 Oct 2017 11:04:38 -0700
Subject: [PATCH v3 5/5] nvme_fc: add dev_loss_tmo timeout and remoteport
 resume support
In-Reply-To: <32B40236-CB8E-461E-B765-AEF544AB981A@cavium.com>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
 <20171017233248.6769-6-jsmart2021@gmail.com>
 <32B40236-CB8E-461E-B765-AEF544AB981A@cavium.com>
Message-ID: <5c86018d-79f5-20d3-07d5-64bdd0344e34@gmail.com>

On 10/19/2017 8:46 AM, Trapp, Darren wrote:
> It seems like we need a call back to the LLD to let him know that the dev_loss_tmo has been canceled upon device coming back.

I don't think so. We already have the desired functionality in the 
remoteport_delete callback.

In SCSI we had devloss tied 1:1 with the remote_port, devloss started 
when remote_port unregistered, and when dev_loss_tmo fired thus 
releasing the remote port, we called the dev_loss_tmo_callbk. So the 
dev_loss_tmo_callbk is actually the remoteport delete callback. There 
was also the notion that the SCSI target, which is 1:1 with the remote 
port, was visible on the os until that callback occurred.

In nvme-fc, the lldd calls the unregister remoteport, and when the 
remoteport is finished/done, the remoteport_delete will be called back.
Currently that callback is based on the remoteport datastructure being 
freed which means it waits for all controllers to be freed as well.
This turns out to be rather ugly as controller freeing is based on 
namespace devices being freed, and some apps can hold on to the devnode 
a long time. So I've been wrapping up a patch that instead has the 
remoteport_delete called when all associations relative to the lldd have 
been terminated.  The association terminations are done immediately upon 
the unregister call. That should have killed all hw queues, etc leaving 
nothing left for the lldd to be tracking. Although the transport<->lldd 
associations are killed, the nvme controller and it's namespaces are 
still live relative to the os, just stalled waiting for the 
ctrl_loss_tmo or dev_loss_tmo to fire. Those timers can be/are 
completely asynchronous to the remoteport_delete.  If the lldd registers 
a new and matching remoteport, the transport will reuse the existing 
remoteport structures and related controllers, etc - just updating the 
LLDD related info (which I've found a bug or two in).

Is there a specific reason you would want to hold off the remoteport 
delete for a full dev_loss_tmo vs as soon as the transport terminates 
the references to the lldd relative to remoteport (e.g. association 
terminations)?   With the association teardowns only, it can be much 
faster than dev_loss_tmo.


> 
> The LLD has called the unregister_remoteport in the transport and done a wait_for_completion.  If the device re-appears before dev_loss_tmo has been reached, the transport cancels the del_work.  But, the LLD still has the completion event pending.

Ahh. I understand. The wait_for_completions are in the lldd and I know 
older code shows had the sequence you describe. True, if we reuse the 
remoteport struct, as references never expired, the delete call would 
have never occurred. So this is a bug with what's there.

I think the cleanest fix is to have the delete callback occur as soon as 
the delete_associations are done - as that will always occur and do so 
rather quickly. If needed, if we find we are reusing a remoteport struct 
and we hadn't called the delete, we call it prior to returning to the 
second register remoteport call, which should work as well.

note: as when we call remoteport_delete (ref cnt and free vs association 
terminate) is independent from dev_loss_tmo, it shouldn't affect this 
dev_loss patch set.

-- james
