From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 19 Jun 2019 16:00:06 -0700
Subject: [PATCH] nvmet-rdma: move port tsas initialization to rdma code
Message-ID: <20190619230006.15715-1-sagi@grimberg.me>

Also, look at the device transport capability to send
the correct trtype (ib/roce/rocev2/iwarp). Note that if
we are listening on addr_any we still return "not specified"
trtype and the same goes for referrals.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/configfs.c |  9 ---------
 drivers/nvme/target/rdma.c     | 25 +++++++++++++++++++++++++
 include/linux/nvme-rdma.h      | 17 +++++++++++++++++
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 08dd5af357f7..ea8ed83aa1db 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -263,13 +263,6 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 	return sprintf(page, "\n");
 }
 
-static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
-{
-	port->disc_addr.tsas.rdma.qptype = NVMF_RDMA_QPTYPE_CONNECTED;
-	port->disc_addr.tsas.rdma.prtype = NVMF_RDMA_PRTYPE_NOT_SPECIFIED;
-	port->disc_addr.tsas.rdma.cms = NVMF_RDMA_CMS_RDMA_CM;
-}
-
 static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		const char *page, size_t count)
 {
@@ -292,8 +285,6 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 found:
 	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
 	port->disc_addr.trtype = nvmet_transport_names[i].type;
-	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
-		nvmet_port_init_tsas_rdma(port);
 	return count;
 }
 
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 36d906a7f70d..8beb51731914 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1499,6 +1499,29 @@ static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 }
 
+void nvme_rdma_init_tsas(struct nvmet_port *port, struct rdma_cm_id *id)
+{
+	port->disc_addr.tsas.rdma.qptype = NVME_RDMA_QPTYPE_RC;
+	port->disc_addr.tsas.rdma.cms = NVME_RDMA_CMS_RDMA_CM;
+	if (!id->device) {
+		port->disc_addr.tsas.rdma.prtype =
+			NVME_RDMA_PRTYPE_NOT_SPECIFIED;
+	} else if (rdma_cap_iw_cm(id->device, 1)) {
+		port->disc_addr.tsas.rdma.prtype =
+			NVME_RDMA_PRTYPE_IWARP;
+	} else {
+		if(rdma_protocol_roce_udp_encap(id->device, 1))
+			port->disc_addr.tsas.rdma.prtype =
+				NVME_RDMA_PRTYPE_ROCEv2;
+		else if (rdma_protocol_ib(id->device, 1))
+			port->disc_addr.tsas.rdma.prtype =
+				NVME_RDMA_PRTYPE_IB;
+		else
+			port->disc_addr.tsas.rdma.prtype =
+				NVME_RDMA_PRTYPE_ROCE;
+	}
+}
+
 static int nvmet_rdma_add_port(struct nvmet_port *port)
 {
 	struct rdma_cm_id *cm_id;
@@ -1567,6 +1590,8 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 		goto out_destroy_id;
 	}
 
+	nvme_rdma_init_tsas(port, cm_id);
+
 	pr_info("enabling port %d (%pISpcs)\n",
 		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
 	port->priv = cm_id;
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 3ec8e50efa16..27a6fc242bcd 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -21,6 +21,23 @@ enum nvme_rdma_cm_status {
 	NVME_RDMA_CM_INVALID_ORD	= 0x08,
 };
 
+enum nvme_rdma_qptype {
+	NVME_RDMA_QPTYPE_RC		= 0x1,
+	NVME_RDMA_QPTYPE_RD		= 0x2,
+};
+
+enum nvme_rdma_prtype {
+	NVME_RDMA_PRTYPE_NOT_SPECIFIED	= 0x1,
+	NVME_RDMA_PRTYPE_IB		= 0x2,
+	NVME_RDMA_PRTYPE_ROCE		= 0x3,
+	NVME_RDMA_PRTYPE_ROCEv2		= 0x4,
+	NVME_RDMA_PRTYPE_IWARP		= 0x5,
+};
+
+enum nvme_rdma_cms {
+	NVME_RDMA_CMS_RDMA_CM		= 0x1,
+};
+
 static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
 {
 	switch (status) {
-- 
2.17.1
