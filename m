From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 May 2019 11:58:17 -0700
Subject: [PATCH 3/6] nvme-cli: remove trailing space
In-Reply-To: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
References: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190512185820.20098-4-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index d9512c8..ae22a5b 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -3035,7 +3035,7 @@ static void show_registers_cmbloc(__u32 cmbloc, __u32 cmbsz)
 	}
 	printf("\tOffset                 (OFST): %x (See cmbsz.szu for granularity)\n",
 			(cmbloc & 0xfffff000) >> 12);
-	printf("\tBase Indicator Register (BIR): %x\n\n", cmbloc & 0x00000007 );
+	printf("\tBase Indicator Register (BIR): %x\n\n", cmbloc & 0x00000007);
 }
 
 static const char *nvme_register_szu_to_string(__u8 szu)
-- 
2.17.0
