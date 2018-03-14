From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 14 Mar 2018 12:16:05 +0000
Subject: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <932bbf48-9d86-97ec-17bb-052099aff99e@deltatee.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <016dc910-f96a-8a60-4bda-fa24eea98ea5@codeaurora.org>
 <2b152932-2f44-408b-e3ed-b4608d95f82e@deltatee.com>
 <156c24fb-6e27-28f6-0b36-7fd83311ce37@codeaurora.org>
 <932bbf48-9d86-97ec-17bb-052099aff99e@deltatee.com>
Message-ID: <6e36d43b0493455a8547bc50c8ec77ba@AcuMS.aculab.com>

From: Logan Gunthorpe
> Sent: 13 March 2018 23:46
...
> As Stephen pointed out, it's a requirement of the PCIe spec that a
> switch supports P2P. If you want to sell a switch that does P2P with bad
> performance then that's on you to deal with.

That surprises me (unless I missed something last time I read the spec).
While P2P writes are relatively easy to handle, reads and any other TLP that
require acks are a completely different proposition.
There are no additional fields that can be set in the read TLP and will be
reflected back in the ack(s) than can be used to route the acks back to the
correct initiator.

I'm pretty sure that to support P2P reads a switch would have to save
the received read TLP and (possibly later on) issue read TLP of its own
for the required data.
I'm not even sure it is easy to interleave the P2P reads with those
coming from the root.
That requires a potentially infinite queue of pending requests.

Some x86 root ports support P2P writes (maybe with a bios option).
It would be a shame not to be able to do P2P writes on such systems
even though P2P reads won't work.

(We looked at using P2P transfers for some data, but in the end used
a different scheme.
For our use case P2P writes were enough.
An alternative would be to access the same host memory buffer from
two different devices - but there isn't an API that lets you do that.)

	David
