From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 27 Aug 2018 15:31:27 -0700
Subject: [PATCH 2/4] nvme-cli: fix indentation
In-Reply-To: <20180827223129.2741-1-chaitanya.kulkarni@wdc.com>
References: <20180827223129.2741-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180827223129.2741-3-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index 3589c19..17b5eaf 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -643,7 +643,7 @@ static void show_nvme_id_ns_fpi(__u8 fpi)
 	printf("  [7:7] : %#x\tFormat Progress Indicator %sSupported\n",
 		fpis, fpis ? "" : "Not ");
 	if (fpis || (!fpis && fpii))
-	printf("  [6:0] : %#x\tFormat Progress Indicator (Remaining %d%%)\n",
+		printf("  [6:0] : %#x\tFormat Progress Indicator (Remaining %d%%)\n",
 		fpii, fpii);
 	printf("\n");
 }
-- 
2.17.0
