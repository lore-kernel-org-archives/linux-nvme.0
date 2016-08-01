From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 13:03:08 +0200
Subject: [PATCH 2/5] nvme-rdma: Free the I/O tags when we delete the
 controller
In-Reply-To: <1469822242-3477-3-git-send-email-sagi@grimberg.me>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
 <1469822242-3477-3-git-send-email-sagi@grimberg.me>
Message-ID: <20160801110308.GC16141@lst.de>

On Fri, Jul 29, 2016@10:57:19PM +0300, Sagi Grimberg wrote:
> If we wait until we free the controller (free_ctrl) we might
> lose our rdma device without any notification while we still
> have open resources (tags mrs and dma mappings).
> 
> Instead, destroy the tags with their rdma resources once we
> delete the device and not when freeing it.
> 
> Note that we don't do that in nvme_rdma_shutdown_ctrl because
> controller reset uses it as well and we want to give active I/O
> a chance to complete successfully.
> 
> Reported-by: Steve Wise <swise at opengridcomputing.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This looks fine to me, but can we place share the code instead of
duplicating it?  E.g.

static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
{
 	nvme_remove_namespaces(&ctrl->ctrl);
	if (shutdown)
	  	nvme_rdma_shutdown_ctrl(ctrl);
  	nvme_uninit_ctrl(&ctrl->ctrl);
	if (ctrl->ctrl.tagset) {
		blk_cleanup_queue(ctrl->ctrl.connect_q);
		blk_mq_free_tag_set(&ctrl->tag_set);
		nvme_rdma_dev_put(ctrl->device);
	}
	nvme_put_ctrl(&ctrl->ctrl);
}

or in a second step we should probably always call shutdown_ctrl
but skip the actual shutdown if the ctrl state doesn't require it.
