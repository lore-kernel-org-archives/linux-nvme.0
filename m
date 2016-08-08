From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  8 Aug 2016 14:57:57 +0300
Subject: [PATCH v2 nvme-cli 1/4] fabrics: Allow ipv6 address resolution
In-Reply-To: <1470657480-5868-1-git-send-email-sagi@grimberg.me>
References: <1470657480-5868-1-git-send-email-sagi@grimberg.me>
Message-ID: <1470657480-5868-2-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 8a174d41b82b..961335d45bd2 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -438,7 +438,8 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		/* we can safely ignore the rest of the entries */
 		break;
 	case NVMF_TRTYPE_RDMA:
-		if (e->adrfam != NVMF_ADDR_FAMILY_IP4) {
+		if (e->adrfam != NVMF_ADDR_FAMILY_IP4 &&
+		    e->adrfam != NVMF_ADDR_FAMILY_IP6) {
 			fprintf(stderr, "skipping unsupported adrfam\n");
 			return -EINVAL;
 		}
-- 
1.9.1
