From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Nov 2018 10:25:32 -0800
Subject: [PATCH v3 3/4] nvmet: expose support for fabrics SQ flow control
 disable in treq
In-Reply-To: <20181114182534.28807-1-sagi@grimberg.me>
References: <20181114182534.28807-1-sagi@grimberg.me>
Message-ID: <20181114182534.28807-4-sagi@grimberg.me>

Technical Proposal introduces an indication for SQ flow control
disable support. Expose it since we are able to operate in this mode.

Reviewed-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/configfs.c | 1 +
 include/linux/nvme.h           | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index a98ab935b537..c2df205096ec 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1214,6 +1214,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
 
 	port->disc_addr.portid = cpu_to_le16(portid);
+	port->disc_addr.treq = NVMF_TREQ_DISABLE_SQFLOW;
 	config_group_init_type_name(&port->group, name, &nvmet_port_type);
 
 	config_group_init_type_name(&port->subsys_group,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e7d731776f62..4a560ea04d7c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -58,9 +58,10 @@ enum {
 
 /* Transport Requirements codes for Discovery Log Page entry TREQ field */
 enum {
-	NVMF_TREQ_NOT_SPECIFIED	= 0,	/* Not specified */
-	NVMF_TREQ_REQUIRED	= 1,	/* Required */
-	NVMF_TREQ_NOT_REQUIRED	= 2,	/* Not Required */
+	NVMF_TREQ_NOT_SPECIFIED	= 0,		/* Not specified */
+	NVMF_TREQ_REQUIRED	= 1,		/* Required */
+	NVMF_TREQ_NOT_REQUIRED	= 2,		/* Not Required */
+	NVMF_TREQ_DISABLE_SQFLOW = (1 << 2),	/* Supports SQ flow control disable */
 };
 
 /* RDMA QP Service Type codes for Discovery Log Page entry TSAS
-- 
2.17.1
