From: jsmart2021@gmail.com (James Smart)
Date: Tue, 25 Jun 2019 09:06:04 -0700
Subject: [PATCH] nvme-fc: fix module unloads while lports still pending
Message-ID: <20190625160604.3905-1-jsmart2021@gmail.com>

Current code allows the module to be unloaded even if there are
pending data structures, such as localports and controllers on
the localports, that have yet to hit their reference counting
to remove them.

Fix by taking a reference out on the module upon the first localport
registered, and which is cleared when the last localport is removed.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
---
 drivers/nvme/host/fc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b7662e237eb9..bd80e2c475da 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -229,6 +229,8 @@ nvme_fc_free_lport(struct kref *ref)
 	/* remove from transport list */
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	list_del(&lport->port_list);
+	if (list_empty(&nvme_fc_lport_list))
+		module_put(THIS_MODULE);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 	ida_simple_remove(&nvme_fc_local_port_cnt, lport->localport.port_num);
@@ -398,6 +400,11 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 	newrec->localport.port_num = idx;
 
 	spin_lock_irqsave(&nvme_fc_lock, flags);
+	if (list_empty(&nvme_fc_lport_list) && !try_module_get(THIS_MODULE)) {
+		spin_unlock_irqrestore(&nvme_fc_lock, flags);
+		ret = -ENODEV;
+		goto out_dev_put;
+	}
 	list_add_tail(&newrec->port_list, &nvme_fc_lport_list);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
@@ -407,6 +414,9 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 	*portptr = &newrec->localport;
 	return 0;
 
+out_dev_put:
+	if (dev)
+		put_device(dev);
 out_ida_put:
 	ida_simple_remove(&nvme_fc_local_port_cnt, idx);
 out_fail_kfree:
-- 
2.13.7
