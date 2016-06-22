From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Jun 2016 13:22:49 +0300
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <20160621160134.GA8428@lst.de>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org> <20160616151048.GA13218@lst.de>
 <5762F9E2.7030101@grimberg.me> <20160616203824.GA19113@lst.de>
 <57631C0E.80200@grimberg.me> <20160621160134.GA8428@lst.de>
Message-ID: <576A66F9.6030100@grimberg.me>


>>> to false because the queue is on the local list, and now we have thread 1
>>> and 2 racing for disconnecting the queue.
>>
>> But the list removal and list_empty evaluation is still under a mutex,
>> isn't that sufficient to avoid the race?
>
> If only once side takes the lock it's not very helpful.  We can
> execute nvmet_rdma_queue_disconnect from the CM handler at the
> same time that the queue is on the to be removed list, which creates
> two issues: a) we manipulate local del_list without any knowledge
> of the thread calling nvmet_rdma_delete_ctrl, leading to potential
> list corruption

It's not racy because the two call sites are mutually exclusive
(calling nvmet_rdma_queue_disconnect which is protected by a mutex)
and the iteration on del_list is safe, but I'm not sure how safe it
is because it's a local list and another context may manipulate it.

However, note that this is not the case here. The report did not
include a CM thread in the mix.

, and b) we can call into __nvmet_rdma_queue_disconnect
> concurrently.  As you pointed out we still have the per-queue
> state_lock inside __nvmet_rdma_queue_disconnect so b) probably
> is harmless at the moment as long as the queue hasn't been freed
> yet by one of the racing threads, which is fairly unlikely.

I don't think we can end up with a use-after-free condition, we
terminate both the CM events and the list removal so I don't see
how that can happen.

> Either way - using list_empty to check if something is still alive due
> to being linked in a list and using a local dispose list simply don't
> mix.  Both are useful patterns on their own, but should not be mixed.

I guess you are correct. I just don't like lock manipulations inside
the list iterations, it can be an opening for future bugs as it requires
a very strict understanding of what is going on...
