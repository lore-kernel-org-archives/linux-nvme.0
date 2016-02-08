From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Mon, 8 Feb 2016 20:47:42 +0100
Subject: [PATCH] nvme: return the whole CQE through the request
 passthrough interface
In-Reply-To: <1454954988-32306-2-git-send-email-hch@lst.de>
References: <1454954988-32306-1-git-send-email-hch@lst.de>
 <1454954988-32306-2-git-send-email-hch@lst.de>
Message-ID: <56B8F0DE.5090808@bjorling.me>

>   		req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
> -		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
> -			u32 result = le32_to_cpu(cqe.result);
> -			req->special = (void *)(uintptr_t)result;
> -		}
> +		if (req->cmd_type == REQ_TYPE_DRV_PRIV && req->special)
> +			memcpy(req->special, &cqe, sizeof(cqe));

Thanks for sending the patch.

When LightNVM send asynchronous data commands, it would need to allocate 
extra memory for cqe. Would it make sense to pass cqe directly and 
assume that it is live through the blk_mq_complete_request call?
