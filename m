From: mwilck@suse.com (Martin Wilck)
Date: Fri, 14 Jul 2017 13:32:06 +0200
Subject: [PATCH 1/4] libmultipath: get_udev_uid: make sure pp->wwid is
 0-terminated
In-Reply-To: <20170714113209.17177-1-mwilck@suse.com>
References: <20170714113209.17177-1-mwilck@suse.com>
Message-ID: <20170714113209.17177-2-mwilck@suse.com>

If the first WWID_LEN bytes of the uuid_attribute do not contain
a 0 byte, pp->wwid may end up not properly terminated. Fix it.

Signed-off-by: Martin Wilck <mwilck at suse.com>
---
 libmultipath/discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libmultipath/discovery.c b/libmultipath/discovery.c
index 663c8eaa..9951af84 100644
--- a/libmultipath/discovery.c
+++ b/libmultipath/discovery.c
@@ -1615,6 +1615,7 @@ get_udev_uid(struct path * pp, char *uid_attribute, struct udev_device *udev)
 			len = strlen(value);
 		}
 		strncpy(pp->wwid, value, len);
+		pp->wwid[WWID_SIZE - 1] = '\0';
 	} else {
 		condlog(3, "%s: no %s attribute", pp->dev,
 			uid_attribute);
-- 
2.13.2
