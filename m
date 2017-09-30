From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 30 Sep 2017 19:17:13 +0200
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <20170927040958.5981-1-jsmart2021@gmail.com>
References: <20170927040958.5981-1-jsmart2021@gmail.com>
Message-ID: <90b9711d-e279-443d-1693-dad24524cc74@grimberg.me>


> @@ -504,9 +505,11 @@ nvmet_fc_queue_fcp_req(struct nvmet_fc_tgtport *tgtport,
>   	fcpreq->hwqid = queue->qid ?
>   			((queue->qid - 1) % tgtport->ops->max_hw_queues) : 0;
>   
> -	if (tgtport->ops->target_features & NVMET_FCTGTFEAT_CMD_IN_ISR)
> -		queue_work_on(queue->cpu, queue->work_q, &fod->work);
> -	else
> +	if (tgtport->ops->target_features & NVMET_FCTGTFEAT_CMD_IN_ISR) {
> +		cpu = (queue->cpu == WORK_CPU_UNBOUND) ?
> +					get_cpu() : queue->cpu;

Why doing this? Why not let workqueue choose it for you? it will
attempt your local cpu, but if its busy it will get someone else...

You can simply queue it with WORK_CPU_UNBOUND if it happened to be set
this way...
