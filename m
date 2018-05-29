From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:27 +0200
Subject: [PATCH 06/10] nvme: simplify check for ANA in
 nvme_ns_id_attrs_are_visible()
In-Reply-To: <20180529101431.62271-1-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
Message-ID: <20180529101431.62271-7-hare@suse.de>

Instead of adding another indirection to the controller we can
as well check the ANA group id of the namespace to figure out
if ANA is supported.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc43bb685e63..194cce7e63ce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2714,7 +2714,7 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
 		if (dev_to_disk(dev)->fops != &nvme_fops) /* per-path attr */
 			return 0;
-		if (!nvme_ctrl_has_ana(nvme_get_ns_from_dev(dev)->ctrl))
+		if (!nvme_get_ns_from_dev(dev)->anagrpid)
 			return 0;
 	}
 #endif
-- 
2.12.3
