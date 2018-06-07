From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Jun 2018 16:16:09 +0300
Subject: [PATCH 3/4] nvme: ANA transition timeout handling
In-Reply-To: <20180607073556.39050-4-hare@suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-4-hare@suse.de>
Message-ID: <ffb79ccc-3259-ca9a-dc71-309baca1e10d@grimberg.me>



On 06/07/2018 10:35 AM, Hannes Reinecke wrote:
> Add a timer for tracking ANA transition timeout, and reset the
> controller once the timeout expires.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/core.c      |  3 +++
>   drivers/nvme/host/multipath.c | 34 ++++++++++++++++++++++++++++------
>   drivers/nvme/host/nvme.h      |  6 ++++++
>   3 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e62de51209b2..3b578ae62cb5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2378,6 +2378,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	ctrl->kas = le16_to_cpu(id->kas);
>   	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>   	ctrl->anacap = id->anacap;
> +	ctrl->anatt = id->anatt;
>   	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
>   	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
>   
> @@ -3025,6 +3026,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
>   	ns->queue->queuedata = ns;
>   	ns->ctrl = ctrl;
> +	timer_setup(&ns->anatt_timer, nvme_anatt_timedout, 0);
>   
>   	kref_init(&ns->kref);
>   	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
> @@ -3113,6 +3115,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   			blk_integrity_unregister(ns->disk);
>   	}
>   
> +	del_timer_sync(&ns->anatt_timer);
>   	mutex_lock(&ns->ctrl->subsys->lock);
>   	nvme_mpath_clear_current_path(ns);
>   	list_del_rcu(&ns->siblings);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d30229a21c97..7a37f5959ad4 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -62,13 +62,12 @@ void nvme_failover_req(struct request *req)
>   	 */
>   	switch (nvme_req(req)->status & 0x7ff) {
>   	case NVME_SC_ANA_TRANSITION:
> -		/*
> -		 * XXX: We should verify the controller doesn't die on during
> -		 * the transition.  But that means we per-group timeout from
> -		 * when we first hit the change state, so this won't be
> -		 * entirely trivial..
> -		 */
>   		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
> +		if (!timer_pending(&ns->anatt_timer)) {
> +			ns->anatt_timer.expires =
> +				ns->ctrl->anatt * HZ + jiffies;
> +			add_timer(&ns->anatt_timer);
> +		}

Shouldn't this del and re-add the timer if its pending?

>   		break;
>   	case NVME_SC_ANA_PERSISTENT_LOSS:
>   		nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
> @@ -390,11 +389,34 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
>   static void nvme_ana_work(struct work_struct *work)
>   {
>   	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ana_work);
> +	struct nvme_ns *ns;
>   
>   	nvme_process_ana_log(ctrl, false);
> +	down_write(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		enum nvme_ana_state state = nvme_ns_ana_state(ns);
> +
> +		if (timer_pending(&ns->anatt_timer) &&
> +		    state != NVME_ANA_CHANGE)
> +			del_timer_sync(&ns->anatt_timer);
> +		if (!timer_pending(&ns->anatt_timer) &&
> +		    state == NVME_ANA_CHANGE) {
> +			ns->anatt_timer.expires =
> +				ns->ctrl->anatt * HZ + jiffies;
> +			add_timer(&ns->anatt_timer);
> +		}

Called from couple of sites, can move to helper?
