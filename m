From: mlin@kernel.org (Ming Lin)
Date: Wed, 13 Jul 2016 14:26:35 -0700
Subject: [PATCH 1/2] nvme-rdma: grab reference for device removal event
In-Reply-To: <1468445196-6915-1-git-send-email-mlin@kernel.org>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
Message-ID: <1468445196-6915-2-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Below crash was triggered when shutting down a nvme host node
via 'reboot' that has 1 target device attached.

[   88.897220] BUG: unable to handle kernel paging request at ffffebe00400f820
[   88.905226] IP: [<ffffffff811e8d76>] kfree+0x56/0x170
[   89.182264] Call Trace:
[   89.185899]  [<ffffffffc09f7052>] nvme_rdma_free_ring.constprop.42+0x42/0xb0 [nvme_rdma]
[   89.195193]  [<ffffffffc09f77ba>] nvme_rdma_destroy_queue_ib+0x3a/0x60 [nvme_rdma]
[   89.203969]  [<ffffffffc09f92bc>] nvme_rdma_cm_handler+0x69c/0x8b6 [nvme_rdma]
[   89.212406]  [<ffffffff811e859b>] ? __slab_free+0x9b/0x2b0
[   89.219101]  [<ffffffffc0a2c694>] cma_remove_one+0x1f4/0x220 [rdma_cm]
[   89.226838]  [<ffffffffc09415b3>] ib_unregister_device+0xc3/0x160 [ib_core]
[   89.235008]  [<ffffffffc0a0798a>] mlx4_ib_remove+0x6a/0x220 [mlx4_ib]
[   89.242656]  [<ffffffffc097ede7>] mlx4_remove_device+0x97/0xb0 [mlx4_core]
[   89.250732]  [<ffffffffc097f48e>] mlx4_unregister_device+0x3e/0xa0 [mlx4_core]
[   89.259151]  [<ffffffffc0983a46>] mlx4_unload_one+0x86/0x2f0 [mlx4_core]
[   89.267049]  [<ffffffffc0983d97>] mlx4_shutdown+0x57/0x70 [mlx4_core]
[   89.274680]  [<ffffffff8141c4b6>] pci_device_shutdown+0x36/0x70
[   89.281792]  [<ffffffff81526c13>] device_shutdown+0xd3/0x180
[   89.288638]  [<ffffffff8109e556>] kernel_restart_prepare+0x36/0x40
[   89.296003]  [<ffffffff8109e602>] kernel_restart+0x12/0x60
[   89.302688]  [<ffffffff8109e983>] SYSC_reboot+0x1f3/0x220
[   89.309266]  [<ffffffff81186048>] ? __filemap_fdatawait_range+0xa8/0x150
[   89.317151]  [<ffffffff8123ec20>] ? fdatawait_one_bdev+0x20/0x20
[   89.324335]  [<ffffffff81188585>] ? __filemap_fdatawrite_range+0xb5/0xf0
[   89.332227]  [<ffffffff8122880a>] ? iput+0x8a/0x200
[   89.338294]  [<ffffffff8123ec00>] ? sync_inodes_one_sb+0x20/0x20
[   89.345465]  [<ffffffff812480d7>] ? iterate_bdevs+0x117/0x130
[   89.352367]  [<ffffffff8109ea0e>] SyS_reboot+0xe/0x10

Debug shows:

[31948.771952] MYDEBUG: init kref: nvme_init_ctrl
[31948.798589] MYDEBUG: get: nvme_rdma_create_ctrl
[31948.803765] MYDEBUG: put: nvmf_dev_release
[31948.808734] MYDEBUG: get: nvme_alloc_ns
[31948.884775] MYDEBUG: put: nvme_free_ns
[31948.890155] MYDEBUG in nvme_rdma_destroy_queue_ib: queue ffff8800cdc81470: io queue
[31948.900539] MYDEBUG: put: nvme_rdma_del_ctrl_work
[31948.909469] MYDEBUG: nvme_rdma_free_ctrl called
[31948.915379] MYDEBUG in nvme_rdma_destroy_queue_ib: queue ffff8800cdc81400: admin queue

So nvme_rdma_destroy_queue_ib() was called for admin queue
after ctrl was already freed.

Fixing it by get/put ctrl reference in nvme_rdma_device_unplug
so the ctrl won't be freed before we free the last queue.

Reported-by: Steve Wise <swise at opengridcomputing.com>
Signed-off-by: Ming Lin <ming.l at samsung.com>
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e3ce2b..f845304 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1331,6 +1331,12 @@ static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
 	if (!test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags))
 		goto out;
 
+	/*
+	 * Grab a reference so the ctrl won't be freed before we free
+	 * the last queue
+	 */
+	kref_get(&ctrl->ctrl.kref);
+
 	/* delete the controller */
 	ret = __nvme_rdma_del_ctrl(ctrl);
 	if (!ret) {
@@ -1347,6 +1353,8 @@ static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
 		nvme_rdma_destroy_queue_ib(queue);
 	}
 
+	nvme_put_ctrl(&ctrl->ctrl);
+
 out:
 	return ctrl_deleted;
 }
-- 
1.9.1
