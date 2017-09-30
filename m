From: jsmart2021@gmail.com (James Smart)
Date: Sat, 30 Sep 2017 11:32:39 -0700
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <90b9711d-e279-443d-1693-dad24524cc74@grimberg.me>
References: <20170927040958.5981-1-jsmart2021@gmail.com>
 <90b9711d-e279-443d-1693-dad24524cc74@grimberg.me>
Message-ID: <e86009d5-2ca6-8de3-d142-781724bf00d8@gmail.com>

On 9/30/2017 10:17 AM, Sagi Grimberg wrote:
> 
>> @@ -504,9 +505,11 @@ nvmet_fc_queue_fcp_req(struct nvmet_fc_tgtport 
>> *tgtport,
>> ????? fcpreq->hwqid = queue->qid ?
>> ????????????? ((queue->qid - 1) % tgtport->ops->max_hw_queues) : 0;
>> -??? if (tgtport->ops->target_features & NVMET_FCTGTFEAT_CMD_IN_ISR)
>> -??????? queue_work_on(queue->cpu, queue->work_q, &fod->work);
>> -??? else
>> +??? if (tgtport->ops->target_features & NVMET_FCTGTFEAT_CMD_IN_ISR) {
>> +??????? cpu = (queue->cpu == WORK_CPU_UNBOUND) ?
>> +??????????????????? get_cpu() : queue->cpu;
> 
> Why doing this? Why not let workqueue choose it for you? it will
> attempt your local cpu, but if its busy it will get someone else...
> 
> You can simply queue it with WORK_CPU_UNBOUND if it happened to be set
> this way...

Because we're still trying to get cpu affinity on the connection 
resources that will be shared by the io on the same queue.

And we're trying to spread out the cpu utilization rather than ganging 
up on a few cpus (e.g. the lldd may have (quite a few) fewer msix than 
there are cpus).

But... as I now got lpfc to move to a softirq model (still needs to be 
merged), and cavium, as the other FC adapter was already there. I'm 
going to come around and delete these "IN_ISR" cases. I was going to
delay that but perhaps nows the time to do so.

-- james
