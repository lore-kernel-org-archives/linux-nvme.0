From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:25 +0200
Subject: [PATCH 04/10] nvme: clear current path on ANA state change
In-Reply-To: <20180529101431.62271-1-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
Message-ID: <20180529101431.62271-5-hare@suse.de>

Whenever ANA state changes the path selection needs to be retriggered,
so we should be clearing the current path here.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a5f43d164b19..a520582811f8 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -44,6 +44,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 static void nvme_update_ana_state(struct nvme_ns *ns, enum nvme_ana_state state)
 {
 	WRITE_ONCE(ns->ctrl->ana_state[ns->anagrpid], state);
+	nvme_mpath_clear_current_path(ns);
 }
 
 void nvme_failover_req(struct request *req)
-- 
2.12.3
