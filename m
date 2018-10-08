From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:41 -0700
Subject: [PATCH 03/16] nvme-core: Rework a NQN copying operation
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-4-bvanassche@acm.org>

Although it is easy to see that the code in nvme_init_subnqn() guarantees that
the subsys->nqn string is '\0'-terminated, apparently Coverity is not smart
enough to see this. Make it easier for Coverity to analyze this code by changing
the strncpy() call into a strlcpy() call. This patch does not change the
behavior of the code but fixes Coveritiy ID 1423720.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 04138223fad6..3746fe49c382 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2084,7 +2084,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strncpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
+		strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
 		return;
 	}
 
-- 
2.19.0.605.g01d371f741-goog
