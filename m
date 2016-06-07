From: mlin@kernel.org (Ming Lin)
Date: Tue, 07 Jun 2016 14:07:49 -0700
Subject: [PATCH] nvmet-rdma: check for a valid adrfam
Message-ID: <1465333669-31807-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Now only ipv4 is supported.

Signed-off-by: Ming Lin <ming.l at samsung.com>
---
 drivers/nvme/target/rdma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index fccb01d..c184ee5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1313,6 +1313,15 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 	u16 port_in;
 	int ret;
 
+	switch (port->disc_addr.adrfam) {
+	case NVMF_ADDR_FAMILY_IP4:
+		break;
+	default:
+		pr_err("address family %d not supported\n",
+				port->disc_addr.adrfam);
+		return -EINVAL;
+	}
+
 	ret = kstrtou16(port->disc_addr.trsvcid, 0, &port_in);
 	if (ret)
 		return ret;
-- 
1.9.1
