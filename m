From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:49 -0700
Subject: [PATCH 11/16] nvmet: Use strcmp() instead of strncmp() for subsystem
 lookup
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-12-bvanassche@acm.org>

strncmp() stops comparing when either the end of one of the first two arguments
is reached or when 'n' characters have been compared, whichever comes first.
That means that strncmp(s1, s2, n) is equivalent to strcmp(s1, s2) if n exceeds
the length of s1 or the length of s2. Since that is the case in
nvmet_find_get_subsys(), change strncmp() into strcmp(). This patch avoids that
the following warning is reported by smatch:

drivers/nvme/target/core.c:940:1 nvmet_find_get_subsys() error: strncmp() '"nqn.2014-08.org.nvmexpress.discovery"' too small (37 vs 223)

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/target/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b5ec96abd048..0acdff9e6842 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1105,8 +1105,7 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	if (!port)
 		return NULL;
 
-	if (!strncmp(NVME_DISC_SUBSYS_NAME, subsysnqn,
-			NVMF_NQN_SIZE)) {
+	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
 		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
 			return NULL;
 		return nvmet_disc_subsys;
-- 
2.19.0.605.g01d371f741-goog
