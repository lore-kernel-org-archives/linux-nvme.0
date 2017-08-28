From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 28 Aug 2017 14:01:16 +0300
Subject: [PATCH 08/10] block: provide a generic_make_request_fast helper
In-Reply-To: <20170828085447.GB4358@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-9-hch@lst.de>
 <326ee3b3-441f-e093-6d6f-7356e1ff8487@grimberg.me>
 <20170828085447.GB4358@lst.de>
Message-ID: <7ff339f0-e9bc-514f-18a0-596d8e409436@grimberg.me>


>>> This helper allows reinserting a bio into a new queue without much
>>> overhead, but requires all queue limits to be the same for the upper
>>> and lower queues, and it does not provide any recursion preventions,
>>> which requires the caller to not split the bio.
>>
>> Isn't the same limits constraint too restrictive?
>>
>> Say I have two paths to the same namespace via two different HBAs, each
>> with its own virt_boundary capability for example? That would require us
>> to split failover bio wouldn't it?
> 
> Uh oh - different transports for the same subsystem will be intereting.
> For one it's not specified anywhere so I'd like to kick off a discussion
> on the working group mailing list about it.

Indeed that would be interesting, but I wasn't referring to different
transports, even the same transport can have different capabilities
(for example CX4 and CX4 devices on the same host).

> That being said ->make_request basically doesn't care about actual
> limits at all, it mostly care about support features (e.g. discard, fua,
> etc).  So I think a lot of these limits could porbably be lifted,
> but I'd need to add the check to generic_make_request_checks back.

Different virt_boundary capabilities will trigger bio splits which
can make make_request blocking (due to lack of tags).
