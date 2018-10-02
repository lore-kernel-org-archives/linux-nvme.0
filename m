From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  1 Oct 2018 17:14:21 -0700
Subject: [PATCH rfc 3/4] nvmet: expose support for fabrics SQ flow control
 disable in treq
In-Reply-To: <20181002001422.9111-1-sagi@grimberg.me>
References: <20181002001422.9111-1-sagi@grimberg.me>
Message-ID: <20181002001422.9111-4-sagi@grimberg.me>

Technical Proposal introduces an indication for SQ flow control
disable support. Expose it since we are able to operate in this mode.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/configfs.c | 1 +
 include/linux/nvme.h           | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 53b88858ee97..e0827fce4d21 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1150,6 +1150,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
 
 	port->disc_addr.portid = cpu_to_le16(portid);
+	port->disc_addr.treq = NVMF_TREQ_SQ_FC_DISABLE;
 	config_group_init_type_name(&port->group, name, &nvmet_port_type);
 
 	config_group_init_type_name(&port->subsys_group,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 42b081f0ee51..c7cb47507891 100644
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
+	NVMF_TREQ_SQ_FC_DISABLE = (1 << 2),	/* Supports SQ flow control disable */
 };
 
 /* RDMA QP Service Type codes for Discovery Log Page entry TSAS
-- 
2.17.1
