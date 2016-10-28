From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 28 Oct 2016 01:27:31 -0700
Subject: [PATCH v3 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <977d4f55-2332-a368-7f1e-3a229f58e98a@broadcom.com>
References: <580d0ffd.cq5y7S+lNBHxNs60%james.smart@broadcom.com>
 <20161025164706.GE2446@infradead.org>
 <977d4f55-2332-a368-7f1e-3a229f58e98a@broadcom.com>
Message-ID: <20161028082731.GA22832@infradead.org>

On Thu, Oct 27, 2016@03:28:14PM -0700, James Smart wrote:
> Well, I used blk_mq_tagset_busy_iter a bit differently than I saw it used on
> rdma.

Note that this code didn't come from rdma, but PCIe originally.  And
I had actually planned to move this into common code, but got
sidetracked.

> With RDMA, I saw it using the routine to call the core nvme_cancel_request,
> which indeed passed the request back up to the blk layer.  It then scheduled
> the reconnect_ctrl_work routine, which would terminate the queues, tearing
> down the qp's. I assume the teardown of the qp's also terminated all the
> memory regions that may have been mapped for ios sent over the qps.

So on RDMA the QP itself doesn't reference physical memory - the send
and recv WRs do.  But a QP termination "flushes" all them, that is
completes them with an error.

> I also
> assume the tgt side, upon the qp termination, also tears down and resolves
> any io state relative to the qp, io-related mrs for the qp, etc.   Note: I'm
> actually surprised. I would have assumed it's not good practice to return
> things to the blk layer while there may be things coming off the wire that
> hit memory registrations and perhaps muck with memory. I assume either
> teardown is too quick or they aren't destructive accesses (memory related to
> the request's sgl stays around long enough that the cancelations finish
> before the request releases it, etc).

The queues are dead on the wire before we call nvme_cancel_request
for both RDMA and PCI - the call to blk_mq_tagset_busy_iter is
for requests we did not get a reply to before tearing down the queues,
or those stuck being requeued in the block layer.

> In FC, the queue is a logical thing, unlike rdma where it maps to the qp. At
> transport connect, the target gives the initiator a handle for the queue
> that the initiator is to pair on any io it sends to the target.   When an
> SQE is sent on a SQ, FC effectively considers the SQE, or perhaps better
> said, the command within the SQE, an "io", and assigns a FC exchange to it.
> The SQE, and the queue handle, get sent in the initial CMD IU on the
> exchange. Everything relative to the io happens under the exchange context.
> The CQE is the last thing for the io, and the transport closes the exchange
> upon the commands-CQE being delivered.
> 
> So - if I'm tearing down queues/resetting controllers, not only do I send a
> DISCONNECT LS to kill the validity of the handle, but I also need to do
> something to cancel all those FC exchange contexts that corresponded to ios
> that were outstanding on the queue.

Ok, this makes more sense now.  Can you refactor and comment the code
a bit to make this more obvious?

> As for aborts relative to individual io timeouts, the "normal thing" we did
> with scsi and other drive protocols, it really doesn't fit and the nvme
> escalation policy of failing the queue or resetting the controller should
> kick in (like on rdma). The FC transport could kill the one I/O, but as the
> SQE and CQEs are part of the io - there's queue-related things it messes
> with when it does so that aren't good. Granted linux ignores some of those
> making it tempting, but I don't want to go there.  If anything were to be
> done - it should be something generic: have a core layer time out function
> that then generates an ABORT admin command to kill it. And if that fails or
> timesout, then it resorts to a transport controller reset routine.

The PCIe code does send aborts, but the problem with the NVMe abort
command is that it's almost entirely useless - controllers can ignore it
for any reason whatsover, and the spec only requires controllers to
support 4 outstanding abort commands at a given time.

For now I haven't bothered to implement abort on RDMA for that reason,
but I reall want a common error handler rather sooner than later
instead of duplicating it in every driver.  Given that Keith really
likes the aborts because he looks at them in the bus analyzer traces
we'll probably send them for RDMA as well in the future.

that beeing said the way I read nvme_fc_timeout in your patch is that it
does the FCP abort for just that one command, but never escalates to a
controller reset.  It also completely ignores the reserved commands
(which would be keep alive).  So looking over this in a little more
detail I think FC error handling needs at least a bit more work to
force a controller reset.
