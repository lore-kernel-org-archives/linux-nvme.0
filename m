From: mlin@kernel.org (Ming Lin)
Date: Tue, 07 Jun 2016 14:33:20 -0700
Subject: [PATCH nvme-cli] print friendly name for trtype and adrfam
Message-ID: <1465335200-32354-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Without this patch:
=====Discovery Log Entry 0======
trtype:  1
adrfam:  1

With this patch:
=====Discovery Log Entry 0======
trtype:  ipv4
adrfam:  rdma

Signed-off-by: Ming Lin <ming.l at samsung.com>
---
 fabrics.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index c643598..d30bef2 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -271,8 +271,42 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 		struct nvmf_disc_rsp_page_entry *e = &log->entries[i];
 
 		printf("=====Discovery Log Entry %d======\n", i);
-		printf("trtype:  %d\n", e->trtype);
-		printf("adrfam:  %d\n", e->adrfam);
+
+		printf("trtype:  ");
+		switch(e->trtype) {
+		case NVMF_ADDR_FAMILY_IP4:
+			printf("ipv4\n");
+			break;
+		case NVMF_ADDR_FAMILY_IP6:
+			printf("ipv6\n");
+			break;
+		case NVMF_ADDR_FAMILY_IB:
+			printf("ib\n");
+			break;
+		case NVMF_ADDR_FAMILY_FC:
+			printf("fc\n");
+			break;
+		default:
+			printf("unknown\n");
+			break;
+		}
+
+		printf("adrfam:  ");
+		switch(e->adrfam) {
+		case NVMF_TRTYPE_RDMA:
+			printf("rdma\n");
+			break;
+		case NVMF_TRTYPE_FC:
+			printf("fc\n");
+			break;
+		case NVMF_TRTYPE_LOOP:
+			printf("loop\n");
+			break;
+		default:
+			printf("unknown\n");
+			break;
+		}
+
 		printf("nqntype: %d\n", e->nqntype);
 		printf("treq:    %d\n", e->treq);
 		printf("portid:  %d\n", e->portid);
-- 
1.9.1
