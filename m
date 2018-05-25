From: jsmart2021@gmail.com (James Smart)
Date: Fri, 25 May 2018 14:02:23 -0700
Subject: [PATCH] nvme: allow duplicate controller if prior controller being
 deleted
Message-ID: <20180525210223.504-1-jsmart2021@gmail.com>

The current checks for whether a new controller request "matches"
an existing controller ignores controller state and checks identity
strings. There are cases where an existing controller may be in its
last steps of deletion when they are "matched" by a new connection.

Change the behavior so that the new connection ignores controllers
that are deleted.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fabrics.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index ef46c915b7b5..0cf0460a5c92 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -139,7 +139,9 @@ static inline bool
 nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 			struct nvmf_ctrl_options *opts)
 {
-	if (strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
+	if (ctrl->state == NVME_CTRL_DELETING ||
+	    ctrl->state == NVME_CTRL_DEAD ||
+	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
 	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
 	    memcmp(&opts->host->id, &ctrl->opts->host->id, sizeof(uuid_t)))
 		return false;
-- 
2.13.1
