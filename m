From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 29 Aug 2018 10:34:25 +0200
Subject: [PATCH] nvme-core: add async event trace helper
In-Reply-To: <20180829043720.8545-1-chaitanya.kulkarni@wdc.com>
References: <20180829043720.8545-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180829083425.GB4124@linux-x5ow.site>

On Tue, Aug 28, 2018@09:37:20PM -0700, Chaitanya Kulkarni wrote:
> This patch adds a new event for nvme async event notification.
> We print the async event in the decoded format when we recognize the
> event otherwise we just dump the result.
> 
> This tracing event is needed to observe/log the different NVMe
> Asynchronous Event from different types of controllers NVMe PCIe or
> NVMeOF.
> 

[...]

> +TRACE_EVENT(nvme_async_event,
> +		TP_PROTO(struct nvme_ctrl *ctrl, u32 result),
> +		TP_ARGS(ctrl, result),
> +		TP_STRUCT__entry(
> +			__field(int, ctrl_id)
> +			__field(u32, result)
> +			),
> +		TP_fast_assign(
> +			__entry->ctrl_id = ctrl->instance;
> +			__entry->result = result;
> +			),
> +		TP_printk("nvme%d: NVME_AEN=%#08x",
> +			__entry->ctrl_id, __entry->result)
> +
> +	   );
> +

Cool thanks, but can you add maybe also print a __stringify()ed
version of the AEN? So we get "nvme0: NVME_AEN_CFG_ANA_CHANGE" instead
of "nvme0: NVME_AEN=0x00000800".

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
