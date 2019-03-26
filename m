From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 26 Mar 2019 11:19:25 +0800
Subject: [PATCH 1/4] nvmet: set loop queue's segment boundary mask as
 PAGE_SIZE - 1
In-Reply-To: <20190326031928.9499-1-ming.lei@redhat.com>
References: <20190326031928.9499-1-ming.lei@redhat.com>
Message-ID: <20190326031928.9499-2-ming.lei@redhat.com>

NVMe target only accepts single-page sg list, either file or block
device backed target code follows this assumption.

However, loop target is one exception, given the sg list is from
the host queue directly.

This patch sets loop queue's segment boundary mask as PAGE_SIZE - 1
for folowoing NVMe target assumption.

Reported-by: Yi Zhang <yi.zhang at redhat.com>
Fixes: 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
Cc: Yi Zhang <yi.zhang at redhat.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Cc: <stable at vger.kernel.org>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/target/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b9f623ab01f3..7194f86b9dac 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -549,6 +549,9 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	if (ret)
 		goto out_cleanup_connect_q;
 
+	/* target only accepts single-page sg list */
+	blk_queue_segment_boundary(ctrl->ctrl.connect_q, PAGE_SIZE - 1);
+
 	return 0;
 
 out_cleanup_connect_q:
-- 
2.9.5
