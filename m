From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed,  7 Sep 2016 15:43:26 -0700
Subject: [PATCH] nvme-cli: match treq value names to spec
Message-ID: <1473288206-16121-1-git-send-email-james_p_freyensee@linux.intel.com>

Fabrics spec uses "not specified" as one of the values for treq,
just like other discovery parameters (like rdma_prtype).

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 18e961c..e7e3c56 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -116,7 +116,7 @@ static inline const char *nqntype_str(__u8 nqntype)
 }
 
 static const char * const treqs[] = {
-	[NVMF_TREQ_NOT_SPECIFIED]	= "unspecified transport requirements",
+	[NVMF_TREQ_NOT_SPECIFIED]	= "not specified",
 	[NVMF_TREQ_REQUIRED]		= "required",
 	[NVMF_TREQ_NOT_REQUIRED]	= "not required",
 };
-- 
2.7.4
