From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 26 Jul 2018 14:59:13 -0700
Subject: [PATCH] nvme-cli: remove unnecessary assignments
Message-ID: <20180726215913.20295-1-chaitanya.kulkarni@wdc.com>

This removes the unnecessary assignment of the variable.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 fabrics.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 9aee8f8..8437e32 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -627,7 +627,6 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		len = sprintf(p, ",transport=loop");
 		if (len < 0)
 			return -EINVAL;
-		p += len;
 		/* we can safely ignore the rest of the entries */
 		break;
 	case NVMF_TRTYPE_RDMA:
@@ -652,7 +651,6 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 				      e->trsvcid);
 			if (len < 0)
 				return -EINVAL;
-			p += len;
 			break;
 		default:
 			fprintf(stderr, "skipping unsupported adrfam\n");
@@ -672,7 +670,6 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 				      e->traddr);
 			if (len < 0)
 				return -EINVAL;
-			p += len;
 			break;
 		default:
 			fprintf(stderr, "skipping unsupported adrfam\n");
-- 
2.17.0
