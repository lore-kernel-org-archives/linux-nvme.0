From: mlin@kernel.org (Ming Lin)
Date: Tue, 12 Jul 2016 15:38:42 -0700
Subject: [PATCH] nvme-fabrics: get ctrl reference in nvmf_dev_write
Message-ID: <1468363122-11073-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Below crash was triggered when shutting down a nvme host node
via 'reboot' that has 1 target device attached.

That's because nvmf_dev_release() put the ctrl reference, but
we didn't get the reference in nvmf_dev_write().

So the ctrl was freed in nvme_rdma_free_ctrl() before nvme_rdma_free_ring()
was called.

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

Reported-by: Steve Wise <swise at opengridcomputing.com>
Signed-off-by: Ming Lin <ming.l at samsung.com>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1ad47c5..f13e3a6 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -845,6 +845,7 @@ static ssize_t nvmf_dev_write(struct file *file, const char __user *ubuf,
 		goto out_unlock;
 	}
 
+	kref_get(&ctrl->kref);
 	seq_file->private = ctrl;
 
 out_unlock:
-- 
1.9.1
