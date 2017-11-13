From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 13 Nov 2017 12:29:40 +0000
Subject: [PATCH 1/4] nvmet: Fix error flow in nvmet_alloc_ctrl()
In-Reply-To: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
References: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
Message-ID: <1510576183-17215-2-git-send-email-israelr@mellanox.com>

Remove the allocated id on error.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 22a2a2b..5699c9a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -821,7 +821,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		/* Don't accept keep-alive timeout for discovery controllers */
 		if (kato) {
 			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-			goto out_free_sqs;
+			goto out_remove_ida;
 		}
 
 		/*
@@ -851,6 +851,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	*ctrlp = ctrl;
 	return 0;
 
+out_remove_ida:
+	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 out_free_sqs:
 	kfree(ctrl->sqs);
 out_free_cqs:
-- 
1.8.3.1
