From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 30 Mar 2017 10:13:38 +0300
Subject: [PATCH 1/1] nvme: don't ignore tagset allocation failures
In-Reply-To: <0d85bb44-eb90-8712-1fcd-2f0885649cdf@grimberg.me>
References: <1490778212-11007-1-git-send-email-maxg@mellanox.com>
 <a7db55a8-d40a-81e9-332e-2bd0306687bc@grimberg.me>
 <20170329173241.GC20181@localhost.localdomain>
 <fb263c4e-0403-c39c-1c88-be47d846c2b6@grimberg.me>
 <20170329231029.GE20181@localhost.localdomain>
 <0d85bb44-eb90-8712-1fcd-2f0885649cdf@grimberg.me>
Message-ID: <6e05fb1e-edf2-2b0d-b680-7fddf1e3ecf1@mellanox.com>



On 3/30/2017 8:47 AM, Sagi Grimberg wrote:
>
>>>> Not having a tagset doesn't mean we can't go live; it just means we
>>>> can't
>>>> do IO, but the admin handle is still up for device management.
>>>
>>> So don't queue ns scanning...
>>
>> And what about the sysfs rescan or namespace notify async event? We have
>> to fence those off too, so doing it in one place sounds better than
>> three.
>
> True, but it still feels wrong that the pci driver fails tagset
> allocation and continues to scan namespaces as if nothing happened, then
> queue namespaces checks for the existence of a tagset... It looks
> awkward...
>
> Why is the controller moving to LIVE anyway? Obviously something went
> wrong, which is either a SW BUG (EINVAL), or a temporary failure that
> needs to be retried again (ENOMEM). So I think the proper solution would
> be to either retry again later for transient errors and for
> non-transient errors simply log the error remove the controller (its
> not a device issue so no point in keeping the controller around for
> error log query).
>
> Thoughts?


hi Sagi,

what do you think about this solution that we don't keep the ctrl:

The nvme_dev_add() function silently ignores failures.
In case blk_mq_alloc_tag_set fails, we hit NULL deref while
calling blk_mq_init_queue during nvme_alloc_ns with tagset == NULL.
Instead we'll remove the dead ctrl as it can't be functional anymore.
Also remove old and wrong comment.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

---
  drivers/nvme/host/pci.c |   19 +++++++++----------
  1 files changed, 9 insertions(+), 10 deletions(-)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3faefab..3964e1d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1545,14 +1545,10 @@ static void nvme_disable_io_queues(struct 
nvme_dev *dev, int queues)
  	}
  }

-/*
- * Return: error value if an error occurred setting up the queues or 
calling
- * Identify Device.  0 if these succeeded, even if adding some of the
- * namespaces failed.  At the moment, these failures are silent.  TBD which
- * failures should be reported.
- */
  static int nvme_dev_add(struct nvme_dev *dev)
  {
+	int ret = 0;
+
  	if (!dev->ctrl.tagset) {
  		dev->tagset.ops = &nvme_mq_ops;
  		dev->tagset.nr_hw_queues = dev->online_queues - 1;
@@ -1564,8 +1560,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
  		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
  		dev->tagset.driver_data = dev;

-		if (blk_mq_alloc_tag_set(&dev->tagset))
-			return 0;
+		ret = blk_mq_alloc_tag_set(&dev->tagset);
+		if (ret)
+			return ret;
  		dev->ctrl.tagset = &dev->tagset;
  	} else {
  		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
@@ -1574,7 +1571,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
  		nvme_free_queues(dev, dev->online_queues);
  	}

-	return 0;
+	return ret;
  }

  static int nvme_pci_enable(struct nvme_dev *dev)
@@ -1811,7 +1808,9 @@ static void nvme_reset_work(struct work_struct *work)
  		nvme_remove_namespaces(&dev->ctrl);
  	} else {
  		nvme_start_queues(&dev->ctrl);
-		nvme_dev_add(dev);
+		result = nvme_dev_add(dev);
+		if (result)
+			goto out;
  	}

  	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
-- 
