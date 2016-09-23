From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:22:56 -0700
Subject: [PATCH 05/18] use abort() instead of __builtin_abort
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-6-git-send-email-hch@lst.de>

This is more portable to different compilers, but should otherwise have
the same effect.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/json.c b/json.c
index e9fcf07..e127aa2 100644
--- a/json.c
+++ b/json.c
@@ -8,7 +8,7 @@
 static inline void fail_and_notify(void)
 {
 	fprintf(stderr, "Allocation of memory for json object failed, aborting.\n");
-	__builtin_abort();
+	abort();
 }
 
 struct json_object *json_create_object(void)
-- 
2.1.4
