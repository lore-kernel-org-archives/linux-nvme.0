From: mlin@kernel.org (Ming Lin)
Date: Tue, 12 Jul 2016 23:54:01 -0700
Subject: [PATCH] nvme-fabrics: get ctrl reference in nvmf_dev_write
In-Reply-To: <20160713021831.GA7782@lst.de>
References: <1468363122-11073-1-git-send-email-mlin@kernel.org>
 <20160713021831.GA7782@lst.de>
Message-ID: <1468392841.23662.5.camel@kernel.org>

On Wed, 2016-07-13@04:18 +0200, Christoph Hellwig wrote:
> On Tue, Jul 12, 2016@03:38:42PM -0700, Ming Lin wrote:
> > From: Ming Lin <ming.l at samsung.com>
> > 
> > Below crash was triggered when shutting down a nvme host node
> > via 'reboot' that has 1 target device attached.
> > 
> > That's because nvmf_dev_release() put the ctrl reference, but
> > we didn't get the reference in nvmf_dev_write().
> > 
> > So the ctrl was freed in nvme_rdma_free_ctrl() before
> > nvme_rdma_free_ring()
> > was called.
> 
> The ->create_ctrl methods do a kref_init for the main refererence,
> and a kref_get for the reference that nvmf_dev_release drops,
> so I'm a bit confused how this case could happen.??I think we'll need
> to
> dig a bit deeper on what's actually happening here.

You are right.

I added some debug info.

[31948.771952] MYDEBUG: init kref: nvme_init_ctrl
[31948.798589] MYDEBUG: get: nvme_rdma_create_ctrl
[31948.803765] MYDEBUG: put: nvmf_dev_release
[31948.808734] MYDEBUG: get: nvme_alloc_ns
[31948.884775] MYDEBUG: put: nvme_free_ns
[31948.890155] MYDEBUG in nvme_rdma_destroy_queue_ib: queue ffff8800cdc81470: io queue
[31948.900539] MYDEBUG: put: nvme_rdma_del_ctrl_work
[31948.909469] MYDEBUG: nvme_rdma_free_ctrl called
[31948.915379] MYDEBUG in nvme_rdma_destroy_queue_ib: queue ffff8800cdc81400: admin queue

So nvme_rdma_destroy_queue_ib() was called for admin queue after ctrl was already freed.

With below patch, the debug info shows:

[32139.379831] MYDEBUG: get/init: nvme_init_ctrl
[32139.407166] MYDEBUG: get: nvme_rdma_create_ctrl
[32139.412463] MYDEBUG: put: nvmf_dev_release
[32139.417697] MYDEBUG: get: nvme_alloc_ns
[32139.418422] MYDEBUG: get: nvme_rdma_device_unplug
[32139.474154] MYDEBUG: put: nvme_free_ns
[32139.479406] MYDEBUG in nvme_rdma_destroy_queue_ib: queue ffff8800347c6470: io queue
[32139.489532] MYDEBUG: put: nvme_rdma_del_ctrl_work
[32139.496048] MYDEBUG in nvme_rdma_destroy_queue_ib: queue ffff8800347c6400: admin queue
[32139.739089] MYDEBUG: put: nvme_rdma_device_unplug
[32139.748175] MYDEBUG: nvme_rdma_free_ctrl called

and the crash was fixed.

What do you think?

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e1205c0..284d980 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1323,6 +1323,12 @@ static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
?	if (!test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags))
?		goto out;
?
+	/*
+	?* Grab a reference so the ctrl won't be freed before we free
+	?* the last queue
+	?*/
+	kref_get(&ctrl->ctrl.kref);
+
?	/* delete the controller */
?	ret = __nvme_rdma_del_ctrl(ctrl);
?	if (!ret) {
@@ -1339,6 +1345,8 @@ static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
?		nvme_rdma_destroy_queue_ib(queue);
?	}
?
+	nvme_put_ctrl(&ctrl->ctrl);
+
?out:
?	return ctrl_deleted;
?}
