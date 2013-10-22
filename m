From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 Oct 2013 10:55:02 -0600 (MDT)
Subject: [PATCH 3/3] NVMe: Convert to blk-mq
In-Reply-To: <526186AE.3080006@bjorling.me>
References: <1382102062-22270-1-git-send-email-m@bjorling.me>
 <1382102062-22270-4-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1310180837140.4763@AMR> <526186AE.3080006@bjorling.me>
Message-ID: <alpine.LRH.2.03.1310221011570.4763@AMR>

On Fri, 18 Oct 2013, Matias Bj?rling wrote:
> On 10/18/2013 05:13 PM, Keith Busch wrote:
>> On Fri, 18 Oct 2013, Matias Bjorling wrote:
>>> The nvme driver implements itself as a bio-based driver. This primarily
>>> because of high lock congestion for high-performance nvm devices. To
>>> remove the congestion within the traditional block layer, a multi-queue
>>> block layer is being implemented.

>>> -    result = nvme_map_bio(nvmeq, iod, bio, dma_dir, psegs);
>>> -    if (result <= 0)
>>> +    if (nvme_map_rq(nvmeq, iod, rq, dma_dir))
>>>         goto free_cmdid;
>>> -    length = result;
>>> 
>>> -    cmnd->rw.command_id = cmdid;
>>> +    length = blk_rq_bytes(rq);
>>> +
>>> +    cmnd->rw.command_id = rq->tag;
>> 
>> The command ids have to be unique on a submission queue. Since each
>> namespace's blk-mq has its own 'tags' used as command ids here but share
>> submission queues, what's stopping the tags for commands sent to namespace
>> 1 from clashing with tags for namespace 2?
>> 
>> I think this would work better if one blk-mq was created per device
>> rather than namespace. It would fix the tag problem above and save a
>> lot of memory potentially wasted on millions of requests allocated that
>> can't be used.
>
> You're right. I didn't see the connection. In v3 I'll push struct 
> request_queue to nvme_dev and map the queues appropriately. It will also fix 
> the command id issues.

Just anticipating a possible issue with the suggestion. Will this separate
the logical block size from the request_queue? Each namespace can have
a different format, so the block size and request_queue can't be tied
together like it currently is for this to work.
