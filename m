From: james.smart@broadcom.com (James Smart)
Date: Mon, 5 Nov 2018 12:04:18 -0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <20181105115734.15515-1-ming.lei@redhat.com>
References: <20181105115734.15515-1-ming.lei@redhat.com>
Message-ID: <782deffe-eb72-3550-2d69-980604609fd5@broadcom.com>

On 11/5/2018 3:57 AM, Ming Lei wrote:
> When scan work is in-progress, any controller error may trigger
> reset, now fc, rdma and loop host tries to flush scan work
> inside reset context.
>
> This way can cause deadlock easily because any IO during controler
> recovery(reset) can't be completed until the recovery is done.
>
> This patch tries to address the deadlock issue by not flushing
> scan work inside reset context. Actually not see obvious reason
> to do that:
>
> - once reset is done, a new scan will be scheduled.
> - PCI NVMe doesn't do that way
>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>   drivers/nvme/host/core.c   | 4 ++--
>   drivers/nvme/host/fc.c     | 2 +-
>   drivers/nvme/host/nvme.h   | 2 +-
>   drivers/nvme/host/pci.c    | 2 +-
>   drivers/nvme/host/rdma.c   | 2 +-
>   drivers/nvme/target/loop.c | 2 +-
>   6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2e65be8b1387..fbbb6bd8fbc5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -161,7 +161,7 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
>   		 "Removing ctrl: NQN \"%s\"\n", ctrl->opts->subsysnqn);
>   
>   	flush_work(&ctrl->reset_work);
> -	nvme_stop_ctrl(ctrl);
> +	nvme_stop_ctrl(ctrl, true);
>   	nvme_remove_namespaces(ctrl);
>   	ctrl->ops->delete_ctrl(ctrl);
>   	nvme_uninit_ctrl(ctrl);
> @@ -3469,7 +3469,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>   }
>   EXPORT_SYMBOL_GPL(nvme_complete_async_event);
>   
> -void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> +void nvme_stop_ctrl(struct nvme_ctrl *ctrl, bool flush_scan)
>   {
>   	nvme_mpath_stop(ctrl);
>   	nvme_stop_keep_alive(ctrl);
>

Keith: This was missing a snippet in nvme_stop_ctrl() for

 ?-????????????? flush_work(&ctrl->scan_work);
 ?+???????????? if (flush_scan)
 ?+ ????????????????? flush_work(&ctrl->scan_work);

I also believe Ming's patch isn't enough.? The issue for the transports 
are several of the flush cases require an io to complete to finish 
flushing - not just scan_work.?? nvme_mpath_stop() syncs with 
ctrl->ana_work, which may be waiting for an ana log to complete.? 
fw_act_queues() may be in the midst of polling the CSTS bit register or 
doing a fw_slot log read, or a stop_ctrl() routine for the transport may 
be in the middle of a start_ctrl call.

Give the transport may be at a point where it's lost connectivity to the 
controller (never really a case for pci unless you consider hot unplug), 
before calling ctlr stop, the transport has to terminate/return 
outstanding io and stop further io from being accepted (usually by 
marking the queue as not connected).

rdma seems to pretty much do the right thing for it's error handling 
path - where it schedules the err_work handler to do this. But that's 
missing from the reset controller path (and is nooped if reset is in 
progress and stuck in one of these flushes when a timeout occurs).

fc resets the device, thus calls the flush routines, when it resets or 
has an error. So it never gets to call delete_association to 
teardown/mark things unconnected befpre waiting on the flushes.

I think we need to have the reset_work routines call the routine that 
deletes/tearsdown before it calls nvme_stop_ctrl().? These routines will 
likely call nvme_stop_keep_alive right before doing so as well.

-- james
