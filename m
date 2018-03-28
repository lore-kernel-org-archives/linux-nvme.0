From: jsmart2021@gmail.com (James Smart)
Date: Wed, 28 Mar 2018 09:21:39 -0700
Subject: [PATCH v2] nvme: expand nvmf_check_if_ready checks
In-Reply-To: <20180328083136.GC31409@infradead.org>
References: <20180327230724.25843-1-jsmart2021@gmail.com>
 <20180328083136.GC31409@infradead.org>
Message-ID: <157dc0ff-a00e-7ecb-0eee-b286ea2e52d6@gmail.com>

On 3/28/2018 1:31 AM, Christoph Hellwig wrote:
>> +static inline blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl,
>> +		struct request *rq, bool qlive, bool connectivity)
> 
> Please rename qlive to queue_live and explain what connectivity means.
> Maye this should be is_connected?  How do we get a command on a not
> conected queue?
> 
> Also I think the function is large enough now to move out of line.
> 

the change requests are fine and I'll repost shortly.

it's fairly easy to get a command on a not connected queue during a 
reset or reconnect state.

Both rdma and fc unquiesce the admin queue blk-mq after the link side 
association is terminated.  rdma unquiesces the io queues blk-mq as well 
at that time, while fc leaves the io queues blk-mq quiesced until 
min(ctrl_reconnect_tmo,dev_loss_tmo).

The most common case is an ioctl from the cli hitting the admin queue 
while there's no link side association (ignoring the connect cmd). New 
normal io to io queues will hit it on rdma while the link side 
association isn't present.

The connectivity thing is: the transport knows there is no longer 
connectivity to the nvme targetport so io's should be stopped/requeued 
but the actions against the controllers for that targetport, usually 
scheduled by workq items, have yet to kick in and tear down the 
controller connections. So far, FC has the additional connectivity check 
that trumps the queue state, while rdma doesn't know and thus hard-sets 
it to true (connected). Given the other changes in rdma recently, they 
may do the same soon if they know the qp is dead.

-- james
