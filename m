From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 11 May 2019 22:42:54 +0900
Subject: [PATCH 1/2] nvme: Fix typos in nvme status code values
In-Reply-To: <20190511134255.6790-1-minwoo.im.dev@gmail.com>
References: <20190511134255.6790-1-minwoo.im.dev@gmail.com>
Message-ID: <20190511134255.6790-2-minwoo.im.dev@gmail.com>

Fix typos in enumeration names for nvme status:
  s/ACIVATE/ACTIVATE
  s/INSUFFICENT/INSUFFICIENT

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c40720cb59ac..8028adacaff3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1246,9 +1246,9 @@ enum {
 	NVME_SC_FW_NEEDS_SUBSYS_RESET	= 0x110,
 	NVME_SC_FW_NEEDS_RESET		= 0x111,
 	NVME_SC_FW_NEEDS_MAX_TIME	= 0x112,
-	NVME_SC_FW_ACIVATE_PROHIBITED	= 0x113,
+	NVME_SC_FW_ACTIVATE_PROHIBITED	= 0x113,
 	NVME_SC_OVERLAPPING_RANGE	= 0x114,
-	NVME_SC_NS_INSUFFICENT_CAP	= 0x115,
+	NVME_SC_NS_INSUFFICIENT_CAP	= 0x115,
 	NVME_SC_NS_ID_UNAVAILABLE	= 0x116,
 	NVME_SC_NS_ALREADY_ATTACHED	= 0x118,
 	NVME_SC_NS_IS_PRIVATE		= 0x119,
-- 
2.17.1
