From: james.smart@broadcom.com (James Smart)
Date: Mon, 22 Aug 2016 10:28:39 -0700
Subject: [PATCH 4/5] nvme-fabrics: Add target FC transport support
In-Reply-To: <20160811212238.GG18013@infradead.org>
References: <5792b91e.51+4Ind0/2MxGqHU%james.smart@broadcom.com>
 <20160811212238.GG18013@infradead.org>
Message-ID: <9641de6d-1bfb-394c-d4e0-712c8ef6d740@broadcom.com>



On 8/11/2016 2:22 PM, Christoph Hellwig wrote:
>
>> +	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
>> +				assoc->tgtport->fc_target_port.port_num,
>> +				assoc->a_id, qid);
> Do we really need a workqueue per queue?

I thought we did - so there was always an execution context for the 
nvmet layer when a command is received. My understanding was the nvmet 
layer processes the cmd synchronously. I avoided per cpu - as I assumed 
the synchronous flows would end up blocking other connections to other 
subsystems/controllers.

If that's not the case - can you describe the nvmet layer better so I 
understand what we need ?


>
> No reference counting?
>

yes - will make a pass at it.

-- james
