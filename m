From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  7 Aug 2016 15:19:22 +0300
Subject: [PATCH nvme-cli 1/4] fabrics: Allow ipv6 address resolution
In-Reply-To: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
Message-ID: <1470572365-20674-2-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 4bf557b5e672..221e34e5e39b 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -390,7 +390,8 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
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
