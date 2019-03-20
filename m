From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Mar 2019 11:52:52 -0700
Subject: [PATCH 2/8] blk-mq: change the method of iterating busy tags of a
 request_queue
In-Reply-To: <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <bf563d09-c243-5bf5-ab3e-0fa2bd583edd@grimberg.me>



On 3/15/19 1:57 AM, Jianchao Wang wrote:
> tags->rqs[] will not been cleaned when free driver tag and there
> is a window between get driver tag and write tags->rqs[], so we
> may see stale rq in tags->rqs[] which may have been freed, as
> following case,
> blk_mq_get_request         blk_mq_queue_tag_busy_iter
>    -> blk_mq_get_tag
>                               -> bt_for_each
>                                 -> bt_iter
>                                   -> rq = taags->rqs[]
>                                   -> rq->q
>    -> blk_mq_rq_ctx_init
>      -> data->hctx->tags->rqs[rq->tag] = rq;
> 
> To fix this, the blk_mq_queue_tag_busy_iter is changed in this
> patch to use tags->static_rqs[] instead of tags->rqs[]. We have
> to identify whether there is a io scheduler attached to decide
> to use hctx->tags or hctx->sched_tags. And we will try to get a
> non-zero q_usage_counter before that, so it is safe to access
> them. Add 'inflight' parameter to determine to iterate in-flight
> requests or just busy tags. A correction here is that
> part_in_flight should count the busy tags instead of rqs that
> have got driver tags.

IMO, instead of this parameter, add a wrapper like
blk_mq_queue_tag_inflight_iter() or keep the parameter out until
we actually have a user that calls it for busy and not inflight.

Other than that, I think that iterating over static_rqs is a good
solution to the problem described.
