From: james.smart@broadcom.com (James Smart)
Date: Wed, 24 Jan 2018 09:17:24 -0800
Subject: [LSF/MM TOPIC] NVMe over Fabrics auto-discovery in Linux
In-Reply-To: <860c9d4a-af17-e0d3-5ef1-3224821cda86@suse.de>
References: <20180123151132.wrbc7dcjjhpzcnba@linux-x5ow.site>
 <464f1939-e3e6-95bc-f3d4-fcb83dfbf075@wdc.com>
 <860c9d4a-af17-e0d3-5ef1-3224821cda86@suse.de>
Message-ID: <1e47cf3c-b7b7-ac91-f9e4-7588473b7aca@broadcom.com>

On 1/24/2018 12:26 AM, Hannes Reinecke wrote:
> Partially beside the point.
>
> The problem currently is that FC-NVMe is the only transport which
> implements dev_loss_tmo, causing connections to be dropped completely
> after a certain time.
> After that the user has to manually re-establish the connection via
> nvme-cli, or one has to create some udev/systemd interaction (cf the
> thread "nvme/fc: add 'discovery' sysfs attribute to fc transport
> devices" and others).
>
> The other transports just keep the reconnection loop running, and the
> user has to manually _disconnect_ here.
>
> So we have a difference in user experience, which should be reconciled.

This is incorrect. Rdma (and FC too) have the reconnect_delay timer that 
caps, on a per-controller basis, how long the reconnection loop will run 
before the controller is deleted.?? In FC's case, as we know the state 
of the node, which may have multiple controllers connected via it, and 
have inherited the SCSI semantics for how long to wait for connectivity 
to a node before giving up - thus FC's reconnect window is capped at 
min(controller reconnect_delay, fc node dev_loss_tmo).

So it is the same experience - at least in termination behavior. It 
possibly is the same in recovery after this full termination/deletion of 
the controller has been done as well.
If there is connectivity yet the controller reconnect_delay expired, FC 
will need the manual reconnect action just like rdma. However, FC will 
support, if you go through a loss of connectivity followed by 
connectivity, it can auto-matically reconnect back to the storage - 
granted it may have a different /dev name at that point.

As stated by Johannes, the real difference in behavior is establishing 
the initial connectivity as well as those auto-reconnect behaviors where 
connectivity was lost and later regained.

>
> Also, a user-space based rediscovery/reconnect will get tricky during
> path failover, as one might end up with all connections down and no way
> of ever being _able_ to call nvme-cli as the root fs in inaccessible.
> But that might be another topic.
>
> Cheers,
>
> Hannes

I don't disagree with this, and do believe, that to support low-memory 
issues during failover and reconnectivity (as we've seen in the past), 
as well as to make booting easier (stop futzing with ramdisk), it will 
likely require some amount of nvme discovery engine within the kernel.? 
It's difficult as without things like SSDP or LSP, rdma and tcp can't 
really do this without admin help. But as you say - this can be a later 
topic.

-- james
