From: james.smart@broadcom.com (James Smart)
Date: Mon, 26 Sep 2016 07:35:04 -0700
Subject: [PATCH 1/3] nvme-fabrics: patch target code in prep for FC
 transport support
Message-ID: <57e93218.4CgczdRxtAdq+zwV%james.smart@broadcom.com>


Patch nvme-fabrics target code in prep for FC transport support:
- Add FC transport type decoding
- Add FC address family decoding

(Patch unchanged from prior posting)

Signed-off-by: James Smart <james.smart at broadcom.com>
Acked-by: Johannes Thumshirn <jth at kernel.org>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/configfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index af5e2dc..6ffd105 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -37,6 +37,8 @@ static ssize_t nvmet_addr_adrfam_show(struct config_item *item,
 		return sprintf(page, "ipv6\n");
 	case NVMF_ADDR_FAMILY_IB:
 		return sprintf(page, "ib\n");
+	case NVMF_ADDR_FAMILY_FC:
+		return sprintf(page, "fc\n");
 	default:
 		return sprintf(page, "\n");
 	}
@@ -59,6 +61,8 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_IP6;
 	} else if (sysfs_streq(page, "ib")) {
 		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_IB;
+	} else if (sysfs_streq(page, "fc")) {
+		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_FC;
 	} else {
 		pr_err("Invalid value '%s' for adrfam\n", page);
 		return -EINVAL;
@@ -209,6 +213,8 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 		return sprintf(page, "rdma\n");
 	case NVMF_TRTYPE_LOOP:
 		return sprintf(page, "loop\n");
+	case NVMF_TRTYPE_FC:
+		return sprintf(page, "fc\n");
 	default:
 		return sprintf(page, "\n");
 	}
@@ -229,6 +235,12 @@ static void nvmet_port_init_tsas_loop(struct nvmet_port *port)
 	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
 }
 
+static void nvmet_port_init_tsas_fc(struct nvmet_port *port)
+{
+	port->disc_addr.trtype = NVMF_TRTYPE_FC;
+	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
+}
+
 static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		const char *page, size_t count)
 {
@@ -244,6 +256,8 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		nvmet_port_init_tsas_rdma(port);
 	} else if (sysfs_streq(page, "loop")) {
 		nvmet_port_init_tsas_loop(port);
+	} else if (sysfs_streq(page, "fc")) {
+		nvmet_port_init_tsas_fc(port);
 	} else {
 		pr_err("Invalid value '%s' for trtype\n", page);
 		return -EINVAL;
-- 
2.5.0
