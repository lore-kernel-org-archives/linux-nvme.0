From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 18:22:02 +0300
Subject: [PATCH rfc 28/30] nvme: update tagset nr_hw_queues when reallocating
 io queues
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497799324-19598-29-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6937ba26ff2c..476c49c0601f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2776,6 +2776,9 @@ int nvme_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		ret = blk_mq_reinit_tagset(ctrl->tagset);
 		if (ret)
 			goto out_free_io_queues;
+
+		blk_mq_update_nr_hw_queues(ctrl->tagset,
+				ctrl->queue_count - 1);
        }
 
 	ret = nvme_start_io_queues(ctrl);
-- 
2.7.4
