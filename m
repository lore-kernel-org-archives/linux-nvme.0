From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 13 Jan 2017 22:26:33 +0200
Subject: [PATCH 2/6] irq/affinity: Assign offline CPUs a vector
In-Reply-To: <20170108100152.GA26025@lst.de>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-3-git-send-email-keith.busch@intel.com>
 <20170108100152.GA26025@lst.de>
Message-ID: <76b3779d-18e3-51c4-84c9-efdbc68f6d84@grimberg.me>

>> The offline CPUs need to assigned to something incase they come online
>> later, otherwise anyone using the mapping for things other than affinity
>> will have blank entries for that online CPU.
>
> I don't really like the idea behind it.  Back when we came up with
> this code I had some discussion with Thomas if we should do the
> assignment only for online CPUs, or maybe for all possible CPUs.
>
> Except for some big iron with physical node hotplug the difference
> usually is just that some nodes have been temporarily offlined.  So
> maybe we need to bite the bullet and move the irq and block code
> to consider all possible cpus.

I tend to agree.

Would be great if we could have a cpuhp_register() for external users
that would get ops + state mask structure to act on (this case would
need CPUHP_OFFLINE, CPUHP_ONLINE). We do have something similar
for mmu (mmu_notifier).
