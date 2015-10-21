From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 21 Oct 2015 13:20:02 -0400
Subject: [PATCH v3 07/12] md: suspend i/o during runtime
 blk_integrity_unregister
In-Reply-To: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20151021172001.6456.95293.stgit@dwillia2-desk3.amr.corp.intel.com>

Synchronize pending i/o against a change in the integrity profile to
avoid the possibility of spurious integrity errors.  Given linear_add()
is suspending the mddev before manipulating the mddev, do the same for
the other personalities.

Acked-by: NeilBrown <neilb at suse.com>
Signed-off-by: Dan Williams <dan.j.williams at intel.com>
---
 drivers/md/md.c        |    1 +
 drivers/md/multipath.c |    2 ++
 drivers/md/raid1.c     |    2 ++
 drivers/md/raid10.c    |    2 ++
 4 files changed, 7 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7d07caceb349..714aa92db174 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1994,6 +1994,7 @@ void md_integrity_add_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (bi_rdev && blk_integrity_compare(mddev->gendisk,
 					     rdev->bdev->bd_disk) >= 0)
 		return;
+	WARN_ON_ONCE(!mddev->suspended);
 	printk(KERN_NOTICE "disabling data integrity on %s\n", mdname(mddev));
 	blk_integrity_unregister(mddev->gendisk);
 }
diff --git a/drivers/md/multipath.c b/drivers/md/multipath.c
index d132f06afdd1..7331a80d89f1 100644
--- a/drivers/md/multipath.c
+++ b/drivers/md/multipath.c
@@ -264,7 +264,9 @@ static int multipath_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			spin_unlock_irq(&conf->device_lock);
 			rcu_assign_pointer(p->rdev, rdev);
 			err = 0;
+			mddev_suspend(mddev);
 			md_integrity_add_rdev(rdev, mddev);
+			mddev_resume(mddev);
 			break;
 		}
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 049df6c4a8cc..a881b111fa35 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1621,7 +1621,9 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			break;
 		}
 	}
+	mddev_suspend(mddev);
 	md_integrity_add_rdev(rdev, mddev);
+	mddev_resume(mddev);
 	if (mddev->queue && blk_queue_discard(bdev_get_queue(rdev->bdev)))
 		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, mddev->queue);
 	print_conf(conf);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7c99a4037715..6f0ec107996a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1736,7 +1736,9 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		rcu_assign_pointer(p->rdev, rdev);
 		break;
 	}
+	mddev_suspend(mddev);
 	md_integrity_add_rdev(rdev, mddev);
+	mddev_resume(mddev);
 	if (mddev->queue && blk_queue_discard(bdev_get_queue(rdev->bdev)))
 		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, mddev->queue);
 
