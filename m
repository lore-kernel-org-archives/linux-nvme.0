From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Apr 2018 08:45:25 -0600
Subject: [PATCH] nvme: fix the suspicious RCU usage warning in
 nvme_mpath_clear_current_path
In-Reply-To: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180418144524.GL11513@localhost.localdomain>

On Wed, Apr 18, 2018@03:32:47PM +0800, Jianchao Wang wrote:
> With lockdep enabled, when trigger nvme_remove, suspicious RCU
> usage warning will be printed out.
> Fix it with adding srcu_read_lock/unlock in it.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
>  drivers/nvme/host/nvme.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 061fecf..d326c23 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -446,9 +446,14 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head);
>  static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
>  {
>  	struct nvme_ns_head *head = ns->head;
> +	int srcu_idx;
>  
> -	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
> -		rcu_assign_pointer(head->current_path, NULL);
> +	if (head) {
> +		srcu_idx = srcu_read_lock(&head->srcu);
> +		if (ns == srcu_dereference(head->current_path, &head->srcu))
> +			rcu_assign_pointer(head->current_path, NULL);
> +		srcu_read_unlock(&head->srcu, srcu_idx);
> +	}
>  }
>  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);

Nothing against this patch. This just doesn't look correct even from
before since nvme_find_path can set head->current_path right back to
this namespace that we're trying to clear.

Christoph, am I missing something here or does this need additional
checks/synchronization?
