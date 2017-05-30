From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 30 May 2017 10:08:19 +0200
Subject: [PATCH 4/7] nvme: also report include the EUI-64 in identify NS report
In-Reply-To: <cover.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
Message-ID: <2f6eac411a9ce4c0bdc756e0cb5cfed66208b9d7.1496131397.git.jthumshirn@suse.de>

Now that we can configure a namespace's EUI-64, report it back to the
host in an 'Identify Namespace' command reply.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ff1f97006322..60c9eec57986 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -322,6 +322,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	id->nmic = (1 << 0);
 
 	memcpy(&id->nguid, &ns->nguid, sizeof(uuid_le));
+	memcpy(&id->eui64, &ns->eui64, sizeof(ns->eui64));
 
 	id->lbaf[0].ds = ns->blksize_shift;
 
-- 
2.12.0
