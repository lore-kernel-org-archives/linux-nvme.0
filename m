From: mlin@kernel.org (Ming Lin)
Date: Tue, 07 Jun 2016 15:07:27 -0700
Subject: [PATCH nvme-cli] switch trtype and adrfam print
Message-ID: <1465337247-564-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Signed-off-by: Ming Lin <ming.l at samsung.com>
---

Dave,

Could you help to take a look?
Just to make sure I don't make stupid mistake again.

 fabrics.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index d30bef2..0071147 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -274,18 +274,15 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 
 		printf("trtype:  ");
 		switch(e->trtype) {
-		case NVMF_ADDR_FAMILY_IP4:
-			printf("ipv4\n");
-			break;
-		case NVMF_ADDR_FAMILY_IP6:
-			printf("ipv6\n");
-			break;
-		case NVMF_ADDR_FAMILY_IB:
-			printf("ib\n");
+		case NVMF_TRTYPE_RDMA:
+			printf("rdma\n");
 			break;
-		case NVMF_ADDR_FAMILY_FC:
+		case NVMF_TRTYPE_FC:
 			printf("fc\n");
 			break;
+		case NVMF_TRTYPE_LOOP:
+			printf("loop\n");
+			break;
 		default:
 			printf("unknown\n");
 			break;
@@ -293,14 +290,17 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 
 		printf("adrfam:  ");
 		switch(e->adrfam) {
-		case NVMF_TRTYPE_RDMA:
-			printf("rdma\n");
+		case NVMF_ADDR_FAMILY_IP4:
+			printf("ipv4\n");
 			break;
-		case NVMF_TRTYPE_FC:
-			printf("fc\n");
+		case NVMF_ADDR_FAMILY_IP6:
+			printf("ipv6\n");
 			break;
-		case NVMF_TRTYPE_LOOP:
-			printf("loop\n");
+		case NVMF_ADDR_FAMILY_IB:
+			printf("ib\n");
+			break;
+		case NVMF_ADDR_FAMILY_FC:
+			printf("fc\n");
 			break;
 		default:
 			printf("unknown\n");
-- 
1.9.1
