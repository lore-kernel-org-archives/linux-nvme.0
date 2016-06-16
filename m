From: hch@lst.de (Christoph Hellwig)
Date: Thu, 16 Jun 2016 22:38:24 +0200
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <5762F9E2.7030101@grimberg.me>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org> <20160616151048.GA13218@lst.de>
 <5762F9E2.7030101@grimberg.me>
Message-ID: <20160616203824.GA19113@lst.de>

On Thu, Jun 16, 2016@10:11:30PM +0300, Sagi Grimberg wrote:
>> I think nvmet_rdma_delete_ctrl is getting the exlusion vs other calls
>> or __nvmet_rdma_queue_disconnect wrong as we rely on a queue that
>> is undergoing deletion to not be on any list.
>
> How do we rely on that? __nvmet_rdma_queue_disconnect callers are
> responsible for queue_list deletion and queue the release. I don't
> see where are we getting it wrong.

Thread 1:

Moves the queues off nvmet_rdma_queue_list and and onto the
local list in nvmet_rdma_delete_ctrl

Thread 2:

Gets into nvmet_rdma_cm_handler -> nvmet_rdma_queue_disconnect for one
of the queues now on the local list.  list_empty(&queue->queue_list) evaluates
to false because the queue is on the local list, and now we have thread 1
and 2 racing for disconnecting the queue.

>>   static int nvmet_rdma_add_port(struct nvmet_port *port)
>>
>
> Umm, this looks wrong to me. delete_controller should delete _all_
> the ctrl queues (which will usually involve more than 1), what about
> all the other queues? what am I missing?

Yes, it should - see the patch I just posted.
