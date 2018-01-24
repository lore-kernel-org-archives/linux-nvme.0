From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Jan 2018 20:46:43 +0200
Subject: [LSF/MM TOPIC] NVMe over Fabrics auto-discovery in Linux
In-Reply-To: <1e47cf3c-b7b7-ac91-f9e4-7588473b7aca@broadcom.com>
References: <20180123151132.wrbc7dcjjhpzcnba@linux-x5ow.site>
 <464f1939-e3e6-95bc-f3d4-fcb83dfbf075@wdc.com>
 <860c9d4a-af17-e0d3-5ef1-3224821cda86@suse.de>
 <1e47cf3c-b7b7-ac91-f9e4-7588473b7aca@broadcom.com>
Message-ID: <77fbf020-38df-a88d-6bbb-0328d946cf8b@grimberg.me>


>> Partially beside the point.
>>
>> The problem currently is that FC-NVMe is the only transport which
>> implements dev_loss_tmo, causing connections to be dropped completely
>> after a certain time.
>> After that the user has to manually re-establish the connection via
>> nvme-cli, or one has to create some udev/systemd interaction (cf the
>> thread "nvme/fc: add 'discovery' sysfs attribute to fc transport
>> devices" and others).
>>
>> The other transports just keep the reconnection loop running, and the
>> user has to manually _disconnect_ here.
>>
>> So we have a difference in user experience, which should be reconciled.
> 
> This is incorrect. Rdma (and FC too) have the reconnect_delay timer that 
> caps, on a per-controller basis, how long the reconnection loop will run 
> before the controller is deleted.

echo that...

> As stated by Johannes, the real difference in behavior is establishing 
> the initial connectivity as well as those auto-reconnect behaviors where 
> connectivity was lost and later regained.

I agree that this is a problem for IP based transports. So until we
have discovery enhancements we probably need to poll predefined
discovery subsystems periodically and cross check with what we are
connected to like iscsi discoveryd..

>> Also, a user-space based rediscovery/reconnect will get tricky during
>> path failover, as one might end up with all connections down and no way
>> of ever being _able_ to call nvme-cli as the root fs in inaccessible.
>> But that might be another topic.

Again, polling discovery subsystems every X time will overcome that...

> I don't disagree with this, and do believe, that to support low-memory 
> issues during failover and reconnectivity (as we've seen in the past), 
> as well as to make booting easier (stop futzing with ramdisk), it will 
> likely require some amount of nvme discovery engine within the kernel. 
> It's difficult as without things like SSDP or LSP, rdma and tcp can't 
> really do this without admin help. But as you say - this can be a later 
> topic.

I hope fabrics 1.1 discovery enhancements will tackle all that...
