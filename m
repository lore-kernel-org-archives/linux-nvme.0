From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 18 Mar 2019 09:49:33 +0800
Subject: [PATCH 2/8] blk-mq: change the method of iterating busy tags of a
 request_queue
In-Reply-To: <20190315161608.GB15153@localhost.localdomain>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
 <20190315161608.GB15153@localhost.localdomain>
Message-ID: <e17f86f0-98ca-5c79-0d9b-43c628b72413@oracle.com>

Hi Keith

On 3/16/19 12:16 AM, Keith Busch wrote:
> There is still a window where the check may succeed, but the request is
> being assigned to a completely different request_queue. The callback
> then operates on a request it doesn't own.
> 
> Tag iteration from a driver can be safe only if the driver initiates a
> freeze and quiesced all queues sharing the same tagset first. The nvme
> driver does that, but I think there may need to be an additional grace
> period to wait for the allocation's queue_enter to call queue_exit to
> ensure the request is initialized through blk_mq_rq_ctx_init().

This patch is to avoid the use-after-free case in the comment.
The helper interface is used in following cases,
1. in flight request account
   this case should not require so much accuracy

2. timeout check
   a extra reference will be held there to avoid the request recycle

3. if it is used by driver, it should be enough that quiesce the request_queue
   the driver usually wants to handle the in-flight ones, quiesce request_queue
   could ensure all of tasks quit the hctx_lock and no one issue request any
   more.

Thanks
Jianchao
