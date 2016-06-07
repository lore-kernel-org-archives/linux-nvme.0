From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Tue,  7 Jun 2016 06:36:55 +0000
Subject: [RFC 7/8] nvmet/admin-cmd: Hookup T10-PI to ID_NS.ms + ID_NS.dps
 feature bits
In-Reply-To: <1465281416-28355-1-git-send-email-nab@linux-iscsi.org>
References: <1465281416-28355-1-git-send-email-nab@linux-iscsi.org>
Message-ID: <1465281416-28355-8-git-send-email-nab@linux-iscsi.org>

From: Nicholas Bellinger <nab@linux-iscsi.org>

This patch updates nvmet_execute_identify_ns() to report
target-core backend T10-PI related feature bits to the
NVMe host controller.

Note this assumes support for NVME_NS_DPC_PI_TYPE1 and
NVME_NS_DPC_PI_TYPE3 as reported by backend drivers via
/sys/kernel/config/target/core/*/*/attrib/pi_prot_type.

Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Martin Petersen <martin.petersen at oracle.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Hannes Reinecke <hare at suse.de>
Cc: Mike Christie <michaelc at cs.wisc.edu>
Signed-off-by: Nicholas Bellinger <nab at linux-iscsi.org>
---
 drivers/nvme/target/admin-cmd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 240e323..3a808dc 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -200,6 +200,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
+	struct se_device *dev;
 	u16 status = 0;
 
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
@@ -228,6 +229,22 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	id->nlbaf = 0;
 	id->flbas = 0;
 
+	/* Populate bits for T10-PI from se_device backend */
+	rcu_read_lock();
+	dev = rcu_dereference(ns->dev);
+	if (dev && dev->dev_attrib.pi_prot_type) {
+		int pi_prot_type = dev->dev_attrib.pi_prot_type;
+
+		id->lbaf[0].ms = cpu_to_le16(sizeof(struct t10_pi_tuple));
+		printk("nvmet_set_id_ns: ms: %u\n", id->lbaf[0].ms);
+
+		if (pi_prot_type == 1)
+			id->dps = NVME_NS_DPC_PI_TYPE1;
+		else if (pi_prot_type == 3)
+			id->dps = NVME_NS_DPC_PI_TYPE3;
+	}
+	rcu_read_unlock();
+
 	/*
 	 * Our namespace might always be shared.  Not just with other
 	 * controllers, but also with any other user of the block device.
-- 
1.9.1
