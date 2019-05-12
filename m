From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 May 2019 11:58:15 -0700
Subject: [PATCH 1/6] nvme-cli: cmbloc code cleanup
In-Reply-To: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
References: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190512185820.20098-2-chaitanya.kulkarni@wdc.com>

This patch removes the unnecessary else condition which is out of
format anyway.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-print.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index c038355..d9512c8 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -3031,12 +3031,11 @@ static void show_registers_cmbloc(__u32 cmbloc, __u32 cmbsz)
 {
 	if (cmbsz == 0) {
 		printf("\tController Memory Buffer feature is not supported\n\n");
+		return;
 	}
-	else {
-		printf("\tOffset                 (OFST): %x (See cmbsz.szu for granularity)\n",
+	printf("\tOffset                 (OFST): %x (See cmbsz.szu for granularity)\n",
 			(cmbloc & 0xfffff000) >> 12);
-		printf("\tBase Indicator Register (BIR): %x\n\n", cmbloc & 0x00000007 );
-	}
+	printf("\tBase Indicator Register (BIR): %x\n\n", cmbloc & 0x00000007 );
 }
 
 static const char *nvme_register_szu_to_string(__u8 szu)
-- 
2.17.0
