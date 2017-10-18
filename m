From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 13:46:07 +0300
Subject: [PATCH v2] nvme/target: Change max_nsid in subsystem due to
 ns_disable if needed
Message-ID: <1508323567-8536-1-git-send-email-sagi@grimberg.me>

From: Roy Shterman <roys@lightbitslabs.com>

In case we disable namespaces which has the nsid like
subsystem max_nsid we need to search for the next largest nsid
in this subsystem. If the subsystem don't has more namespaces
we set it to 0, else we take nsid from the last namespace in
namespaces list because the list is sorted while inserting.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
---
Changes from v1:
- Fixed compilation glitch
- moved max_nsid to a dedicated function

 drivers/nvme/target/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1b208beeef50..794a3d322cd5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -57,6 +57,18 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf, size_t len)
 	return 0;
 }
 
+static void nvmet_subsys_update_max_nsid(struct nvmet_subsys *subsys)
+{
+	if (list_empty(&subsys->namespaces)) {
+		subsys->max_nsid = 0;
+	} else {
+		struct nvmet_ns *ns =
+			list_last_entry(&subsys->namespaces, struct nvmet_ns, dev_link);
+
+		subsys->max_nsid = ns->nsid;
+	}
+}
+
 static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
 {
 	return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
@@ -334,6 +346,10 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 
 	ns->enabled = false;
 	list_del_rcu(&ns->dev_link);
+
+	if (ns->nsid == subsys->max_nsid)
+		nvmet_subsys_update_max_nsid(subsys);
+
 	mutex_unlock(&subsys->lock);
 
 	/*
-- 
2.7.4
