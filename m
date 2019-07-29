From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jul 2019 09:11:45 -0700
Subject: [PATCH v3] nvme: fix controller removal race with scan work
In-Reply-To: <df50ec95-0ca1-58be-1660-101529a72662@suse.de>
References: <20190725185657.9025-1-sagi@grimberg.me>
 <a5ce0b2d-e4d5-ab79-442c-4c3795fdb0fd@suse.de>
 <93c38a70-3500-b1eb-38c7-41419c8f64c8@grimberg.me>
 <df50ec95-0ca1-58be-1660-101529a72662@suse.de>
Message-ID: <1bf56b26-a521-8de2-5d52-0c1c9d19fd25@grimberg.me>


>>> As you might know I'm chasing down the mysterious reset/rescan issue,
>>> too, and still haven't been able to resolve is properly.
>>
>> Have you tried the patch that I proposed to you?
>>
> Yeah. But reports are still inconclusive due to the second problem.
> And

OK, looking forward to understanding the root-cause and if/how
we can address this.

>> This is a different problem than what you reported, this is
>> addressing the scenario that the host connects and quickly
>> disconnects from a client before the scan is completed AND
>> multipath is enabled.
>>
> .... Which is precisely the failure scenario for my problem, too ...

Hannes, I'm a bit confused again. I was under the impression that
your issues were around controller reset race with scan, not controller
removal (disconnect).

>>> Thing is, I had been notified on a regression caused by commit
>>> 525aa5a705d86e ("nvme-multipath: split bios with the ns_head..."),
>>> which manifests itself by a spurious I/O error during failover.
>>
>> Hmm, this is interesting. Not sure how this specific commit would
>> introduce such an issue.
>>
> See? Me neither. Sadly they _have_ bisected it, and this really is the
> patch introducing the regression.
> Current thinking is that we're dropping all paths during reset, causing
> ns_head to be deleted, too.

That is impossible, the only thing that would drop paths is either
if the user is removing a controller, or the ctrl_loss_tmo expired, both
are controller removal and not controller reset.

> The ns_head will get recreated immediately
> afterwards, so userspace wouldn't even notice that.
> But if we have a non-empty requeue list that will be flushed only when
> doing the final put on the ns_head structure, causing all I/O to fail.

Again, we need to understand what is the exact scenario, because if we
are losing all the paths, I/O failure is the expected behavior.

> So looking at it that way, it _might_ actually be that your patch helps
> for that situation, too, seeing that we can't reliably enumerate
> namespaces during reset.

Can we define clearly what do you mean when you say "enumerate 
namespaces during reset"?

> I'll give it a try and will get back to you with the results.

Thanks Hannes.
