From: hch@lst.de (Christoph Hellwig)
Date: Fri,  1 Jun 2018 09:11:20 +0200
Subject: [PATCH 1/9] nvme: don't hold nvmf_transports_rwsem for more than
 transport lookups
In-Reply-To: <20180601071128.7630-1-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
Message-ID: <20180601071128.7630-2-hch@lst.de>

From: Johannes Thumshirn <jthumshirn@suse.de>

Only take nvmf_transports_rwsem when doing a lookup of registered
transports, so that a blocking ->create_ctrl doesn't prevent other
actions on /dev/nvme-fabrics.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
[hch: increased lock hold time a bit to be safe, added a comment
 and updated the changelog]
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.c | 3 ++-
 drivers/nvme/host/fabrics.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5f5f7067c41d..fa32c1216409 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -952,6 +952,7 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		ret = -EBUSY;
 		goto out_unlock;
 	}
+	up_read(&nvmf_transports_rwsem);
 
 	ret = nvmf_check_required_opts(opts, ops->required_opts);
 	if (ret)
@@ -968,11 +969,11 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 	}
 
 	module_put(ops->module);
-	up_read(&nvmf_transports_rwsem);
 	return ctrl;
 
 out_module_put:
 	module_put(ops->module);
+	goto out_free_opts;
 out_unlock:
 	up_read(&nvmf_transports_rwsem);
 out_free_opts:
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 0cf0460a5c92..7491a0bbf711 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -124,6 +124,9 @@ struct nvmf_ctrl_options {
  *	1. At minimum, 'required_opts' and 'allowed_opts' should
  *	   be set to the same enum parsing options defined earlier.
  *	2. create_ctrl() must be defined (even if it does nothing)
+ *	3. struct nvmf_transport_ops must be statically allocated in the
+ *	   modules .bss section so that a pure module_get on @module
+ *	   prevents the memory from beeing freed.
  */
 struct nvmf_transport_ops {
 	struct list_head	entry;
-- 
2.17.0
