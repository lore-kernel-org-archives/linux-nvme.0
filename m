From: hch@lst.de (Christoph Hellwig)
Date: Wed,  8 Jun 2016 14:31:04 +0200
Subject: [PATCH 09/11] nvmet-rdma: check for a valid adrfam
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
Message-ID: <1465389066-19119-10-git-send-email-hch@lst.de>

From: Ming Lin <ming.l@samsung.com>

For now only ipv4 is supported.

Signed-off-by: Ming Lin <ming.l at samsung.com>
Acked-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
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
2.1.4
