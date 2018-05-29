From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:31 +0200
Subject: [PATCH 10/10] nvmet: set 'nuse' and 'nsze' to zero for inaccessible
 paths
In-Reply-To: <20180529101431.62271-1-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
Message-ID: <20180529101431.62271-11-hare@suse.de>

According to the ANA base specification the 'nuse' and 'nsze' values
can be set to '0' for 'inaccessible' or 'persistent-loss' path states.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 99592c7b8bc7..0ae25478e3eb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -371,6 +371,18 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	id->ncap = id->nuse = id->nsze =
 		cpu_to_le64(ns->size >> ns->blksize_shift);
 
+	if (ns->anagrpid) {
+		enum nvme_ana_state ana_state =
+			req->port->ana_state[ns->anagrpid];
+
+		/*
+		 * nuse and nsze should be zero for inaccessible or
+		 * persistent loss ANA state.
+		 */
+		if ((ana_state == NVME_ANA_INACCESSIBLE) ||
+		    (ana_state == NVME_ANA_PERSISTENT_LOSS))
+			id->nuse = id->nsze = 0;
+	}
 	/*
 	 * We just provide a single LBA format that matches what the
 	 * underlying device reports.
-- 
2.12.3
