From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 13 Apr 2019 16:29:55 +0800
Subject: [PATCHv2 RFC] nvme: use nvme_set_queue_dying() during namespace
 rescanning
In-Reply-To: <20190403231221.127008-1-hare@suse.de>
References: <20190403231221.127008-1-hare@suse.de>
Message-ID: <20190413082954.GD9108@ming.t460p>

On Thu, Apr 04, 2019@01:12:21AM +0200, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare at suse.com>
> 
> There is a race condition between namespace rescanning and controller
> reset; during controller reset all namespaces are quiesed vie
> nams_stop_ctrl(), and after reset all namespaces are unquiesced
> again.
> When namespace scanning was active by the time controller reset was
> triggered the rescan code will call nvme_ns_remove(), which then will
> cause a kernel crash in nvme_start_ctrl() as it'll trip over
> uninitialized namespaces.
> 
> This patch calls nvme_set_queue_dying() during namespace rescan,
> which will already unquiesce the queue. Hence we can skip all namespaces
> with the 'DEAD' flag during unquiesce in nvme_start_ctrl() and eliminate
> this issue.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 23000a368e1f..21aa5c516d2a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3359,7 +3359,7 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	ns = nvme_find_get_ns(ctrl, nsid);
>  	if (ns) {
>  		if (ns->disk && revalidate_disk(ns->disk))
> -			nvme_ns_remove(ns);
> +			nvme_set_queue_dying(ns);
>  		nvme_put_ns(ns);
>  	} else
>  		nvme_alloc_ns(ctrl, nsid);
> @@ -3409,7 +3409,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
>  			while (++prev < nsid) {
>  				ns = nvme_find_get_ns(ctrl, prev);
>  				if (ns) {
> -					nvme_ns_remove(ns);
> +					nvme_set_queue_dying(ns);
>  					nvme_put_ns(ns);
>  				}
>  			}
> @@ -3871,8 +3871,11 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
>  	struct nvme_ns *ns;
>  
>  	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (test_bit(NVME_NS_DEAD, &ns->flags))
> +			continue;
>  		blk_mq_quiesce_queue(ns->queue);
> +	}
>  	up_read(&ctrl->namespaces_rwsem);
>  }
>  EXPORT_SYMBOL_GPL(nvme_stop_queues);
> @@ -3882,8 +3885,11 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>  	struct nvme_ns *ns;
>  
>  	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (test_bit(NVME_NS_DEAD, &ns->flags))
> +			continue;
>  		blk_mq_unquiesce_queue(ns->queue);
> +	}
>  	up_read(&ctrl->namespaces_rwsem);
>  }
>  EXPORT_SYMBOL_GPL(nvme_start_queues);
> -- 
> 2.16.4

Another candidate is to hold ns's refcount and switch to remove
the ns from 'ctrl->namespaces' in nvme_free_ns() via the following
patch[1]. Together with patch "blk-mq: free hw queue's resource in
hctx's release handler" in the following link:

https://lore.kernel.org/linux-block/20190413071829.GB9108 at ming.t460p/T/#m41c04517a37cbc1b4c61357f8cb52cd3cbf31f1b

[1] fix race between nvme scan and reset

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ddb943395118..12507b223584 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -402,6 +402,10 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	down_write(&ns->ctrl->namespaces_rwsem);
+	list_del_init(&ns->list);
+	up_write(&ns->ctrl->namespaces_rwsem);
+
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
 
@@ -3166,6 +3170,29 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
+void nvme_get_all_ns(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		if (kref_get_unless_zero(&ns->kref))
+			continue;
+	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_get_all_ns);
+
+void nvme_put_all_ns(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		nvme_put_ns(ns);
+	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_put_all_ns);
+
 static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
@@ -3329,10 +3356,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_mpath_clear_current_path(ns);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
-
 	synchronize_srcu(&ns->head->srcu);
 	nvme_mpath_check_last_path(ns);
 	nvme_put_ns(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 527d64545023..f8f2a012c3ba 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -430,6 +430,9 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
 
+void nvme_get_all_ns(struct nvme_ctrl *ctrl);
+void nvme_put_all_ns(struct nvme_ctrl *ctrl);
+
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1eecde6b853..0d4fea14ccdc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2496,6 +2496,8 @@ static void nvme_reset_work(struct work_struct *work)
 	int result = -ENODEV;
 	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
 
+	nvme_get_all_ns(&dev->ctrl);
+
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
 		goto out;
 
@@ -2603,6 +2605,7 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
  out:
+	nvme_put_all_ns(&dev->ctrl);
 	nvme_remove_dead_ctrl(dev, result);
 }
 
Thanks,
Ming
