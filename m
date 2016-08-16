From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 16 Aug 2016 12:46:24 +0300
Subject: [PATCH v3 nvme-cli 1/4] fabrics: Allow ipv6 address resolution
In-Reply-To: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
References: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
Message-ID: <1471340787-26922-2-git-send-email-sagi@grimberg.me>

While we're at it, make the adrfam condition
a proper switch-case statement.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 fabrics.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 8a174d41b82b..461e126cc56f 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -438,25 +438,29 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		/* we can safely ignore the rest of the entries */
 		break;
 	case NVMF_TRTYPE_RDMA:
-		if (e->adrfam != NVMF_ADDR_FAMILY_IP4) {
+		switch (e->adrfam) {
+		case NVMF_ADDR_FAMILY_IP4:
+		case NVMF_ADDR_FAMILY_IP6:
+			/* FALLTHRU */
+			len = sprintf(p, ",transport=rdma");
+			if (len < 0)
+				return -EINVAL;
+			p += len;
+
+			len = sprintf(p, ",traddr=%s", e->traddr);
+			if (len < 0)
+				return -EINVAL;
+			p += len;
+
+			len = sprintf(p, ",trsvcid=%s", e->trsvcid);
+			if (len < 0)
+				return -EINVAL;
+			p += len;
+			break;
+		default:
 			fprintf(stderr, "skipping unsupported adrfam\n");
 			return -EINVAL;
 		}
-
-		len = sprintf(p, ",transport=rdma");
-		if (len < 0)
-			return -EINVAL;
-		p += len;
-
-		len = sprintf(p, ",traddr=%s", e->traddr);
-		if (len < 0)
-			return -EINVAL;
-		p += len;
-
-		len = sprintf(p, ",trsvcid=%s", e->trsvcid);
-		if (len < 0)
-			return -EINVAL;
-		p += len;
 		break;
 	default:
 		fprintf(stderr, "skipping unsupported transport %d\n",
-- 
1.9.1
