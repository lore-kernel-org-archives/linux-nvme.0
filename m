From: mwilck@suse.com (Martin Wilck)
Date: Tue, 18 Jul 2017 09:29:14 +0200
Subject: [PATCH v2 2/4] libmultipath: drop uevent_can_discard_by_devpath
In-Reply-To: <20170718072916.24275-1-mwilck@suse.com>
References: <20170718072916.24275-1-mwilck@suse.com>
Message-ID: <20170718072916.24275-3-mwilck@suse.com>

This function is broken. Not all devices that matter for multipathd
follow the block/$DEVICE/$PARTITION convention (example: NVME)

Signed-off-by: Martin Wilck <mwilck at suse.com>
Reviewed-by: Hannes Reinecke <hare at suse.de>
Acked-by: Benjamin Marzinski <bmarzins at redhat.com>
Reviewed-by: "Schremmer, Steven" <Steve.Schremmer at netapp.com>
Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 libmultipath/uevent.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/libmultipath/uevent.c b/libmultipath/uevent.c
index 4fbd1dfb..b688ca03 100644
--- a/libmultipath/uevent.c
+++ b/libmultipath/uevent.c
@@ -143,36 +143,11 @@ uevent_need_merge(void)
 	return need_merge;
 }
 
-static bool
-uevent_can_discard_by_devpath(const char *devpath)
-{
-	static const char BLOCK[] = "/block/";
-	const char *tmp = strstr(devpath, BLOCK);
-
-	if (tmp == NULL) {
-		condlog(4, "no /block/ in '%s'", devpath);
-		return true;
-	}
-	tmp += sizeof(BLOCK) - 1;
-	if (*tmp == '\0')
-		/* just ".../block/" - discard */
-		return true;
-	/*
-	 * If there are more path elements after ".../block/xyz",
-	 * it's a partition - discard it; but don't discard ".../block/sda/".
-	 */
-	tmp = strchr(tmp, '/');
-	return tmp != NULL && *(tmp + 1) != '\0';
-}
-
 bool
 uevent_can_discard(struct uevent *uev)
 {
 	struct config * conf;
 
-	if (uevent_can_discard_by_devpath(uev->devpath))
-		return true;
-
 	/*
 	 * do not filter dm devices by devnode
 	 */
-- 
2.13.2
