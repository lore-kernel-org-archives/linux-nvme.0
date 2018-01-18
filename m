From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 18 Jan 2018 19:25:06 +0900
Subject: [PATCH V2] nvme: free pre-allocated queue if create ioq goes wrong
In-Reply-To: <e402e9f4-b884-df4b-3841-445ea38142d2@oracle.com>
References: <1515963650-3805-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180115020016.GB13580@localhost.localdomain>
 <CAA7jztd_Ewejj9DZJKeYRWPi6t-PKW3tB4SR7h+fBT_8ztv0aQ@mail.gmail.com>
 <e402e9f4-b884-df4b-3841-445ea38142d2@oracle.com>
Message-ID: <CAA7jztfXAgo33NmmzvHu5dNyNKEkVzgqMWRR6FS4p3Etxx-i6g@mail.gmail.com>

On Thu, Jan 18, 2018 at 2:27 PM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
> Hi Minwoo

>> Think of the following scenario:
> nvme_reset_work
>   -> nvme_setup_io_queues
>     -> nvme_create_io_queues
>       -> nvme_free_queues
>   -> nvme_kill_queues
>     -> blk_set_queue_dying   // just freeze the queue here, but will not wait to be drained.
>                                 not new requests come in, but maybe still residual requests in blk-mq queues.
>     -> blk_mq_unquiesce_queue
>
> the queues are _unquiesced_ here, then the residual requests will be queued
> and go through nvme_queue_rq. Then the freed nvme_queue structure will be accessed.
> :)
>
> Thanks
> Jianchao

Hi Jianchao,

First of all, I really appreciate letting me know the case.
It seems no one updates the actual nr_hw_queues value and frees hctxs
after nvme_kill_queues().
If you don't mind, would you please tell me where hctxs are freed
after nvme_kill_queues()?
I'm still trying to understand what's going on in blk-mq layer, but
I'm hardly getting to it.

Thanks,
