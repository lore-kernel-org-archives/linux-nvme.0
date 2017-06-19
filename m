From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 14:30:25 +0200
Subject: [PATCH rfc 01/30] nvme: Add admin connect request queue
In-Reply-To: <5497966b-5f2e-ae17-c72c-50b2317ab798@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-2-git-send-email-sagi@grimberg.me>
 <20170619071314.GA13168@lst.de>
 <5497966b-5f2e-ae17-c72c-50b2317ab798@grimberg.me>
Message-ID: <20170619123025.GB29061@lst.de>

On Mon, Jun 19, 2017@10:49:15AM +0300, Sagi Grimberg wrote:
> However, you raise a valid point, I think I added this before we
> had the queue_is_ready protection, which will reject the command
> if the queue is not LIVE (unless its a connect). I think the reason
> its still in is that I tested this with loop which doesn't have
> a per-queue state machine.

Yeah.

> I'm still wandering if its a good idea to rely on the transport
> queue state to reject non-connect requests on non-LIVE queues.
> if/when we introduce a queue representation to the core and we
> drive the state machine there, then we could actually rely on it
> (I do have some code for it, but its a pretty massive change which
> cannot be added in an incremental fashion).

I suspect moving the state machine to the core is a good idea.  Note that
the current nvme_rdma_queue_is_ready hack actually seems a bit to simple -
even after the connect we should only allow get/set Property.  Nevermind
the additional complications if/when authentication is implemented.
