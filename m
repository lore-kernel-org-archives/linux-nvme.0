From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 17 Jun 2016 00:40:02 +0300
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <57631C0E.80200@grimberg.me>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org> <20160616151048.GA13218@lst.de>
 <5762F9E2.7030101@grimberg.me> <20160616203824.GA19113@lst.de>
 <57631C0E.80200@grimberg.me>
Message-ID: <57631CB2.5020405@grimberg.me>


>>> How do we rely on that? __nvmet_rdma_queue_disconnect callers are
>>> responsible for queue_list deletion and queue the release. I don't
>>> see where are we getting it wrong.
>>
>> Thread 1:
>>
>> Moves the queues off nvmet_rdma_queue_list and and onto the
>> local list in nvmet_rdma_delete_ctrl
>>
>> Thread 2:
>>
>> Gets into nvmet_rdma_cm_handler -> nvmet_rdma_queue_disconnect for one
>> of the queues now on the local list.  list_empty(&queue->queue_list)
>> evaluates
>> to false because the queue is on the local list, and now we have thread 1
>> and 2 racing for disconnecting the queue.
>
> But the list removal and list_empty evaluation is still under a mutex,
> isn't that sufficient to avoid the race?

And we also have a mutual exclusion point inside 
__nvmet_rdma_queue_disconnect with queue->state_lock...
