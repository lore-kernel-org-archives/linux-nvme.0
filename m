From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  3 Oct 2018 01:13:23 -0700
Subject: [PATCH 5/4 nvme-cli] fabrics: support fabrics sq flow control disable
In-Reply-To: <20181003081323.7504-1-sagi@grimberg.me>
References: <20181003081323.7504-1-sagi@grimberg.me>
Message-ID: <20181003081323.7504-6-sagi@grimberg.me>

If the discovery log entry indicates that the subsystem
supports disabling sq flow control, we ask the host to
connect and disable sq flow control (omit sq_head pointer
updates).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c    | 9 +++++++++
 linux/nvme.h | 7 ++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index d937df47b68e..2db651645f52 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -132,6 +132,8 @@ static const char * const treqs[] = {
 	[NVMF_TREQ_NOT_SPECIFIED]	= "not specified",
 	[NVMF_TREQ_REQUIRED]		= "required",
 	[NVMF_TREQ_NOT_REQUIRED]	= "not required",
+	[NVMF_TREQ_DISABLE_SQFLOW]	= "not specified, "
+					  "sq flow control disable supported",
 };
 
 static inline const char *treq_str(__u8 treq)
@@ -748,6 +750,13 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		return -EINVAL;
 	}
 
+	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW) {
+		len = sprintf(p, ",disable_sqflow");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	if (discover)
 		return do_discover(argstr, true);
 	else
diff --git a/linux/nvme.h b/linux/nvme.h
index 37d3bc1ace6a..4f12c94db4d7 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -58,9 +58,10 @@ enum {
 
 /* Transport Requirements codes for Discovery Log Page entry TREQ field */
 enum {
-	NVMF_TREQ_NOT_SPECIFIED	= 0,	/* Not specified */
-	NVMF_TREQ_REQUIRED	= 1,	/* Required */
-	NVMF_TREQ_NOT_REQUIRED	= 2,	/* Not Required */
+	NVMF_TREQ_NOT_SPECIFIED	= 0,		/* Not specified */
+	NVMF_TREQ_REQUIRED	= 1,		/* Required */
+	NVMF_TREQ_NOT_REQUIRED	= 2,		/* Not Required */
+	NVMF_TREQ_DISABLE_SQFLOW = (1 << 2),	/* SQ flow control disable supported */
 };
 
 /* RDMA QP Service Type codes for Discovery Log Page entry TSAS
-- 
2.17.1
