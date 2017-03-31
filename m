From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 31 Mar 2017 17:38:46 -0400
Subject: [RFC 1/8] Introduce Peer-to-Peer memory (p2pmem) device
In-Reply-To: <7158f2e8-2016-f398-e77f-0fcbe6cb41dd@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-2-git-send-email-logang@deltatee.com>
 <cb102386-0314-a3a3-ed44-b42debdf1512@codeaurora.org>
 <7158f2e8-2016-f398-e77f-0fcbe6cb41dd@deltatee.com>
Message-ID: <e6a74aeb-9f54-51c5-8ad9-3b6fb92c03b3@codeaurora.org>

On 3/31/2017 5:23 PM, Logan Gunthorpe wrote:
> What exactly would you white/black list? It can't be the NIC or the
> disk. If it's going to be a white/black list on the switch or root port
> then you'd need essentially the same code to ensure they are all behind
> the same switch or root port.

What is so special about being connected to the same switch?

Why don't we allow the feature by default and blacklist by the root ports
that don't work with a quirk.

I'm looking at this from portability perspective to be honest.

I'd rather see the feature enabled by default without any assumptions.
Using it with a switch is just a use case that you happened to test.
It can allow new architectures to use your code tomorrow.

Sinan
-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
