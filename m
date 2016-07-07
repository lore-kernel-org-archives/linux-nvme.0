From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 7 Jul 2016 11:15:26 +0300
Subject: [patch] nvmet: fix an error code
Message-ID: <20160707081526.GA16742@mwanda>

We accidentally return zero here when ERR_PTR(-ENOMEM) is intended.

Fixes: a07b4970f464 ('nvmet: add a generic NVMe target')
Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9bed302..af5e2dc 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -737,7 +737,7 @@ static struct config_group *nvmet_referral_make(
 
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port)
-		return ERR_CAST(port);
+		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&port->entry);
 	config_group_init_type_name(&port->group, name, &nvmet_referral_type);
@@ -794,7 +794,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port)
-		return ERR_CAST(port);
+		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
