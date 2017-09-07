From: jsmart2021@gmail.com (James Smart)
Date: Thu,  7 Sep 2017 16:27:25 -0700
Subject: [PATCH 1/5] nvme: remove FC transport-specific error values
In-Reply-To: <20170907232729.28763-1-jsmart2021@gmail.com>
References: <20170907232729.28763-1-jsmart2021@gmail.com>
Message-ID: <20170907232729.28763-2-jsmart2021@gmail.com>

The NVM express group recinded the reserved range for the transport.
Remove the FC-centric values that had been defined.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 include/linux/nvme.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 823bf6f80dae..3aedd930b988 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1133,19 +1133,6 @@ enum {
 	NVME_SC_UNWRITTEN_BLOCK		= 0x287,
 
 	NVME_SC_DNR			= 0x4000,
-
-
-	/*
-	 * FC Transport-specific error status values for NVME commands
-	 *
-	 * Transport-specific status code values must be in the range 0xB0..0xBF
-	 */
-
-	/* Generic FC failure - catchall */
-	NVME_SC_FC_TRANSPORT_ERROR	= 0x00B0,
-
-	/* I/O failure due to FC ABTS'd */
-	NVME_SC_FC_TRANSPORT_ABORTED	= 0x00B1,
 };
 
 struct nvme_completion {
-- 
2.13.1
