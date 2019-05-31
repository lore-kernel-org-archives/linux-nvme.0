From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 31 May 2019 16:29:06 -0700
Subject: [RFC PATCH 5/5] nvme-trace: Add tracing for req_comp in target
In-Reply-To: <20190527175346.29972-6-minwoo.im.dev@gmail.com>
References: <20190527175346.29972-1-minwoo.im.dev@gmail.com>
 <20190527175346.29972-6-minwoo.im.dev@gmail.com>
Message-ID: <b2e1e9f4-a96c-9f72-d787-1cd0a6248aa0@grimberg.me>


> @@ -207,20 +208,50 @@ TRACE_EVENT(nvme_complete_rq,
>   		__field(u16, status)
>   	    ),
>   	    TP_fast_assign(
> -		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
> -		__entry->qid = nvme_req_qid(req);
> -		__entry->cid = req->tag;
> -		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
> -		__entry->retries = nvme_req(req)->retries;
> -		__entry->flags = nvme_req(req)->flags;
> -		__entry->status = nvme_req(req)->status;
> -		__assign_disk_name(__entry->disk, req->rq_disk);
> +		set_trace_type(__entry->type, req);
> +		if (__entry->type != NVME_TRACE_TARGET) {
> +			struct request *req = (struct request *) req;
> +
> +			__entry->ctrl_id = nvme_req(req)->ctrl->instance;
> +			__entry->qid = nvme_req_qid(req);
> +			__entry->cid = req->tag;
> +			__entry->result =
> +					le64_to_cpu(nvme_req(req)->result.u64);
> +			__entry->retries = nvme_req(req)->retries;
> +			__entry->flags = nvme_req(req)->flags;
> +			__entry->status = nvme_req(req)->status;
> +			__assign_disk_name(__entry->disk, req->rq_disk);
> +		} else {
> +			struct nvmet_ctrl *ctrl = nvmet_req_to_ctrl(req);
> +			struct nvmet_cq *cq = ((struct nvmet_req *) req)->cq;
> +			struct nvme_completion *cqe =
> +					((struct nvmet_req *) req)->cqe;
> +			struct nvmet_ns *ns = ((struct nvmet_req *) req)->ns;
> +
> +			__entry->ctrl_id = ctrl ? ctrl->cntlid : 0;
> +			__entry->qid = cq->qid;
> +			__entry->cid = cqe->command_id;
> +			__entry->result = cqe->result.u64;
> +			__entry->flags = 0;
> +			__entry->status = cqe->status >> 1;

Why not keep the dnr bit?
