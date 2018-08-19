From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 Aug 2018 13:14:16 -0400
Subject: [PATCH] nvme-cli: make show_registers_cap() static
Message-ID: <20180819171416.30564-1-chaitanya.kulkarni@wdc.com>

The function show_registers_cap() us only used in the nvme-print.c,
mark this function static.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index 8a604c5..4c2a73a 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2825,7 +2825,7 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 	json_print_object(root, NULL);
 }
 
-void show_registers_cap(struct nvme_bar_cap *cap)
+static void show_registers_cap(struct nvme_bar_cap *cap)
 {
 	printf("\tMemory Page Size Maximum      (MPSMAX): %u bytes\n", 1 <<  (12 + ((cap->mpsmax_mpsmin & 0xf0) >> 4)));
 	printf("\tMemory Page Size Minimum      (MPSMIN): %u bytes\n", 1 <<  (12 + (cap->mpsmax_mpsmin & 0x0f)));
-- 
2.14.1
