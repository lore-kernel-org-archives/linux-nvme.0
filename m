From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:00 -0700
Subject: [PATCH 09/18] fabrics: use correct endianess helper in
 print_discovery_log
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-10-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 935f2d0..b8068ba 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -362,7 +362,7 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 
 	printf("\nDiscovery Log Number of Records %d, "
 	       "Generation counter %"PRIu64"\n",
-		numrec, (uint64_t)__le64_to_cpu(log->genctr));
+		numrec, (uint64_t)le64_to_cpu(log->genctr));
 
 	for (i = 0; i < numrec; i++) {
 		struct nvmf_disc_rsp_page_entry *e = &log->entries[i];
-- 
2.1.4
