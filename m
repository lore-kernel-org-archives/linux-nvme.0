From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Apr 2017 21:26:57 +0200
Subject: [PATCH 12/23] dm mpath: don't check for req->errors
In-Reply-To: <20170419192708.22098-1-hch@lst.de>
References: <20170419192708.22098-1-hch@lst.de>
Message-ID: <20170419192708.22098-13-hch@lst.de>

We'll get all proper errors reported through ->end_io and ->errors will
go away soon.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/md/dm-mpath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index ab55955ed704..2950b145443d 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1492,7 +1492,7 @@ static int do_end_io(struct multipath *m, struct request *clone,
 	 */
 	int r = DM_ENDIO_REQUEUE;
 
-	if (!error && !clone->errors)
+	if (!error)
 		return 0;	/* I/O complete */
 
 	if (noretry_error(error))
-- 
2.11.0
