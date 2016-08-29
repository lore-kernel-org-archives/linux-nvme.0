From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Aug 2016 17:32:47 +0300
Subject: [PATCH WIP/RFC 6/6] nvme-rdma: keep a cm_id around during
 reconnect to get events
In-Reply-To: <20160829073037.GB9727@lst.de>
References: <cover.1472219585.git.swise@opengridcomputing.com>
 <b1ee02376df44ec240dc0bff956fe055687580f8.1472219586.git.swise@opengridcomputing.com>
 <8d13e79d-a111-8ec1-f8a6-42ece0ba46c9@grimberg.me>
 <20160829073037.GB9727@lst.de>
Message-ID: <13f597d1-0dd3-9c9e-9658-209f6817600a@grimberg.me>


>> Care to respin your client registration patch so we can judge which
>> is better?
>
> FYI, I also really hate the idea of having to potentially allocate
> resources on each device at driver load time which the client registration
> forces us into.

The client registration doesn't force us to allocate anything.
It's simply for us trigger cleanups when the device is unplugged...

static void nvme_rdma_add_one(struct ib_device *device)
{
	/* Do nothing */
}

static void nvme_rdma_remove_one(struct ib_device *device,
		void *cdata)
{
	/*
	 * for each ctrl where (ctrl->dev->device == device)
	 * 	queue delete controller
	 *
	 * flush the workqueue
	 */
}

static struct ib_client nvme_rdma_client = {
         .name   = "nvme_rdma",
         .add    = nvme_rdma_add_one,
         .remove = nvme_rdma_remove_one
};


> I really think we need to take a step back and offer interfaces that don't
> suck in the core instead of trying to work around RDMA/CM in the core.
> Unfortunately I don't really know what it takes for that yet.  I'm pretty
> busy this work, but I'd be happy to reserve a lot of time next week to
> dig into it unless someone beats me.

I agree we have *plenty* of room to improve in the RDMA_CM interface.
But this particular problem is the fact that we might get a device
removal right in the moment where we have no cm_id's open because we
are in the middle of periodic reconnects. This is why we can't even see
the event.

What sort of interface that would help here did you have in mind?

> I suspect a big part of that is having a queue state machine in the core,

We have a queue-pair state machine in the core, but currently it's not
very useful for the consumers, and the silly thing is that it's not
represented in the ib_qp struct and needs a ib_query_qp to figure it
out (one of the reasons is that the QP states and their transitions
are detailed in the different specs and not all of them are
synchronous).

> and getting rid of that horrible RDMA/CM event multiplexer.

That would be very nice improvement...
