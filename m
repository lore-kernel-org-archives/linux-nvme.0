From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 8 May 2017 11:31:48 +0200
Subject: [PATCH] nvme_fc: set logging level on resets/deletes
In-Reply-To: <20170425223234.3958-1-jsmart2021@gmail.com>
References: <20170425223234.3958-1-jsmart2021@gmail.com>
Message-ID: <552d0a62-d74d-f20b-049f-11338b701c5f@suse.de>

Hi James,

On 04/26/2017 12:32 AM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> Per the review by Sagi on:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html
> 
> Looked at existing warn vs info vs err dev_xxx levels for the messages
> printed on reconnects and deletes:
> - Resets due to error and resets transitioned to deletes are dev_warn
> - Other reset/disconnect messages are dev_info
> - Added admin-requested delete info message
> - Removed chatty io queue related messages
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

[...]

>  
> -	dev_info(ctrl->ctrl.device, "creating %d I/O queues.\n",
> -			opts->nr_io_queues);
> -
>  	nvme_fc_init_io_queues(ctrl);
>  
>  	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
> @@ -2268,9 +2265,6 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
>  	if (ctrl->queue_count == 1)
>  		return 0;
>  
> -	dev_info(ctrl->ctrl.device, "Recreating %d I/O queues.\n",
> -			opts->nr_io_queues);
> -
>  	nvme_fc_init_io_queues(ctrl);
>  
>  	ret = blk_mq_reinit_tagset(&ctrl->tag_set);

Can you maybe change the above two messages to dev_debug()? I have a gut
feeling that they might become handy one day.

Otherwise,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
