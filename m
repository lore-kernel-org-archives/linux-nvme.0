From: hare@suse.de (Hannes Reinecke)
Date: Wed, 4 Oct 2017 07:42:00 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <20171003115506.GC24650@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
 <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
 <20171003115506.GC24650@lst.de>
Message-ID: <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>

On 10/03/2017 01:55 PM, Christoph Hellwig wrote:
> On Tue, Oct 03, 2017@12:08:26PM +0200, Hannes Reinecke wrote:
>> With this patch dm-multipath will ignore this device, so it's
>> _impossible_ to setup any device-mapper or md device on top of the
>> 'nvme' device.
>> Without this patch md will happily autostart any RAID device on these
>> devices when it find a signature.
>> Or the user can mount it.
>> Or swap can attach it as a swapspace.
>>
>> _AND_ you can do the same with the subsystem device, too, without any
>> indication that anything is amiss.
>>
>> Do we really want this?
> 
> I though we agreed last week to do dynamic claiming.
> 
> That is if someone claims the multipath-device we extend that claim to
> all /dev/nvmeXnY devices, and if someone claims one of the /dev/nvmeXnY
> devices we extent it to the multipath node.  That should solve all of
> the above issues.
> 
Hmm. Not sure how you would be doing that. Who should be doing the
claiming? Typically the claim is done whenever a device is created on
top of the other...

What about an alternative plan: make creation of the subsystem device
fully dynamic.
But if a subsystem device is created it will always claim the underlying
device. Then we can make the creation dependent on the NMIC attribute,
and existing setups would not be affected.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
