From: gregkh@linuxfoundation.org (gregkh@linuxfoundation.org)
Date: Thu, 15 Feb 2018 15:38:27 +0100
Subject: Patch "nvme: Fix managing degraded controllers" has been added to the
 4.4-stable tree
In-Reply-To: <20180213161936.GE20962@localhost.localdomain>
Message-ID: <151870550717658@kroah.com>


This is a note to let you know that I've just added the patch titled

    nvme: Fix managing degraded controllers

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     nvme-fix-managing-degraded-controllers.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable at vger.kernel.org> know about it.


>From keith.busch at intel.com  Thu Feb 15 15:28:13 2018
From: Keith Busch <keith.busch@intel.com>
Date: Tue, 13 Feb 2018 09:19:37 -0700
Subject: nvme: Fix managing degraded controllers
To: Greg Kroah-Hartman <gregkh at linuxfoundation.org>
Cc: Linux NVMe <linux-nvme at lists.infradead.org>, stable at vger.kernel.org
Message-ID: <20180213161936.GE20962 at localhost.localdomain>
Content-Disposition: inline

From: Keith Busch <keith.busch@intel.com>

commit 5bae7f73d378a986 upstream

Upstream is a near rewrite of the async nvme probe that ultimately didn't
even cleanly merge in 4.5. This patch is a much smaller change targeted
to the regression introduced in 4.4.

If a controller is in a degraded mode that needs admin assistence to
recover, we need to leave the controller running. We just want to disable
namespace access without shuting the controller down.

Fixes: 3cf519b5a8d4("nvme: merge nvme_dev_start, nvme_dev_resume and nvme_async_probe")

Signed-off-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh at linuxfoundation.org>

---
 drivers/nvme/host/pci.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2976,10 +2976,16 @@ static void nvme_dev_shutdown(struct nvm
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-static void nvme_dev_remove(struct nvme_dev *dev)
+static void nvme_remove_namespaces(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
 
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
+		nvme_ns_remove(ns);
+}
+
+static void nvme_dev_remove(struct nvme_dev *dev)
+{
 	if (nvme_io_incapable(dev)) {
 		/*
 		 * If the device is not capable of IO (surprise hot-removal,
@@ -2989,8 +2995,7 @@ static void nvme_dev_remove(struct nvme_
 		 */
 		nvme_dev_shutdown(dev);
 	}
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
-		nvme_ns_remove(ns);
+	nvme_remove_namespaces(dev);
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
@@ -3174,7 +3179,7 @@ static void nvme_probe_work(struct work_
 	 */
 	if (dev->online_queues < 2) {
 		dev_warn(dev->dev, "IO queues not created\n");
-		nvme_dev_remove(dev);
+		nvme_remove_namespaces(dev);
 	} else {
 		nvme_unfreeze_queues(dev);
 		nvme_dev_add(dev);


Patches currently in stable-queue which might be from keith.busch at intel.com are

queue-4.4/nvme-fix-managing-degraded-controllers.patch
