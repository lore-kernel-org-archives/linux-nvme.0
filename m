From: famz@redhat.com (Fam Zheng)
Date: Thu, 30 Jun 2016 09:59:48 +0800
Subject: [PATCH v2 07/12] pktcdvd: Generate uevent after attribute available
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
Message-ID: <20160630015953.6888-8-famz@redhat.com>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 drivers/block/pktcdvd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 00928406..a4e6bb7 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2785,11 +2785,13 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	disk->events = pd->bdev->bd_disk->events;
 	disk->async_events = pd->bdev->bd_disk->async_events;
 
-	add_disk(disk, true);
+	add_disk(disk, false);
 
 	pkt_sysfs_dev_new(pd);
 	pkt_debugfs_dev_new(pd);
 
+	disk_gen_uevents(disk);
+
 	pkt_devs[idx] = pd;
 	if (pkt_dev)
 		*pkt_dev = pd->pkt_dev;
-- 
2.9.0
