From: mwilck@suse.com (Martin Wilck)
Date: Tue, 18 Jul 2017 09:29:15 +0200
Subject: [PATCH v2 3/4] libmultipath: only listen for uevents with DEVTYPE=disk
In-Reply-To: <20170718072916.24275-1-mwilck@suse.com>
References: <20170718072916.24275-1-mwilck@suse.com>
Message-ID: <20170718072916.24275-4-mwilck@suse.com>

We are only interested in disks anyway. This saves us checking
for devtype in the uevent processing queue, and is more powerful
than the previous test in the dropped function
uevent_can_discard_by_devpath().

Signed-off-by: Martin Wilck <mwilck at suse.com>
Reviewed-by: Hannes Reinecke <hare at suse.de>
Acked-by: Benjamin Marzinski <bmarzins at redhat.com>
Reviewed-by: "Schremmer, Steven" <Steve.Schremmer at netapp.com>
Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 libmultipath/uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmultipath/uevent.c b/libmultipath/uevent.c
index b688ca03..eb44da56 100644
--- a/libmultipath/uevent.c
+++ b/libmultipath/uevent.c
@@ -770,7 +770,7 @@ int uevent_listen(struct udev *udev)
 		goto out;
 	}
 	err = udev_monitor_filter_add_match_subsystem_devtype(monitor, "block",
-							      NULL);
+							      "disk");
 	if (err)
 		condlog(2, "failed to create filter : %s", strerror(-err));
 	err = udev_monitor_enable_receiving(monitor);
-- 
2.13.2
