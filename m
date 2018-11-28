From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Wed, 28 Nov 2018 06:38:17 -0200
Subject: [PATCH 2/2] nvme: create slaves/holder entries for multipath
 devices
In-Reply-To: <20181116130805.16225-3-hch@lst.de>
References: <20181116130805.16225-1-hch@lst.de>
 <20181116130805.16225-3-hch@lst.de>
Message-ID: <20181128083816.GB4269@calabresa>

On Fri, Nov 16, 2018@02:08:05PM +0100, Christoph Hellwig wrote:
> This allows tools like distro installers easily track the relationship.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c      |  5 +++--
>  drivers/nvme/host/multipath.c | 12 ++++++++++--
>  drivers/nvme/host/nvme.h      | 12 ++++++++----
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f172d63db2b5..ff0ce5ef1040 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -371,7 +371,7 @@ static void nvme_free_ns_head(struct kref *ref)
>  	struct nvme_ns_head *head =
>  		container_of(ref, struct nvme_ns_head, ref);
>  
> -	nvme_mpath_remove_disk(head);
> +	nvme_mpath_remove_nshead(head);
>  	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>  	list_del_init(&head->entry);
>  	cleanup_srcu_struct_quiesced(&head->srcu);
> @@ -3118,7 +3118,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  
>  	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
>  
> -	nvme_mpath_add_disk(ns, id);
> +	nvme_mpath_add_ns(ns, id);
>  	nvme_fault_inject_init(ns);
>  	kfree(id);
>  
> @@ -3142,6 +3142,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	nvme_fault_inject_fini(ns);
>  	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
> +		nvme_mpath_remove_ns(ns);
>  		del_gendisk(ns->disk);
>  		blk_cleanup_queue(ns->queue);
>  		if (blk_get_integrity(ns->disk))
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index b82b0d3ca39a..457d5ad7cfe9 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -515,7 +515,7 @@ static int nvme_set_ns_ana_state(struct nvme_ctrl *ctrl,
>  	return 0;
>  }
>  
> -void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
> +void nvme_mpath_add_ns(struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
>  	if (nvme_ctrl_use_ana(ns->ctrl)) {
>  		mutex_lock(&ns->ctrl->ana_lock);
> @@ -528,9 +528,17 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>  		nvme_mpath_set_live(ns);
>  		mutex_unlock(&ns->head->lock);
>  	}
> +
> +	bd_link_disk_holder(&ns->disk->part0, ns->head->disk);
> +}
> +

That will oops because there is no test for ns->head->disk.

I will send a followup that includes your two patches, fixing up this one, plus
another two because that is simply reverting the revert of Hanne's patch. Which
means it still has the lsblk bug.

Then, we have two options: do not use GENHD_FL_HIDDEN on multipath nvme disks,
or expose devt for those disks. I am sending a patch for the second option.

Thanks.
Cascardo.

> +void nvme_mpath_remove_ns(struct nvme_ns *ns)
> +{
> +	if (ns->head->disk)
> +		bd_unlink_disk_holder(&ns->disk->part0, ns->head->disk);
>  }
>  
> -void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> +void nvme_mpath_remove_nshead(struct nvme_ns_head *head)
>  {
>  	if (!head->disk)
>  		return;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 32a1f1cfdfb4..e20353bbf6a8 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -470,8 +470,9 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>  void nvme_failover_req(struct request *req);
>  void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
>  int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
> -void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
> -void nvme_mpath_remove_disk(struct nvme_ns_head *head);
> +void nvme_mpath_add_ns(struct nvme_ns *ns, struct nvme_id_ns *id);
> +void nvme_mpath_remove_ns(struct nvme_ns *ns);
> +void nvme_mpath_remove_nshead(struct nvme_ns_head *head);
>  int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
>  void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
>  void nvme_mpath_stop(struct nvme_ctrl *ctrl);
> @@ -515,11 +516,14 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
>  {
>  	return 0;
>  }
> -static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
> +static inline void nvme_mpath_add_ns(struct nvme_ns *ns,
>  		struct nvme_id_ns *id)
>  {
>  }
> -static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> +static inline void nvme_mpath_remove_ns(struct nvme_ns *ns)
> +{
> +}
> +static inline void nvme_mpath_remove_nshead(struct nvme_ns_head *head)
>  {
>  }
>  static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
> -- 
> 2.19.1
> 
