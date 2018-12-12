From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 00:53:47 -0800
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
In-Reply-To: <20181212080945.GA29679@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181212070756.GC28461@lst.de>
 <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
 <20181212080945.GA29679@lst.de>
Message-ID: <5f34c9df-b0be-102a-eabe-7b4613b0c9c0@grimberg.me>


>> I found it cumbersome so I didn't really consider it...
>> Isn't it a bit awkward? we will need to implement polled connect
>> locally in nvme-rdma (because fabrics doesn't know anything about
>> queues, hctx or polling).
> 
> Well, it should just be a little blk_poll loop, right?

Not so much about the poll loop, but the fact that we will need
to check if we need to poll for this special case every time in
.queue_rq and its somewhat annoying...

>> I'm open to looking at it if you think that this is better. Note that if
>> we had the CQ in our hands, we would do exactly what we did here
>> effectively: use interrupt for the connect and then simply not
>> re-arm it again and poll... Should we poll the connect just because
>> we are behind the CQ API?
> 
> I'm just worried that the switch between the different context looks
> like a way to easy way to shoot yourself in the foot, so if we can
> avoid exposing that it would make for a harder to abuse API.

Well, it would have been 100% safe if we could undo a cq re-arm that we
did in the past...

The code is documented that the caller must make sure that there is no
inflight I/O during the invocation of the routine..

We could be creative if we really want to make it 100% safe for inflight
I/O (although no one should ever need to use that). We can flush the
current cq context (work/irq), switch to polling context, then create a
single entry QP attached to this CQ and drain it :)
That would make it safe but its brain-dead...

Anyway, if people think its really a bad idea we'll go ahead and
poll the nvmf connect...
