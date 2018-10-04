From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Thu,  4 Oct 2018 08:49:28 -0700
Subject: [PATCH 08/11] nvmet: Maintain a global list of ports
In-Reply-To: <1538668171-232344-1-git-send-email-jay.e.sternberg@intel.com>
References: <1538668171-232344-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1538668171-232344-9-git-send-email-jay.e.sternberg@intel.com>

To be used when Discovery Change notifications occur

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Phil Cayton <phil.cayton at intel.com>
---
 drivers/nvme/target/configfs.c | 7 +++++++
 drivers/nvme/target/nvmet.h    | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index df841e0..c1ad175 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -23,6 +23,9 @@
 static const struct config_item_type nvmet_host_type;
 static const struct config_item_type nvmet_subsys_type;
 
+static LIST_HEAD(nvmet_ports_list);
+struct list_head *nvmet_ports = &nvmet_ports_list;
+
 static const struct nvmet_transport_name {
 	u8		type;
 	const char	*name;
@@ -1091,6 +1094,8 @@ static void nvmet_port_release(struct config_item *item)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
 
+	list_del(&port->global_entry);
+
 	kfree(port->ana_state);
 	kfree(port);
 }
@@ -1143,6 +1148,8 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 			port->ana_state[i] = NVME_ANA_INACCESSIBLE;
 	}
 
+	list_add(&port->global_entry, &nvmet_ports_list);
+
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dbde3ad..ea93a46 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -130,6 +130,7 @@ struct nvmet_port {
 	struct list_head		subsystems;
 	struct config_group		referrals_group;
 	struct list_head		referrals;
+	struct list_head		global_entry;
 	struct config_group		ana_groups_group;
 	struct nvmet_ana_group		ana_default_group;
 	enum nvme_ana_state		*ana_state;
@@ -420,6 +421,8 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 
+extern struct list_head *nvmet_ports;
+
 #define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
 #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
-- 
1.8.3.1
