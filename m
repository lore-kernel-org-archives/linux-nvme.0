From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 1 Aug 2016 14:15:59 +0300
Subject: [PATCH 2/5] nvme-rdma: Free the I/O tags when we delete the
 controller
In-Reply-To: <20160801110308.GC16141@lst.de>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
 <1469822242-3477-3-git-send-email-sagi@grimberg.me>
 <20160801110308.GC16141@lst.de>
Message-ID: <c2c194b0-d0a1-11af-cae9-a4ce8ea8fdde@grimberg.me>


>> If we wait until we free the controller (free_ctrl) we might
>> lose our rdma device without any notification while we still
>> have open resources (tags mrs and dma mappings).
>>
>> Instead, destroy the tags with their rdma resources once we
>> delete the device and not when freeing it.
>>
>> Note that we don't do that in nvme_rdma_shutdown_ctrl because
>> controller reset uses it as well and we want to give active I/O
>> a chance to complete successfully.
>>
>> Reported-by: Steve Wise <swise at opengridcomputing.com>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>
> This looks fine to me, but can we place share the code instead of
> duplicating it?  E.g.
>
> static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
> {
>  	nvme_remove_namespaces(&ctrl->ctrl);
> 	if (shutdown)
> 	  	nvme_rdma_shutdown_ctrl(ctrl);
>   	nvme_uninit_ctrl(&ctrl->ctrl);
> 	if (ctrl->ctrl.tagset) {
> 		blk_cleanup_queue(ctrl->ctrl.connect_q);
> 		blk_mq_free_tag_set(&ctrl->tag_set);
> 		nvme_rdma_dev_put(ctrl->device);
> 	}
> 	nvme_put_ctrl(&ctrl->ctrl);
> }

That sounds fine to me.

> or in a second step we should probably always call shutdown_ctrl
> but skip the actual shutdown if the ctrl state doesn't require it.

What do you mean "if the ctrl state doesn't require it"?
Up until today we managed to avoid checking the ctrl state
in queue_rq and I'd like to keep it that way. I'd be much
happier if we don't depend on queue_rq to fail early under
some assumptions, it might be a slippery slope...
