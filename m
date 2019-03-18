From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 18 Mar 2019 10:28:05 -0700
Subject: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1552930085.152266.36.camel@acm.org>

On Fri, 2019-03-15@16:57 +0800, Jianchao Wang wrote:
> [2] https://marc.info/?l=linux-block&m=154526189023236&w=2

Hi Jianchao,

That is a reference to the "BUG: KASAN: use-after-free in bt_iter" issue.
I think that issue can be fixed in another way than modifying all code that
iterates over tags, namely by adding an rcu_read_lock() / rcu_read_unlock()
pair in bt_for_each() and bt_tags_for_each() and by changing the calls in
blk_mq_free_rqs() and blk_free_flush_queue() that free the data structures
used by the tag iteration functions into kfree_rcu() or call_rcu() calls.

Thanks,

Bart.
