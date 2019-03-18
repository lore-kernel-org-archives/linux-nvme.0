From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 18 Mar 2019 10:47:57 +0800
Subject: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
In-Reply-To: <1552666744.45180.135.camel@acm.org>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <20190315092020.GA2405@lst.de>
 <a36be8bd-bb9c-745e-cfdb-018cf0a96d42@oracle.com>
 <1552666744.45180.135.camel@acm.org>
Message-ID: <8cff92a3-2f25-18a7-265f-9bff7d8cc3fc@oracle.com>

Hi Bart

On 3/16/19 12:19 AM, Bart Van Assche wrote:
>> This stale request maybe something that has been freed due to io scheduler
>> is detached or a q using a shared tagset is gone.
>>
>> And also the blk_mq_timeout_work could use it to pick up the expired request.
>> The driver would also use it to requeue the in-flight requests when the device is dead.
>>
>> Compared with adding more synchronization, using static_rqs[] directly maybe simpler :)
> Hi Jianchao,
> 
> Although I appreciate your work: I agree with Christoph that we should avoid races
> like this rather than modifying the block layer to make sure that such races are
> handled safely.

The root cause here is that there is window between set tag sbitmap and set tags->rqs[]
, and we don't clear the tags->rqs[] in free tags path. So when we iterate the busy
tags, we could see stale requests in tags->rqs[] and this stale requests maybe freed.

Looks like it is difficult to close the window above, so we used to try to clear the
tags->rqs[] in two ways,

1. clear the tags->rqs[] in the request free path
Jens doesn't like it
https://marc.info/?l=linux-block&m=154515671524877&w=2
"
It's an extra store, and it's a store to an area that's then now shared
between issue and completion. Those are never a good idea. Besides, it's
the kind of issue you solve in the SLOW path, not in the fast path. Since
that's doable, it would be silly to do it for every IO.
"

2. clear the associated slots in tags->tags[] when blk_mq_free_rqs
https://marc.info/?l=linux-block&m=154534605914798&w=2

+	rcu_read_lock();
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
+	rcu_read_unlock();

The busy_iter_fn could sleep
blk_mq_check_expired
  -> blk_mq_rq_timed_out
    -> q->mq_ops->timeout
       nvme_timeout
         -> nvme_dev_disable
            -> mutex_lock dev->shutdown_lock

Since it is not so flexible to fix on tags->rqs[], why not try to use tags->static_rqs[] ?
Then we wound never care about the stable requests any more.

Thanks
Jianchao
