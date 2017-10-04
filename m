From: hare@suse.de (Hannes Reinecke)
Date: Wed, 4 Oct 2017 09:26:56 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <20171004071312.GA21143@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
 <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
 <20171003115506.GC24650@lst.de>
 <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>
 <20171004061533.GA20131@lst.de>
 <19dbdf11-86c4-b6ea-a18c-a78fcae822d5@suse.de>
 <20171004071312.GA21143@lst.de>
Message-ID: <d476287b-63b2-f1ee-ba18-73e55a70da49@suse.de>

On 10/04/2017 09:13 AM, Christoph Hellwig wrote:
> On Wed, Oct 04, 2017@08:33:07AM +0200, Hannes Reinecke wrote:
>>> On Wed, Oct 04, 2017@07:42:00AM +0200, Hannes Reinecke wrote:
>>>> Hmm. Not sure how you would be doing that. Who should be doing the
>>>> claiming? Typically the claim is done whenever a device is created on
>>>> top of the other...
>>>
>>> We'd need a callback in the driver if it is claimed, and use that
>>> to for propagating the claim, or use a shared struture to record the
>>> claim.  I haven't looked into the details yet, though.
>>>
>>>> What about an alternative plan: make creation of the subsystem device
>>>> fully dynamic.
>>>> But if a subsystem device is created it will always claim the underlying
>>>> device. Then we can make the creation dependent on the NMIC attribute,
>>>> and existing setups would not be affected.
>>>
>>> This doesn't work because a lot of devices can just set NMIC.  E.g.
>>> every namespace exported by the Linux NVMe target.
>>>
>> But as it's fully dynamic we can decide how to handle each device on a
>> device-by-device basis, with a common default policy.
> 
> What do you mean with fully dynamic?
> 
>> My idea is to have a default policy (create/not create subsystem devices
>> if NMIC is set) set via kernel command-line, and udev rules for devices
>> requiring separate handling.
> 
> Yikes.  That's exactly where I do _not_ want to go.  No more arcane
> magic setup that you need to be in the in group for to know like
> dm-multipath.  Things must just work, period.
> 
:-)
I knew you'd be answering that.
I do agree that we need to make the setup as simple as possible.
But at the same time we should avoid the mistakes we've made with
dm-multipathing.

> The only other option I could think of would be to turn names around:
> make /dev/nvmeX (chardev) and /dev/nvmeXnY the per-subsystem devices
> that are multipathed if available.  We'd then need new devices for the
> invdividual controllers.  With a little luck we'd get away with just
> creating character devices.  This would however create a problem for
> dm-multipath users, which mostly is you and your paterners/customers.
> 
_That_ idea is by far the best approach I've seen so far.
Which would essentially move the entire path hierarchy _below_ the nvme
device, and we would always have a single device node to speak with.
Which will decrease the maintenance burden for us poor souls having to
make a distribution out of it.

_Plus_ we can rearrange things underneath it even when mounted, so with
this approach it would be possible to move from non-multipath to
multipath and vice versa.

So go for it.

> Note that in general dm-multipath should continue working but it would
> generally just see one path.
> 
Yeah, to be expected. But I guess I can find ways around this.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
