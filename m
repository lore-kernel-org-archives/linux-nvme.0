From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu,  8 Feb 2018 22:56:31 +0900
Subject: [PATCH] nvme: use define instead of magic value for identify size
Message-ID: <1518098191-27923-1-git-send-email-minwoo.im.dev@gmail.com>

NVME_IDENTIFY_DATA_SIZE was added to linux/nvme.h by following commit.
  commit 0add5e8e588c ("nvmet: use NVME_IDENTIFY_DATA_SIZE")

Make it use NVME_IDENTIFY_DATA_SIZE define instead of magic value
0x1000 in case of identify data size.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b3af8e9..01aa45f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -944,7 +944,8 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST;
 	c.identify.nsid = cpu_to_le32(nsid);
-	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
+	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list,
+				    NVME_IDENTIFY_DATA_SIZE);
 }
 
 static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
@@ -3100,7 +3101,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
 	int ret = 0;
 
-	ns_list = kzalloc(0x1000, GFP_KERNEL);
+	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
 
-- 
2.7.4
