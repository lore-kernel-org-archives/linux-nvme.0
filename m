From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Dec 2014 19:16:22 +0000 (UTC)
Subject: [PATCH] NVMe: Fix abort handling
In-Reply-To: <5485FA49.8020707@micron.com>
References: <5485FA49.8020707@micron.com>
Message-ID: <alpine.LNX.2.00.1412081907400.3973@localhost.lm.intel.com>

On Mon, 8 Dec 2014, Sam Bradshaw wrote:
> This patch fixes some problems in the abort handling code; freeing the
> correct request (abort_req) and setting abort_limit & rq_aborted if
> submitted the abort request fails.  In addition, a device reset is
> scheduled pro-actively if the device fails to successful abort a command
> rather than waiting for the timeout handler to disposition the condition.
>
> Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
> ---
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index c154165..34021ed 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -284,6 +284,18 @@ static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
>
> 	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
> 	++nvmeq->dev->abort_limit;
> +
> +	/* Reset controller if abort failed */
> +	if (cqe->result & 0x1) {

I think you're asking for trouble by checking this bit to determine if
you need to reset the controller. If result is set to 1, the controller
is reporting it failed to abort the command, but you've no idea why. Maybe
the command's completion was already on a completion queue, so it couldn't
find it, and now you've reset the controller when you didn't have to.
