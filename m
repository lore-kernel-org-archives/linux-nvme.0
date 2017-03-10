From: bkenward@solarflare.com (Bert Kenward)
Date: Fri, 10 Mar 2017 11:31:35 +0000
Subject: [PATCH RFC 4/4] nvme-fabrics: add tcp to trtype list for configfs
In-Reply-To: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
References: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
Message-ID: <362529c4-bc30-9dec-8861-72a95674ebcd@solarflare.com>

Cc: Ripduman Sohan <rip.sohan at verrko.com>
Cc: Lucian Carata <lucian.carata at cl.cam.ac.uk>
Signed-off-by: Bert Kenward <bkenward at solarflare.com>
---
 drivers/nvme/target/configfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index be8c800078e2..d7dbf09c5075 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -215,6 +215,8 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 		return sprintf(page, "loop\n");
 	case NVMF_TRTYPE_FC:
 		return sprintf(page, "fc\n");
+	case NVMF_TRTYPE_TCP:
+		return sprintf(page, "tcp\n");
 	default:
 		return sprintf(page, "\n");
 	}
@@ -241,6 +243,12 @@ static void nvmet_port_init_tsas_fc(struct nvmet_port *port)
 	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
 }
 
+static void nvmet_port_init_tsas_tcp(struct nvmet_port *port)
+{
+	port->disc_addr.trtype = NVMF_TRTYPE_TCP;
+	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
+}
+
 static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		const char *page, size_t count)
 {
@@ -258,6 +266,8 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		nvmet_port_init_tsas_loop(port);
 	} else if (sysfs_streq(page, "fc")) {
 		nvmet_port_init_tsas_fc(port);
+	} else if (sysfs_streq(page, "tcp")) {
+		nvmet_port_init_tsas_tcp(port);
 	} else {
 		pr_err("Invalid value '%s' for trtype\n", page);
 		return -EINVAL;
-- 
2.7.4
