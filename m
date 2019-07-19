From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 19 Jul 2019 11:00:29 +1000
Subject: Duplicate tag error with 5.2
In-Reply-To: <BYAPR04MB58163BC85D7A5351BC053D43E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <0007d555cf4586c4ae43fdca66766b6b11863078.camel@kernel.crashing.org>
 <dbb6572c3d0b8ad1f20fd5f89ee112995676375b.camel@kernel.crashing.org>
 <6e4b08daaa0482bd863b63cc5a85fa58ed871045.camel@kernel.crashing.org>
 <CAOSXXT6Z=zEpWqac2k1ydk2LynAEtFr-4jXJVCtTa5yn8H7f3Q@mail.gmail.com>
 <ee8eb3c8855942eb22391dd6137f3b969abce303.camel@kernel.crashing.org>
 <f5de042adc383df7cb040859f13ce92412977467.camel@kernel.crashing.org>
 <8936e370b7ae272c8810780ee26ae3cebc8525b9.camel@kernel.crashing.org>
 <BYAPR04MB58169C5A4EF8DFB10C5C2148E7C80@BYAPR04MB5816.namprd04.prod.outlook.com>
 <c7235187d44618bc6636da0968c8037aebf50742.camel@kernel.crashing.org>
 <BYAPR04MB581667EE6FB45D86881529E2E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <50c35ab3db7745875476c0966bf191ab42de4dd1.camel@kernel.crashing.org>
 <BYAPR04MB58163BC85D7A5351BC053D43E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
Message-ID: <5f29b93ba4bf2f7bd8b0a77bc5f82f4cbb9e8f98.camel@kernel.crashing.org>

On Fri, 2019-07-19@00:53 +0000, Damien Le Moal wrote:
> 
> If the admin req completion comes in the wrong queue, then the admin queue
> completion queue should not be changing and not need any head/doorbell tweaks.
> It simply stays as is. Since I think that nvme_handle_cqe is used for all
> commands regardless of submission type (normal, polled, sync, etc), this should
> work in all cases. Not sure at all for all this. Some side effects are
> definitely possible. But worth a try I think.

I've printed the queue I get completions from and they arrive in the
right queues. So that doesn't seem to be the issue.

Apple's implementation is a SW one running on the T2 chip, I suspect
it's just completely broken and they don't care because they have their
own driver.

I'll clean up my latest fix, test more and send it. It applies on top
of the 3 patches I sent earlier.

Cheers,
Ben.
