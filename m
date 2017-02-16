From: hch@lst.de (Christoph Hellwig)
Date: Thu, 16 Feb 2017 21:10:52 +0100
Subject: [PATCH 1/2] block/sed-opal: tone down not supported warnings
Message-ID: <20170216201053.1190-1-hch@lst.de>

Not having OPAL or a sub-feature supported is an entirely normal
condition for many drives, so don't warn about it.  Keep the messages,
but tone them down to debug only.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/sed-opal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index e95b8a57053d..bcdd5b6d02e8 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -387,16 +387,16 @@ static int opal_discovery0_end(struct opal_dev *dev)
 	}
 
 	if (!supported) {
-		pr_err("This device is not Opal enabled. Not Supported!\n");
+		pr_debug("This device is not Opal enabled. Not Supported!\n");
 		return -EOPNOTSUPP;
 	}
 
 	if (!single_user)
-		pr_warn("Device doesn't support single user mode\n");
+		pr_debug("Device doesn't support single user mode\n");
 
 
 	if (!found_com_id) {
-		pr_warn("Could not find OPAL comid for device. Returning early\n");
+		pr_debug("Could not find OPAL comid for device. Returning early\n");
 		return -EOPNOTSUPP;;
 	}
 
@@ -1951,7 +1951,7 @@ void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv)
 	mutex_init(&opal_dev->dev_lock);
 	opal_dev->send_recv = send_recv;
 	if (check_opal_support(opal_dev) < 0)
-		pr_warn("Opal is not supported on this device\n");
+		pr_debug("Opal is not supported on this device\n");
 	opal_dev->initialized = true;
 }
 EXPORT_SYMBOL(init_opal_dev);
-- 
2.11.0
