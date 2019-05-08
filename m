From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed,  8 May 2019 11:36:33 -0700
Subject: [PATCH 2/3] nvme: add sanitize log identifier
In-Reply-To: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
References: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190508183634.4682-3-chaitanya.kulkarni@wdc.com>

Introduce sanitize log page identifier which is used in next patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 include/linux/nvme.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d439c129d8af..35381d689936 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -835,6 +835,7 @@ enum {
 	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
+	NVME_LOG_SANITIZE       = 0x81,
 	NVME_FWACT_REPL		= (0 << 3),
 	NVME_FWACT_REPL_ACTV	= (1 << 3),
 	NVME_FWACT_ACTV		= (2 << 3),
-- 
2.17.0
