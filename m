From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon, 13 May 2019 00:54:11 +0900
Subject: [PATCH v3 1/7] devcoredump: use memory_read_from_buffer
In-Reply-To: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1557676457-4195-2-git-send-email-akinobu.mita@gmail.com>

Use memory_read_from_buffer() to simplify devcd_readv().

Cc: Johannes Berg <johannes at sipsolutions.net>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Kenneth Heitke <kenneth.heitke at intel.com>
Reviewed-by: Johannes Berg <johannes at sipsolutions.net>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
* v3
- No change since v2

 drivers/base/devcoredump.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f1a3353..3c960a6 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -164,16 +164,7 @@ static struct class devcd_class = {
 static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
 			   void *data, size_t datalen)
 {
-	if (offset > datalen)
-		return -EINVAL;
-
-	if (offset + count > datalen)
-		count = datalen - offset;
-
-	if (count)
-		memcpy(buffer, ((u8 *)data) + offset, count);
-
-	return count;
+	return memory_read_from_buffer(buffer, count, &offset, data, datalen);
 }
 
 static void devcd_freev(void *data)
-- 
2.7.4
