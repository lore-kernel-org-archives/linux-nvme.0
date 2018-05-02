From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 2 May 2018 15:27:10 +0800
Subject: [PATCH V2 5/5] nvme: pci: simplify timeout handling
In-Reply-To: <eee63159-aae9-1936-008d-024dce13a69b@oracle.com>
References: <20180429154152.16656-1-ming.lei@redhat.com>
 <20180429154152.16656-6-ming.lei@redhat.com>
 <655b9d93-b4fc-b78b-1ea1-1c34d5c0535e@oracle.com>
 <20180502045423.GE22363@ming.t460p>
 <eee63159-aae9-1936-008d-024dce13a69b@oracle.com>
Message-ID: <20180502072709.GF22363@ming.t460p>

On Wed, May 02, 2018@01:12:57PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 05/02/2018 12:54 PM, Ming Lei wrote:
> >> We need to return BLK_EH_RESET_TIMER in nvme_timeout then:
> >> 1. defer the completion. we can't unmap the io request before close the controller totally, so not BLK_EH_HANDLED.
> >> 2. nvme_cancel_request could complete it. blk_mq_complete_request is invoked by nvme_cancel_request, so not BLK_EH_NOT_HANDLED.
> > We don't need to change return value of .timeout() any more after
> > calling nvme_quiesce_timeout():
> > 
> > Thanks the single EH kthread, once nvme_quiesce_timeout() returns, all
> > timed-out requests have been handled already. Some of them may be completed,
> > and others may be handled as RESET_TIMER, but none of them are handled as
> > NOT_HANDLED because nvme_timeout() won't return that value.
> > 
> > So the following blk_mq_tagset_busy_iter(nvme_cancel_request) can handle
> > all in-flight requests because timeout is drained and quiesced.
> 
> The key point here is we cannot unmap the io requests before we close the controller directly.
> The nvme controller may still hold the command after we complete and unmap the io request in nvme_timeout.
> This will cause memory corruption.
> 
> So we cannot just schedule the eh recovery kthread then return BLK_EH_HANDLED.
> We need to deffer the completion of timeout requests until the controller has been closed totally in nvme_dev_disable.
> 

Good catch!

I am gonna document this point since it is easy to be ignored.

Yeah, looks it is simpler to return BLK_EH_RESET_TIMER for NVMe to
handle this issue, but not too readable, it is something like:
we has stopped the timeout, but BLK_EH_RESET_TIMER still has to be
returned for asking block layer to not complete this req.

So IMO it may be better to return BLK_EH_NOT_HANDLED, but it becomes
a bit tricky to handle this request in EH thread, maybe a NVMe req
flag is needed for completing the req in nvme_cancel_request().

Thanks
Ming
