From: hare@suse.de (Hannes Reinecke)
Date: Mon, 29 Jul 2019 10:31:53 +0200
Subject: [PATCH v3] nvme: fix controller removal race with scan work
In-Reply-To: <93c38a70-3500-b1eb-38c7-41419c8f64c8@grimberg.me>
References: <20190725185657.9025-1-sagi@grimberg.me>
 <a5ce0b2d-e4d5-ab79-442c-4c3795fdb0fd@suse.de>
 <93c38a70-3500-b1eb-38c7-41419c8f64c8@grimberg.me>
Message-ID: <df50ec95-0ca1-58be-1660-101529a72662@suse.de>

On 7/26/19 7:39 PM, Sagi Grimberg wrote:
> 
>> Weellll ... I'm not sure if I totally agree with this one.
> 
> That's fair...
> 
>> As you might know I'm chasing down the mysterious reset/rescan issue,
>> too, and still haven't been able to resolve is properly.
> 
> Have you tried the patch that I proposed to you?
> 
Yeah. But reports are still inconclusive due to the second problem.
And

> This is a different problem than what you reported, this is
> addressing the scenario that the host connects and quickly
> disconnects from a client before the scan is completed AND
> multipath is enabled.
> 
.... Which is precisely the failure scenario for my problem, too ...

>> But looking at this patch the hunk for clearing the current path on
>> removing namespaces looks like a good idea on itself.
>> Care to separate this out?
> 
> Sure, although its designed to address this issue and not very
> effective without the other part.
> 
>> Thing is, I had been notified on a regression caused by commit
>> 525aa5a705d86e ("nvme-multipath: split bios with the ns_head..."),
>> which manifests itself by a spurious I/O error during failover.
> 
> Hmm, this is interesting. Not sure how this specific commit would
> introduce such an issue.
> 
See? Me neither. Sadly they _have_ bisected it, and this really is the
patch introducing the regression.
Current thinking is that we're dropping all paths during reset, causing
ns_head to be deleted, too. The ns_head will get recreated immediately
afterwards, so userspace wouldn't even notice that.
But if we have a non-empty requeue list that will be flushed only when
doing the final put on the ns_head structure, causing all I/O to fail.

So looking at it that way, it _might_ actually be that your patch helps
for that situation, too, seeing that we can't reliably enumerate
namespaces during reset.

I'll give it a try and will get back to you with the results.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
