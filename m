From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 18 Mar 2019 23:16:19 +0800
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <1552921495.152266.8.camel@acm.org>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p>
 <1552921495.152266.8.camel@acm.org>
Message-ID: <20190318151618.GA20371@ming.t460p>

On Mon, Mar 18, 2019@08:04:55AM -0700, Bart Van Assche wrote:
> On Mon, 2019-03-18@15:38 +0800, Ming Lei wrote:
> > On Sun, Mar 17, 2019@09:09:09PM -0700, Bart Van Assche wrote:
> > > On 3/17/19 8:29 PM, Ming Lei wrote:
> > > > In NVMe's error handler, follows the typical steps for tearing down
> > > > hardware:
> > > > 
> > > > 1) stop blk_mq hw queues
> > > > 2) stop the real hw queues
> > > > 3) cancel in-flight requests via
> > > > 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> > > > cancel_request():
> > > > 	mark the request as abort
> > > > 	blk_mq_complete_request(req);
> > > > 4) destroy real hw queues
> > > > 
> > > > However, there may be race between #3 and #4, because blk_mq_complete_request()
> > > > actually completes the request asynchronously.
> > > > 
> > > > This patch introduces blk_mq_complete_request_sync() for fixing the
> > > > above race.
> > > 
> > > Other block drivers wait until outstanding requests have completed by
> > > calling blk_cleanup_queue() before hardware queues are destroyed. Why can't
> > > the NVMe driver follow that approach?
> > 
> > The tearing down of controller can be done in error handler, in which
> > the request queues may not be cleaned up, almost all kinds of NVMe
> > controller's error handling follows the above steps, such as:
> > 
> > nvme_rdma_error_recovery_work()
> > 	->nvme_rdma_teardown_io_queues()
> > 
> > nvme_timeout()
> > 	->nvme_dev_disable
> 
> Hi Ming,
> 
> This makes me wonder whether the current design of the NVMe core is the best
> design we can come up with? The structure of e.g. the SRP initiator and target
> drivers is similar to the NVMeOF drivers. However, there is no need in the SRP
> initiator driver to terminate requests synchronously. Is this due to

I am not familiar with SRP, could you explain what SRP initiator driver
will do when the controller is in bad state? Especially about dealing with
in-flight IO requests under this situation.

> differences in the error handling approaches in the SCSI and NVMe core drivers?

As far as I can tell, I don't see obvious design issue in NVMe host drivers,
which tries best to recover controller and retries to complete all in-flight IO.

Thanks,
Ming
