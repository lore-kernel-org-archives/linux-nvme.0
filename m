From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 09:09:45 +0100
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
In-Reply-To: <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181212070756.GC28461@lst.de>
 <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
Message-ID: <20181212080945.GA29679@lst.de>

On Tue, Dec 11, 2018@11:16:31PM -0800, Sagi Grimberg wrote:
>
>>> Add an additional queue mapping for polling queues that will
>>> host polling for latency critical I/O.
>>>
>>> One caveat is that we don't want these queues to be pure polling
>>> as we don't want to bother with polling for the initial nvmf connect
>>> I/O. Hence, introduce ib_change_cq_ctx that will modify the cq polling
>>> context from SOFTIRQ to DIRECT.
>>
>> So do we really care?  Yes, polling for the initial connect is not
>> exactly efficient, but then again it doesn't happen all that often.
>>
>> Except for efficiency is there any problem with just starting out
>> in polling mode?
>
> I found it cumbersome so I didn't really consider it...
> Isn't it a bit awkward? we will need to implement polled connect
> locally in nvme-rdma (because fabrics doesn't know anything about
> queues, hctx or polling).

Well, it should just be a little blk_poll loop, right?

> I'm open to looking at it if you think that this is better. Note that if
> we had the CQ in our hands, we would do exactly what we did here
> effectively: use interrupt for the connect and then simply not
> re-arm it again and poll... Should we poll the connect just because
> we are behind the CQ API?

I'm just worried that the switch between the different context looks
like a way to easy way to shoot yourself in the foot, so if we can
avoid exposing that it would make for a harder to abuse API.
