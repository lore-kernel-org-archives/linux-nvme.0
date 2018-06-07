From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Jun 2018 16:20:40 +0300
Subject: [PATCH 4/4] nvme: start ANATT timer on out-of-order state changes
In-Reply-To: <20180607073556.39050-5-hare@suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-5-hare@suse.de>
Message-ID: <0d687603-cd79-c848-6cc1-8b6834a55c6f@grimberg.me>



On 06/07/2018 10:35 AM, Hannes Reinecke wrote:
> If I/O is terminated due to an invalid ANA state we should be starting
> the ANATT timer as we really should have received an ANA AEN signalling
> the state change.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/multipath.c | 36 +++++++++++++++++++++++++++++-------
>   1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7a37f5959ad4..7f34ae260ca9 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -49,7 +49,10 @@ static void nvme_update_ana_state(struct nvme_ns *ns, enum nvme_ana_state state)
>   void nvme_failover_req(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
> +	struct device *dev = disk_to_dev(ns->disk);
>   	unsigned long flags;
> +	enum nvme_ana_state ana_state;
> +	bool ana_state_changed = false;
>   
>   	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>   	blk_steal_bios(&ns->head->requeue_list, req);
> @@ -60,26 +63,45 @@ void nvme_failover_req(struct request *req)
>   	 * Reset the controller for any non-ANA error as we don't know what
>   	 * caused the error:
>   	 */
> +	ana_state = READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
>   	switch (nvme_req(req)->status & 0x7ff) {
>   	case NVME_SC_ANA_TRANSITION:
> -		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
> -		if (!timer_pending(&ns->anatt_timer)) {
> -			ns->anatt_timer.expires =
> -				ns->ctrl->anatt * HZ + jiffies;
> -			add_timer(&ns->anatt_timer);

Wasn't this added in the previous patch? its a bit confusing... can you
re-arrange the patches differently? maybe squash?
