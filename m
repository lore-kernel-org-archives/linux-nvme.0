From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Tue, 25 Oct 2016 09:35:48 -0700
Subject: [PATCH] rdma: force queue size to respect controller capability
In-Reply-To: <444159155.19898733.1477380154029.JavaMail.zimbra@kalray.eu>
References: <444159155.19898733.1477380154029.JavaMail.zimbra@kalray.eu>
Message-ID: <df71b855-c133-b3ad-ec81-e36a6f851531@intel.com>

On 10/25/2016 12:22 AM, Samuel Jones wrote:
> Queue size needs to respect the Maximum Queue Entries Supported advertised by
> the controller in its Capability register.
>
> Signed-off-by: Samuel Jones <sjones at kalray.eu>
> ---
>  drivers/nvme/host/rdma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 5a83881..98d9c09 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1908,6 +1908,14 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>  		opts->queue_size = ctrl->ctrl.maxcmd;
>  	}
>
> +	if (opts->queue_size > ctrl->ctrl.sqsize) {
> +		/* warn if sqsize is lower than queue_size */
> +		dev_warn(ctrl->ctrl.device,
> +			"queue_size %zu > ctrl sqsize %u, clamping down\n",
> +			opts->queue_size, ctrl->ctrl.sqsize);
> +		opts->queue_size = ctrl->ctrl.sqsize;
> +	}

I believe there's an off-by-one (or two) lurking here.

It looks to me like ctrlr->ctrlr.sqsize is intended to be 0's-based:
- sqsize is passed as HSQSIZE in the Connect private data, which is 
0's-based
- sqsize is set to opts->queue_size - 1 earlier in nvme_rdma_create_ctrlr()

However, this new change assigns opts->queue_size (non-0's-based value) 
the current value of ctrlr->ctrlr.sqsize (0's-based value) without any 
adjustment.

This is probably because there is another bug in 
nvme_rdma_configure_admin_queue(), where sqsize is set to a value based 
on CAP.MQES + 1.  MQES is a 0's-based value, so if sqsize is also 
supposed to be 0's based, no addition should be necessary.

I think it is currently working only in the case where the original 
sqsize is already smaller than MQES, because then the min of MQES and 
sqsize will pick sqsize, which is already 0's based from the initial 
queue_size - 1 assignment.

If I'm not missing anything, the correct fix should be removing the + 1 
adjustment of MQES as well as changing this patch to consider the 0's 
based nature of sqsize:

	if (opts->queue_size > ctrlr->ctrlr->sqsize + 1) {
		...
  		opts->queue_size = ctrlr->ctrlr.sqsize + 1;
	}

Thanks,
-- Daniel
