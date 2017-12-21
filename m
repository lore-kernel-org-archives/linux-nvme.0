From: jsmart2021@gmail.com (James Smart)
Date: Thu, 21 Dec 2017 14:15:47 -0800
Subject: [PATCH] nvme_fcloop: avoid possible uninitialized variable warning
Message-ID: <20171221221547.3527-1-jsmart2021@gmail.com>

the kbuild test robot send mail of a potential use of an uninitialized
variable - "tport" in fcloop_delete_targetport() which then calls
__targetport_unreg() which uses the variable. It will never be the
case it is uninitialized as the call to __targetport_unreg() only
occurs if there is a valid nport pointer. And at the time the nport
pointer is assigned, the tport variable is set.

Remove the warning by assigning a NULL value initially.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fcloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 9f8a6726df91..34712def81b1 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1233,7 +1233,7 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct fcloop_nport *nport = NULL, *tmpport;
-	struct fcloop_tport *tport;
+	struct fcloop_tport *tport = NULL;
 	u64 nodename, portname;
 	unsigned long flags;
 	int ret;
-- 
2.13.1
