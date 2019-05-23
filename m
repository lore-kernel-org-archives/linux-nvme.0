From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 23 May 2019 18:19:54 +0800
Subject: [PATCH 2/2] nvme: reset request timeouts during fw activation
In-Reply-To: <20190522174812.5597-3-keith.busch@intel.com>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190522174812.5597-3-keith.busch@intel.com>
Message-ID: <20190523101953.GA18805@ming.t460p>

On Wed, May 22, 2019@11:48:12AM -0600, Keith Busch wrote:
> The nvme controller may pause command processing during firmware
> activation. The driver will quiesce queues during this time, but commands
> dispatched prior to the notification will not be processed until the
> hardware completes this activation.
> 
> We do not want those requests to time out while the hardware is in
> this paused state as we don't expect those commands to complete during
> this time, and that handling will interfere with the firmware activation
> process.
> 
> In addition to quiescing the queues, halt timeout detection during the
> paused state and reset the dispatched request deadlines when the hardware
> exists that state. This action applies to IO and admin queues.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1b7c2afd84cb..37a9a66ada22 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -89,6 +89,7 @@ static dev_t nvme_chr_devt;
>  static struct class *nvme_class;
>  static struct class *nvme_subsys_class;
>  
> +static void nvme_reset_queues(struct nvme_ctrl *ctrl);
>  static int nvme_revalidate_disk(struct gendisk *disk);
>  static void nvme_put_subsystem(struct nvme_subsystem *subsys);
>  static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> @@ -3605,6 +3606,11 @@ static void nvme_fw_act_work(struct work_struct *work)
>  				msecs_to_jiffies(admin_timeout * 1000);
>  
>  	nvme_stop_queues(ctrl);
> +	nvme_sync_queues(ctrl);
> +
> +	blk_mq_quiesce_queue(ctrl->admin_q);
> +	blk_sync_queue(ctrl->admin_q);

blk_sync_queue() may not halt timeout detection completely since the
timeout work may reset timer again.

Also reset still may come during activating FW, is that a problem?


Thanks,
Ming
