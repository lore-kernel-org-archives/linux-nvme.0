From: hare@suse.de (Hannes Reinecke)
Date: Sat, 29 Sep 2018 14:13:40 +0200
Subject: [PATCH v2] nvme: call nvme_complete_rq on NVME_MPATH failures
In-Reply-To: <20180927235854.12386-1-jsmart2021@gmail.com>
References: <20180927235854.12386-1-jsmart2021@gmail.com>
Message-ID: <a422e9b3-1fdd-b910-ae3b-0f9194e589c0@suse.de>

On 9/28/18 1:58 AM, James Smart wrote:
> When an io is rejected by nvmf_check_ready() due to validation of
> the controller state, the nvmf_fail_nonready_command() will normally
> return BLK_STS_RESOURCE to requeue and retry. However, if the
> controller is dying or the io is marked for NVME multipath, the io
> is failed so that the controller can terminate or so that the io can
> be issued on a different path. Unfortunately, as this reject point
> is before the transport has accepted the command, blk-mq ends up
> completing the io and never calls nvme_complete_rq(), which is where
> multipath may preserve/re-route the io. The end result is, the device
> user ends up seeing an EIO error.
> 
> Example: single path connectivity, controller is under load, and a
> reset is induced. An i/o is received: a) while the reset state has
> been set but the queues have yet to be stopped; or b) after queues
> are started (at end of reset) but before the reconnect has completed.
> The io finishes with an EIO status.
> 
> This patch makes the following changes:
> - Adds the HOST_PATH_ERROR pathing status from TP4028
> - Modifies the reject point such that it appears to queue successfully,
>   but actually completes the io with the new pathing status and calls
>   nvme_complete_rq().
> - nvme_complete_rq() recognizes the new status, avoids resetting the
>   controller (likely was already done in order to get this new status),
>   and calls the multipather to clear the current path that errored.
>   This allows the next command (retry or new command) to select a new
>   path if there is one.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>  drivers/nvme/host/fabrics.c   | 7 +++++--
>  drivers/nvme/host/multipath.c | 7 +++++++
>  include/linux/nvme.h          | 1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 206d63cb1afc..bcd09d3a44da 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -552,8 +552,11 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
>  	    ctrl->state != NVME_CTRL_DEAD &&
>  	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>  		return BLK_STS_RESOURCE;
> -	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
> -	return BLK_STS_IOERR;
> +
> +	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
> +	blk_mq_start_request(rq);
> +	nvme_complete_rq(rq);
> +	return BLK_STS_OK;
>  }
>  EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
>  
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 5a9562881d4e..b285648c3a7f 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -77,6 +77,13 @@ void nvme_failover_req(struct request *req)
>  			queue_work(nvme_wq, &ns->ctrl->ana_work);
>  		}
>  		break;
> +	case NVME_SC_HOST_PATH_ERROR:
> +		/*
> +		 * Temporary transport disruption in talking to the controller.
> +		 * Try to send on a new path.
> +		 */
> +		nvme_mpath_clear_current_path(ns);
> +		break;
>  	default:
>  		/*
>  		 * Reset the controller for any non-ANA error as we don't know
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 68e91ef5494c..818dbe9331be 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1241,6 +1241,7 @@ enum {
>  	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
>  	NVME_SC_ANA_INACCESSIBLE	= 0x302,
>  	NVME_SC_ANA_TRANSITION		= 0x303,
> +	NVME_SC_HOST_PATH_ERROR		= 0x370,
>  
>  	NVME_SC_DNR			= 0x4000,
>  };
> 
Don't we need a mapping in nvme_error_status() to map the new code into
a BLK_STS_XXX code other that BLK_STS_IOERR?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
