From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 16 May 2019 11:13:35 +0800
Subject: [PATCH 3/6] nvme-pci: Unblock reset_work on IO failure
In-Reply-To: <20190515163625.21776-3-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-3-keith.busch@intel.com>
Message-ID: <20190516031333.GC16342@ming.t460p>

On Wed, May 15, 2019@10:36:22AM -0600, Keith Busch wrote:
> The reset_work waits in the connecting state for previously queued IO to
> complete before setting the controller to live. If these requests time
> out, we won't be able to restart the controller because the reset_work
> is already running, and any requeued IOs will block reset_work forever.
> 
> When connecting, shutdown the controller to flush all entered requests
> to a failed completion if a timeout occurs, and ensure the controller
> can't transition to the live state after we've unblocked it. The driver
> will instead unbind from the controller if we can't complete IO during
> initialization.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c72755311ffa..8df176ffcbc1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1257,7 +1257,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	struct nvme_dev *dev = nvmeq->dev;
>  	struct request *abort_req;
>  	struct nvme_command cmd;
> -	bool shutdown = false;
>  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
>  	/* If PCI error recovery process is happening, we cannot reset or
> @@ -1294,14 +1293,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	 * shutdown, so we return BLK_EH_DONE.
>  	 */
>  	switch (dev->ctrl.state) {
> -	case NVME_CTRL_DELETING:
> -		shutdown = true;
> -		/* fall through */
>  	case NVME_CTRL_CONNECTING:
> +		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> +		/* fall through */
> +	case NVME_CTRL_DELETING:
>  		dev_warn_ratelimited(dev->ctrl.device,
>  			 "I/O %d QID %d timeout, disable controller\n",
>  			 req->tag, nvmeq->qid);
> -		nvme_dev_disable(dev, shutdown);
> +		nvme_dev_disable(dev, true);
>  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>  		return BLK_EH_DONE;
>  	case NVME_CTRL_RESETTING:

Then the controller is dead, and can't work any more together with data
loss. I guess this way is too violent from user view.


Thanks,
Ming
