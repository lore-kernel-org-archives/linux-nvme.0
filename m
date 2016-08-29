From: hch@lst.de (Christoph Hellwig)
Date: Mon, 29 Aug 2016 09:30:37 +0200
Subject: [PATCH WIP/RFC 6/6] nvme-rdma: keep a cm_id around during
 reconnect to get events
In-Reply-To: <8d13e79d-a111-8ec1-f8a6-42ece0ba46c9@grimberg.me>
References: <cover.1472219585.git.swise@opengridcomputing.com>
 <b1ee02376df44ec240dc0bff956fe055687580f8.1472219586.git.swise@opengridcomputing.com>
 <8d13e79d-a111-8ec1-f8a6-42ece0ba46c9@grimberg.me>
Message-ID: <20160829073037.GB9727@lst.de>

On Sun, Aug 28, 2016@03:56:24PM +0300, Sagi Grimberg wrote:
> Care to respin your client registration patch so we can judge which
> is better?

FYI, I also really hate the idea of having to potentially allocate
resources on each device at driver load time which the client registration
forces us into.

I really think we need to take a step back and offer interfaces that don't
suck in the core instead of trying to work around RDMA/CM in the core.
Unfortunately I don't really know what it takes for that yet.  I'm pretty
busy this work, but I'd be happy to reserve a lot of time next week to
dig into it unless someone beats me.

I suspect a big part of that is having a queue state machine in the core,
and getting rid of that horrible RDMA/CM event multiplexer.
