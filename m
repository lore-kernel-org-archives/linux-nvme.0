From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 23 Jan 2018 21:09:10 +0800
Subject: [PATCH 2/5] nvme: Ending failed unstarted requests
In-Reply-To: <e414d8a6-119c-8ebd-115c-96189defa323@grimberg.me>
References: <20180122215630.13697-1-keith.busch@intel.com>
 <20180122215630.13697-2-keith.busch@intel.com>
 <7969da07-a8f5-2653-614e-f930f1d32f16@oracle.com>
 <e414d8a6-119c-8ebd-115c-96189defa323@grimberg.me>
Message-ID: <94a949c3-859b-504a-b75b-5c9540e761ee@oracle.com>

Hi Sagi


On 01/23/2018 09:02 PM, Sagi Grimberg wrote:
> 
>>> +static void nvme_end_unstarted_request(struct request *req, void *data,
>>> +?????????????????????? bool reserved)
>>> +{
>>> +??? if (blk_mq_request_started(req))
>>> +??????? return;
>>> +
>>> +??? dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>>> +??????????????? "Ending I/O %d", req->tag);
>>> +??? blk_mq_end_request(req, BLK_STS_IOERR);
>>> +}
>>> +
>>
>> This unstarted requests have not been dequeued from the blk-mq queue.
>> We cannot end them directly.
> 
> I think we cannot complete them. I think its fine to end them.
> 
The end here which is done by blk_mq_end_request is to free it,

blk_mq_end_request()
  -> __blk_mq_end_request()
    -> blk_mq_free_request()

The requests are still on the blk-mq queues.
How can we free them ?

Thanks
Jianchao
