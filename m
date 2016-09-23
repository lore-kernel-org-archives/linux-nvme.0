From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:03 -0700
Subject: [PATCH 12/18] add missing endianess conversions in print_list_item
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-13-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme.c b/nvme.c
index f263e50..ab782d0 100644
--- a/nvme.c
+++ b/nvme.c
@@ -731,8 +731,8 @@ struct list_item {
 static void print_list_item(struct list_item list_item)
 {
 
-	double nsze       = list_item.ns.nsze;
-	double nuse       = list_item.ns.nuse;
+	double nsze       = le64_to_cpu(list_item.ns.nsze);
+	double nuse       = le64_to_cpu(list_item.ns.nuse);
 	long long int lba = list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ds;
 
 	lba  = (1 << lba);
-- 
2.1.4
