From: mgandhi@redhat.com (Milan P. Gandhi)
Date: Thu, 9 Aug 2018 21:49:24 +0530
Subject: [PATCH] Fix typo in nvme_identify_ns_descs
Message-ID: <20180809161924.GA13201@machine1>

Signed-off-by: Milan P. Gandhi <mgandhi at redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bf65501e6ed6..21d5d597b328 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -959,7 +959,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 			uuid_copy(&ids->uuid, data + pos + sizeof(*cur));
 			break;
 		default:
-			/* Skip unnkown types */
+			/* Skip unknown types */
 			len = cur->nidl;
 			break;
 		}
-- 
2.14.3
