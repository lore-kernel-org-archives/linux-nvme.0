From: jsmart2021@gmail.com (James Smart)
Date: Tue, 23 May 2017 10:01:00 -0700
Subject: [PATCH 0/8] nvme_fc: add dev_loss_tmo support
In-Reply-To: <20170523072008.GB31698@infradead.org>
References: <20170513190722.25536-1-jsmart2021@gmail.com>
 <20170523072008.GB31698@infradead.org>
Message-ID: <4836f881-d358-74cc-88f2-1e0bf3e68a07@gmail.com>

On 5/23/2017 12:20 AM, Christoph Hellwig wrote:
> On Sat, May 13, 2017@12:07:14PM -0700, James Smart wrote:
>> As the fabrics implementation already has a similar behavior
>> introduced on rdma, the ctrl_loss_tmo, which may be set on a
>> controller basis (finer granularity than the FC port used for the
>> connection), the nvme_fc transport will mediate and choose the lesser
>> of the controllers value and the remoteports value.
>
> I would much prefer if nvme-fc could stick to the same controller
> concept as rdma.  Especially as it needs to be synchronized with
> the reconnect delay and the keep alive timeout (and we need to
> do a better job on synchronize the latter to start with I think).

Not sure which controller concept you are thinking it isn't staying in 
sync with. ctrl_loss_tmo is continued, but it is augmented by having to 
deal with a node-level timeout that exists on FC, which rdma doesn't 
have. reconnect_delay is still used, but disabled if there's no 
connectivity as there's no point in re-trying a connect if there's no 
connectivity.  The only other semantic nvme-fc does differently (and its 
somewhat a different topic) is: on controller resets, don't tear down if 
the 1st reconnect attempt fails, at least wait the duration of 
ctrl_loss_tmo and use reconnect_delay for other attempts if connected.

If the main issue is: you don't want to have a 2nd timeout value merged 
with the connect-request's ctrl_loss_tmo value, then we need to work out 
a solution. I don't want to make admins learn a new way to set per-node 
timeout values, which should apply to SCSI and NVME equally, and can be 
dynamic. Right now, they come from the SCSI fc transport, and there's a 
lot of admin and infrastructure around management from that area. I 
don't believe you can just ignore it.  So the simple choice, which was 
proposed, was to simply merge them in the transport. The result is still 
ctrl_loss_tmo with reconnect delay, but nvme-fc: a) changes the value 
from what the connect request if node-level value is smaller; and b) it 
can dynamically change if the node-level value dynamically changes.

One thing I can propose - if we're using uevents to trigger connect 
requests, is to have the uevents specify the ctrl_loss_tmo values to use 
for the connect request, which would be based on the node-level devloss 
value. This would keep all the timeout values coming in via the connect 
request.  I dislike pushing too much information like this through udev 
to a cli and back, but it would work. It still won't deal with dynamic 
updates, so some thoughts are needed to address that aspect.

Thoughts ?

-- james
