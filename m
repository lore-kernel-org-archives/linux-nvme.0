From: hare@suse.de (Hannes Reinecke)
Date: Wed, 4 Oct 2017 08:33:07 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <20171004061533.GA20131@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
 <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
 <20171003115506.GC24650@lst.de>
 <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>
 <20171004061533.GA20131@lst.de>
Message-ID: <19dbdf11-86c4-b6ea-a18c-a78fcae822d5@suse.de>

On 10/04/2017 08:15 AM, Christoph Hellwig wrote:
> On Wed, Oct 04, 2017@07:42:00AM +0200, Hannes Reinecke wrote:
>> Hmm. Not sure how you would be doing that. Who should be doing the
>> claiming? Typically the claim is done whenever a device is created on
>> top of the other...
> 
> We'd need a callback in the driver if it is claimed, and use that
> to for propagating the claim, or use a shared struture to record the
> claim.  I haven't looked into the details yet, though.
> 
>> What about an alternative plan: make creation of the subsystem device
>> fully dynamic.
>> But if a subsystem device is created it will always claim the underlying
>> device. Then we can make the creation dependent on the NMIC attribute,
>> and existing setups would not be affected.
> 
> This doesn't work because a lot of devices can just set NMIC.  E.g.
> every namespace exported by the Linux NVMe target.
> 
But as it's fully dynamic we can decide how to handle each device on a
device-by-device basis, with a common default policy.
My idea is to have a default policy (create/not create subsystem devices
if NMIC is set) set via kernel command-line, and udev rules for devices
requiring separate handling.

Will be drafting up a set of patches to demonstrate the idea.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
