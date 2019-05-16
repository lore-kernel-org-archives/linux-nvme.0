From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 16 May 2019 11:07:09 +0800
Subject: [PATCH 2/6] nvme-pci: Don't disable on timeout in reset state
In-Reply-To: <20190515163625.21776-2-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-2-keith.busch@intel.com>
Message-ID: <20190516030708.GB16342@ming.t460p>

On Wed, May 15, 2019@10:36:21AM -0600, Keith Busch wrote:
> The driver doesn't dispatch commands that it needs to wait for in the reset
> state anymore. If a timeout occurs in this state, the reset work is
> already disabling the controller, so just reset the request's timer.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d4e442160048..c72755311ffa 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1298,13 +1298,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  		shutdown = true;
>  		/* fall through */
>  	case NVME_CTRL_CONNECTING:
> -	case NVME_CTRL_RESETTING:
>  		dev_warn_ratelimited(dev->ctrl.device,
>  			 "I/O %d QID %d timeout, disable controller\n",
>  			 req->tag, nvmeq->qid);
>  		nvme_dev_disable(dev, shutdown);
>  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>  		return BLK_EH_DONE;
> +	case NVME_CTRL_RESETTING:
> +		return BLK_EH_RESET_TIMER;
>  	default:
>  		break;
>  	}

RESET follows controller shutdown(via nvme_dev_disable()), the only
possible timeout should be on admin requests staggered between shutdown
and changing to NVME_CTRL_CONNECTING, given admin queue isn't frozen.

And the admin queue should be fully workable after it is unquiesced
by nvme_alloc_admin_tags(), so if timeout happens after nvme_alloc_admin_tags(),
I guess these requests should be handled as in NVME_CTRL_CONNECTING.

Another related problem is about handling timeout in NVME_CTRL_CONNECTING, and
the following failure still can be observed:

[ 1078.775969] nvme nvme0: I/O 20 QID 0 timeout, disable controller
[ 1078.791730] nvme nvme0: Identify Controller failed (-4)
[ 1078.792538] nvme nvme0: Removing after probe failure status: -5


Thanks,
Ming
