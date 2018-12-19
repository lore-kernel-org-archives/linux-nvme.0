From: yupeng0921@gmail.com (peng yu)
Date: Tue, 18 Dec 2018 17:19:00 -0800
Subject: [PATCH v4 2/2] trace nvme submit queue status
In-Reply-To: <20181218174750.GA14416@lst.de>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
 <20181218045138.4282-2-yupeng0921@gmail.com>
 <20181218172645.GB13768@localhost.localdomain> <20181218174750.GA14416@lst.de>
Message-ID: <CAG3TDc3QarHcz_ez=GYYzqDp8VwMHL=nUTvur+5XN+m5-T57sA@mail.gmail.com>

On Tue, Dec 18, 2018@9:47 AM hch@lst.de <hch@lst.de> wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2477bd906904..5a0bf6a24d50 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1004,8 +1004,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>         }
>
>         req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
> -       trace_nvme_sq(req->rq_disk, nvmeq->qid, le16_to_cpu(cqe->sq_head),
> -                       nvmeq->sq_tail);
> +       trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
>         nvme_end_request(req, cqe->status, cqe->result);
>  }
>
> diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
> index cf666709bc50..3564120aa7b3 100644
> --- a/drivers/nvme/host/trace.h
> +++ b/drivers/nvme/host/trace.h
> @@ -185,22 +185,24 @@ TRACE_EVENT(nvme_async_event,
>  #undef aer_name
>
>  TRACE_EVENT(nvme_sq,
> -       TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
> -       TP_ARGS(rq_disk, qid, sq_head, sq_tail),
> +       TP_PROTO(struct request *req, __le16 sq_head, int sq_tail),
> +       TP_ARGS(req, sq_head, sq_tail),
>         TP_STRUCT__entry(
> +               __field(int, ctrl_id)
>                 __array(char, disk, DISK_NAME_LEN)
>                 __field(int, qid)
> -               __field(int, sq_head)
> -               __field(int, sq_tail)
> +               __field(u16, sq_head)
> +               __field(u16, sq_tail)
>         ),
>         TP_fast_assign(
> -               __assign_disk_name(__entry->disk, rq_disk);
> -               __entry->qid = qid;
> -               __entry->sq_head = sq_head;
> +               __entry->ctrl_id = nvme_req(req)->ctrl->instance;
> +               __assign_disk_name(__entry->disk, req->rq_disk);
> +               __entry->qid = nvme_req_qid(req);
> +               __entry->sq_head = le16_to_cpu(sq_head);
>                 __entry->sq_tail = sq_tail;
>         ),
> -       TP_printk("nvme: %s qid=%d head=%d tail=%d",
> -               __print_disk_name(__entry->disk),
> +       TP_printk("nvme%d: %sqid=%d, head=%u, tail=%u",
> +               __entry->ctrl_id, __print_disk_name(__entry->disk),
>                 __entry->qid, __entry->sq_head, __entry->sq_tail
>         )
>  );

I think this change is nice. Will you submit this change or are you
suggesting me to do it?
