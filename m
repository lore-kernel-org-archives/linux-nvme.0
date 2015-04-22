From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 22 Apr 2015 16:26:51 +0200
Subject: [PATCH v3 2/7] block: add REQ_NVM_GC for targets gc
In-Reply-To: <1429712816-10336-1-git-send-email-m@bjorling.me>
References: <1429712816-10336-1-git-send-email-m@bjorling.me>
Message-ID: <1429712816-10336-3-git-send-email-m@bjorling.me>

In preparation for Open-Channel SSDs. We introduce a special request for
open-channel ssd targets that must perform garbage collection.

Requests are divided into two types. The user and target specific. User
IOs are from fs, user-space, etc. While target specific are IOs that are
issued in the background by targets. Usually garbage collection actions.

For the target to issue garbage collection requests, it is a requirement
that a logical address is locked over two requests. One read and one
write. If a write to the logical address comes in from user-space, a
race-condition might occur and garbage collection will write out-dated
data.

By introducing this flag, the target can manually control locking of
logical addresses.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 include/linux/blk_types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 272c17e..25c6e02 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -195,6 +195,7 @@ enum rq_flag_bits {
 	__REQ_HASHED,		/* on IO scheduler merge hash */
 	__REQ_MQ_INFLIGHT,	/* track inflight for MQ */
 	__REQ_NO_TIMEOUT,	/* requests may never expire */
+	__REQ_NVM_GC,		/* request is a nvm gc request */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -215,7 +216,7 @@ enum rq_flag_bits {
 #define REQ_COMMON_MASK \
 	(REQ_WRITE | REQ_FAILFAST_MASK | REQ_SYNC | REQ_META | REQ_PRIO | \
 	 REQ_DISCARD | REQ_WRITE_SAME | REQ_NOIDLE | REQ_FLUSH | REQ_FUA | \
-	 REQ_SECURE | REQ_INTEGRITY)
+	 REQ_SECURE | REQ_INTEGRITY | REQ_NVM_GC)
 #define REQ_CLONE_MASK		REQ_COMMON_MASK
 
 #define BIO_NO_ADVANCE_ITER_MASK	(REQ_DISCARD|REQ_WRITE_SAME)
@@ -249,5 +250,5 @@ enum rq_flag_bits {
 #define REQ_HASHED		(1ULL << __REQ_HASHED)
 #define REQ_MQ_INFLIGHT		(1ULL << __REQ_MQ_INFLIGHT)
 #define REQ_NO_TIMEOUT		(1ULL << __REQ_NO_TIMEOUT)
-
+#define REQ_NVM_GC		(1ULL << __REQ_NVM_GC)
 #endif /* __LINUX_BLK_TYPES_H */
-- 
1.9.1
