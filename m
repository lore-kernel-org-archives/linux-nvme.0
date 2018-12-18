From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 17 Dec 2018 23:26:23 -0800
Subject: [PATCH v4 2/2] trace nvme submit queue status
In-Reply-To: <20181218045138.4282-2-yupeng0921@gmail.com>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
 <20181218045138.4282-2-yupeng0921@gmail.com>
Message-ID: <24f78f57-9786-effd-6ffe-f9a556211898@grimberg.me>


> @@ -899,6 +900,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>   	}
>   
>   	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
> +	trace_nvme_sq(req->rq_disk,
> +		nvmeq->qid,
> +		le16_to_cpu(cqe->sq_head),
> +		nvmeq->sq_tail);

Why the newline escapes? why not escape at the 80 char border?

Other than that, looks fine,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
