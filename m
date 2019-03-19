From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 19 Mar 2019 09:25:04 +0800
Subject: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
In-Reply-To: <1552930085.152266.36.camel@acm.org>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552930085.152266.36.camel@acm.org>
Message-ID: <3cd58454-eda3-de9a-0eed-b6a7edbce28f@oracle.com>

Hi Bart

Thanks for your kindly and detailed comment on this.

On 3/19/19 1:28 AM, Bart Van Assche wrote:
> On Fri, 2019-03-15@16:57 +0800, Jianchao Wang wrote:
>> [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D154526189023236-26w-3D2&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=_8Zz6iRpso8g7WlZ-WB50qqNkI2X2GRfySSBWyFKuI4&s=ZVNqSClQ_47hVGJpSrF5rbTh3X32cAlY-GFF2BPkGx0&e=
> 
> Hi Jianchao,
> 
> That is a reference to the "BUG: KASAN: use-after-free in bt_iter" issue.
> I think that issue can be fixed in another way than modifying all code that
> iterates over tags, namely by adding an rcu_read_lock() / rcu_read_unlock()
> pair in bt_for_each() and bt_tags_for_each() and by changing the calls in
> blk_mq_free_rqs() and blk_free_flush_queue() that free the data structures
> used by the tag iteration functions into kfree_rcu() or call_rcu() calls.

Do you mean this patch from Jens ?
https://marc.info/?l=linux-block&m=154534605914798&w=2

+	rcu_read_lock();
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
+	rcu_read_unlock();

The busy_iter_fn could sleep for nvme
blk_mq_check_expired
  -> blk_mq_rq_timed_out
    -> q->mq_ops->timeout
       nvme_timeout
         -> nvme_dev_disable
            -> mutex_lock dev->shutdown_lock

Thanks
Jianchao
