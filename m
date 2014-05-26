From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 26 May 2014 19:51:56 -0400
Subject: [PATCH] NVMe: Add support to receive NVMe asynchronous events
In-Reply-To: <53839E67.1010006@micron.com>
References: <53839E67.1010006@micron.com>
Message-ID: <20140526235156.GS6121@linux.intel.com>

On Mon, May 26, 2014@01:04:55PM -0700, Winson Yung (wyung) wrote:
> As a NVMe mandatory admin command, this driver should be setup so
> that it can receive drive critical asynchronous notification for
> issue such as device reliability, temperature above threshold, or
> available spare space fallen below threshould. This patch enables
> very basic mechanism to log the asynchronous events in kernel log.

Umm ... did you test this patch?

> Signed-off-by: Winson Yung <wyung at micron.com>
> ---
>  drivers/block/nvme-core.c |   57 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index cd8a8bc7..4cd9f8e 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -198,6 +198,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
>  #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
>  #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
>  #define CMD_CTX_ABORT		(0x318 + CMD_CTX_BASE)
> +#define CMD_CTX_ASYNC_EVENT	(0x319 + CMD_CTX_BASE)

Please only use multiples of four; that is, 0x31c, not 0x319.  Also, these
are for use by 'special_completion', not 'async_completion'.

> +static int nvme_enable_async_events(struct nvme_dev *dev)
> +{
> +	int status, cmdid;
> +	u32 result, async_events;
> +	struct nvme_queue *adminq;
> +
> +	async_events = NVME_SMART_CRIT_SPARE |
> +			NVME_SMART_CRIT_TEMPERATURE |
> +			NVME_SMART_CRIT_RELIABILITY |
> +			NVME_SMART_CRIT_MEDIA |
> +			NVME_SMART_CRIT_VOLATILE_MEMORY;
> +
> +	status = nvme_set_features(dev, NVME_FEAT_ASYNC_EVENT,
> +					async_events, 0, &result);
> +
> +	if (status < 0)
> +		return status;
> +
> +	if (status > 0) {
> +		dev_err(&dev->pci_dev->dev, "Could not enable async event (%d)\n",
> +									status);
> +		return -EBUSY;
> +	}
> +
> +	adminq = rcu_dereference(dev->queues[0]);
> +
> +	/* Allocate a cmdid entry in preparation of next incoming async event */
> +	cmdid = alloc_cmdid(adminq, CMD_CTX_ASYNC_EVENT, async_completion, 0);
> +	return cmdid;
> +}

How is this supposed to work?  You've allocated a command ID, but you
haven't submitted an asynchronous event request command.  So how does
the controller know to use this command ID to report asynchronous events?

You should probably take a look at Keith's work last year to allow userspace
to send async event requests:

http://lists.infradead.org/pipermail/linux-nvme/2013-August/000350.html
