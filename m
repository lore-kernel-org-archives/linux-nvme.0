From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 24 Mar 2018 13:32:00 -0700
Subject: [PATCH 1/2] nvme-core: use macro for identify size
Message-ID: <20180324203201.27087-1-chaitanya.kulkarni@wdc.com>

Use identifier macro for identify data structure size.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7aeca5d..3ef1129 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -948,7 +948,8 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST;
 	c.identify.nsid = cpu_to_le32(nsid);
-	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
+	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list,
+			NVME_IDENTIFY_DATA_SIZE);
 }
 
 static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
-- 
2.9.5
