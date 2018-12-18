From: yupeng0921@gmail.com (peng yu)
Date: Mon, 17 Dec 2018 23:44:51 -0800
Subject: [PATCH v4 2/2] trace nvme submit queue status
In-Reply-To: <24f78f57-9786-effd-6ffe-f9a556211898@grimberg.me>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
 <20181218045138.4282-2-yupeng0921@gmail.com>
 <24f78f57-9786-effd-6ffe-f9a556211898@grimberg.me>
Message-ID: <CAG3TDc1Od_aAq7VC5y_cu0mms2muzWXrBv-fCsHQkXEdXsBmoQ@mail.gmail.com>

On Mon, Dec 17, 2018@11:26 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > @@ -899,6 +900,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
> >       }
> >
> >       req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
> > +     trace_nvme_sq(req->rq_disk,
> > +             nvmeq->qid,
> > +             le16_to_cpu(cqe->sq_head),
> > +             nvmeq->sq_tail);
>
> Why the newline escapes? why not escape at the 80 char border?
>

Sorry, I don't quite understand your meaning. Do you mean I'd better
change this:
        trace_nvme_sq(req->rq_disk,
                nvmeq->qid,
                le16_to_cpu(cqe->sq_head),
                nvmeq->sq_tail);
to something like below:
        trace_nvme_sq(req->rq_disk, nvmeq->qid, le16_to_cpu(cqe->sq_head),
                nvmeq->sq_tail);
Please let me know whether my understanding is correct.
