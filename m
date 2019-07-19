From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Jul 2019 17:25:14 -0700
Subject: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
In-Reply-To: <20190718225132.5865-2-logang@deltatee.com>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
Message-ID: <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>


> With multipath enabled, nvme_scan_work() can read from the
> device (through nvme_mpath_add_disk()). However, with fabrics,
> once ctrl->state is set to NVME_CTRL_DELETING, the reads will hang
> (see nvmf_check_ready()).
> 
> After setting the state to deleting, nvme_remove_namespaces() will
> hang waiting for scan_work to flush and these tasks will hang.
> 
> To fix this, ensure we take scan_lock before changing the ctrl-state.
> Also, ensure the state is checked while the lock is held
> in nvme_scan_lock_work().

That's a big hammer...

But this is I/O that we cannot have queued until we have a path..

I would rather have nvme_remove_namespaces() requeue all I/Os for
namespaces that serve as the current_path and have the make_request
routine to fail I/O if all controllers are deleting as well.

Would something like [1] (untested) make sense instead?


> +	mutex_lock(&ctrl->scan_lock);
> +
>   	if (ctrl->state != NVME_CTRL_LIVE)
>   		return;

unlock

>   
> @@ -3547,7 +3554,6 @@ static void nvme_scan_work(struct work_struct *work)
>   	if (nvme_identify_ctrl(ctrl, &id))
>   		return;

unlock


[1]:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76cd3dd8736a..627f5871858d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3576,6 +3576,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
         struct nvme_ns *ns, *next;
         LIST_HEAD(ns_list);

+       mutex_lock(&ctrl->scan_lock);
+       list_for_each_entry(ns, &ctrl->namespaces, list)
+               nvme_mpath_clear_current_path(ns);
+       mutex_lock(&ctrl->scan_lock);
+
         /* prevent racing with ns scanning */
         flush_work(&ctrl->scan_work);

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a9a927677970..da1731266788 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -231,6 +231,24 @@ inline struct nvme_ns *nvme_find_path(struct 
nvme_ns_head *head)
         return ns;
  }

+static bool nvme_available_path(struct nvme_ns_head *head)
+{
+       struct nvme_ns *ns;
+
+       list_for_each_entry_rcu(ns, &head->list, siblings) {
+               switch (ns->ctrl->state) {
+               case NVME_CTRL_LIVE:
+               case NVME_CTRL_RESETTING:
+               case NVME_CTRL_CONNECTING:
+                       /* fallthru */
+                       return true;
+               default:
+                       break;
+               }
+       }
+       return false;
+}
+
  static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
                 struct bio *bio)
  {
@@ -257,14 +275,14 @@ static blk_qc_t nvme_ns_head_make_request(struct 
request_queue *q,
                                       disk_devt(ns->head->disk),
                                       bio->bi_iter.bi_sector);
                 ret = direct_make_request(bio);
-       } else if (!list_empty_careful(&head->list)) {
-               dev_warn_ratelimited(dev, "no path available - requeuing 
I/O\n");
+       } else if (nvme_available_path(head)) {
+               dev_warn_ratelimited(dev, "no usable path - requeuing 
I/O\n");

                 spin_lock_irq(&head->requeue_lock);
                 bio_list_add(&head->requeue_list, bio);
                 spin_unlock_irq(&head->requeue_lock);
         } else {
-               dev_warn_ratelimited(dev, "no path - failing I/O\n");
+               dev_warn_ratelimited(dev, "no available path - failing 
I/O\n");

                 bio->bi_status = BLK_STS_IOERR;
                 bio_endio(bio);
--
