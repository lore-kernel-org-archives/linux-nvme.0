From: dongli.zhang@oracle.com (Dongli Zhang)
Date: Mon, 25 Mar 2019 15:12:18 +0800
Subject: [PATCH V2 2/8] blk-mq: use static_rqs instead of rqs to iterate
 tags
In-Reply-To: <1553492318-1810-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-3-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <58796005-2f96-ad5c-fa21-b3a0071deb06@oracle.com>

Hi Jianchao,

On 3/25/19 1:38 PM, Jianchao Wang wrote:
> tags->rqs[] will not been cleaned when free driver tag to avoid
> an extra store on a shared area in the per io path. But there
> is a window between get driver tag and write tags->rqs[], so we
> may see stale rq in tags->rqs[] which may have been freed, as
> following case,
> blk_mq_get_request         blk_mq_queue_tag_busy_iter
>   -> blk_mq_get_tag

Sorry I forgot to mention below when I was studying the v1 patchset.

If there is further review iteration, I would suggest clarify here that
blk_mq_get_tag() would set the bit in sbitmap (e.g., via __sbitmap_get_word())
that bt_for_each() would iterate. Otherwise, please ignore my message.

E.g.,

blk_mq_get_request
  -> blk_mq_get_tag
      -> taint sbitmap tag bit
         without setting tags->rqs[tag]

                                          -> bt_for_each
                                              -> iterate all dirty bit...

This would be much more friendly for people not working on block layer and when
they are looking for the potential fix for a bug by simply searching over the
commit messages. People not working on this would be able to quickly understand
there is a window between setting bit and setting data.


>                              -> bt_for_each
>                                -> bt_iter
>                                  -> rq = taags->rqs[]

%s/taags/tags/g

>                                  -> rq->q
>   -> blk_mq_rq_ctx_init
>     -> data->hctx->tags->rqs[rq->tag] = rq;
> 

Thank you very much!

Dongli Zhang
