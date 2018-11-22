From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 17:56:12 -0800
Subject: [PATCH nvme-cli v3 14/13] fabrics: use trtype_str when parsing a
 discovery log entry
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Message-ID: <20181122015615.15763-15-sagi@grimberg.me>

Reduce some code duplication.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 99793f8beef8..e7c2021b0c70 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -609,6 +609,7 @@ static int build_options(char *argstr, int max_len)
 static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 {
 	char argstr[BUF_SIZE], *p;
+	const char *transport;
 	bool discover, disable_sqflow = true;
 	int len, ret;
 
@@ -681,24 +682,24 @@ retry:
 		p += len;
 	}
 
+	transport = trtype_str(e->trtype);
+	if (!strcmp(transport, "unrecognized")) {
+		fprintf(stderr, "skipping unsupported transport %d\n",
+				 e->trtype);
+		return -EINVAL;
+	}
+
+	len = sprintf(p, ",transport=%s", transport);
+	if (len < 0)
+		return -EINVAL;
+	p += len;
+
 	switch (e->trtype) {
-	case NVMF_TRTYPE_LOOP: /* loop */
-		len = sprintf(p, ",transport=loop");
-		if (len < 0)
-			return -EINVAL;
-		p += len;
-		/* we can safely ignore the rest of the entries */
-		break;
 	case NVMF_TRTYPE_RDMA:
 		switch (e->adrfam) {
 		case NVMF_ADDR_FAMILY_IP4:
 		case NVMF_ADDR_FAMILY_IP6:
 			/* FALLTHRU */
-			len = sprintf(p, ",transport=rdma");
-			if (len < 0)
-				return -EINVAL;
-			p += len;
-
 			len = sprintf(p, ",traddr=%.*s",
 				      space_strip_len(NVMF_TRADDR_SIZE, e->traddr),
 				      e->traddr);
@@ -718,14 +719,10 @@ retry:
 			return -EINVAL;
 		}
 		break;
+	default:
 	case NVMF_TRTYPE_FC:
 		switch (e->adrfam) {
 		case NVMF_ADDR_FAMILY_FC:
-			len = sprintf(p, ",transport=fc");
-			if (len < 0)
-				return -EINVAL;
-			p += len;
-
 			len = sprintf(p, ",traddr=%.*s",
 				      space_strip_len(NVMF_TRADDR_SIZE, e->traddr),
 				      e->traddr);
@@ -738,10 +735,6 @@ retry:
 			return -EINVAL;
 		}
 		break;
-	default:
-		fprintf(stderr, "skipping unsupported transport %d\n",
-				 e->trtype);
-		return -EINVAL;
 	}
 
 	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW && disable_sqflow) {
-- 
2.17.1
