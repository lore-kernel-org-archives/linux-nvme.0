From: colin.king@canonical.com (Colin King)
Date: Fri,  9 Dec 2016 14:59:47 +0000
Subject: [PATCH] nvme-fabrics: remove some logically dead code performing
 redundant ret checks
Message-ID: <20161209145947.5766-1-colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

The check to see if ret is non-zero and return this rather than count
is redundant in two occassions.  It is redundant because prior to this
check, the return code ret is already checked for a non-zero error
return value and we return from the function at that point.

Signed-off-by: Colin Ian King <colin.king at canonical.com>
---
 drivers/nvme/target/fcloop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index bcb8ebe..4e8e6a2 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -845,7 +845,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	rport->lport = nport->lport;
 	nport->rport = rport;
 
-	return ret ? ret : count;
+	return count;
 }
 
 
@@ -952,7 +952,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	tport->lport = nport->lport;
 	nport->tport = tport;
 
-	return ret ? ret : count;
+	return count;
 }
 
 
-- 
2.10.2
