From: hare@suse.de (Hannes Reinecke)
Date: Mon, 16 Jul 2018 12:58:33 +0200
Subject: [PATCH 1/5] nvme: count all ANA groups for ANA Log page
In-Reply-To: <20180716105837.101125-1-hare@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
Message-ID: <20180716105837.101125-2-hare@suse.de>

When issuing a short read on the ANA log page the number of groups
should not change, even though the final returned data might contain
less groups than that number.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8de264ece826..92682ed11bc4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -200,6 +200,11 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 		offset += len;
 		ngrps++;
 	}
+	while (grpid <= NVMET_MAX_ANAGRPS) {
+		if (nvmet_ana_group_enabled[grpid])
+			ngrps++;
+		grpid++;
+	}
 
 	hdr.chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
 	hdr.ngrps = cpu_to_le16(ngrps);
-- 
2.12.3
