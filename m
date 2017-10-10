From: roys@lightbitslabs.com (roys@lightbitslabs.com)
Date: Tue, 10 Oct 2017 18:59:27 +0300
Subject: [PATCH] nvme/target: Change max_nsid in subsystem due to ns_disable
 if needed
Message-ID: <1507651167-4839-1-git-send-email-roys@lightbitslabs.com>

From: Roy Shterman <roys@lightbitslabs.com>

In case we disable namespaces which has the nsid like
subsystem max_nsid we need to search for the next largest nsid
in this subsystem. If the subsystem don't has more namespaces
we set it to 0, else we take nsid from the last namespace in
namespaces list because the list is sorted while inserting.

Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
---
 drivers/nvme/target/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index eb9399a..e996972 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -334,6 +334,17 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 
 	ns->enabled = false;
 	list_del_rcu(&ns->dev_link);
+
+	if (ns->nsid == subsys->max_nsid) {
+		if (list_empty(&subsys->namespaces)) {
+			subsys->max_nsid = 0;
+		} else {
+			struct nvmet_ns *ns = list_last_entry(&subsys->namespaces, struct nvmet_ns, entry);
+
+			subsys->max_nsid = ns->nsid;
+		}
+	}
+
 	mutex_unlock(&subsys->lock);
 
 	/*
-- 
2.7.4
