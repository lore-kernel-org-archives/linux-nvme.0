From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 15:05:18 +0100
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
In-Reply-To: <5f34c9df-b0be-102a-eabe-7b4613b0c9c0@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181212070756.GC28461@lst.de>
 <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
 <20181212080945.GA29679@lst.de>
 <5f34c9df-b0be-102a-eabe-7b4613b0c9c0@grimberg.me>
Message-ID: <20181212140518.GA4527@lst.de>

On Wed, Dec 12, 2018@12:53:47AM -0800, Sagi Grimberg wrote:
>> Well, it should just be a little blk_poll loop, right?
>
> Not so much about the poll loop, but the fact that we will need
> to check if we need to poll for this special case every time in
> .queue_rq and its somewhat annoying...

I don't think we need to add any special check in queue_rq.  Any
polled command should be marked as HIPRI from the submitting code,
and that includes the queue creation.

> Anyway, if people think its really a bad idea we'll go ahead and
> poll the nvmf connect...

I'm really just worried about the completion context switching.  If the
RDMA folks are happy with that API and you strongly favour this version
I'll let you decide.
