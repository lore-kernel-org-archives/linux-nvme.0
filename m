From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Tue, 11 Apr 2017 11:32:32 -0700
Subject: [PATCH v2 5/5] nvmet_fc: add missing reference in add_port
In-Reply-To: <20170411183232.8955-1-jsmart2021@gmail.com>
References: <20170411183232.8955-1-jsmart2021@gmail.com>
Message-ID: <20170411183232.8955-6-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Add missing reference in add_port

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index e5d30bb..4a44fd3 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2377,6 +2377,7 @@ nvmet_fc_add_port(struct nvmet_port *port)
 			if (!tgtport->port) {
 				tgtport->port = port;
 				port->priv = tgtport;
+				nvmet_fc_tgtport_get(tgtport);
 				ret = 0;
 			} else
 				ret = -EALREADY;
-- 
2.9.3
