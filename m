From: hch@lst.de (hch@lst.de)
Date: Fri, 21 Sep 2018 09:05:54 +0200
Subject: [PATCH] nvme-fabrics -in case of REQ_NVME_MPATH we should
 return BLK_STS_RESOURCE
In-Reply-To: <41fde3c0-076f-ca4d-79ed-2d86d25ac94f@broadcom.com>
References: <CY4PR17MB1368DE7C1E52DF30E17060BBE61D0@CY4PR17MB1368.namprd17.prod.outlook.com>
 <20180918162526.GA5038@lst.de>
 <2866a0d5-9864-a2fd-572b-6e6f2c581de5@broadcom.com>
 <20180918190834.GA26013@localhost.localdomain>
 <19b26262-686c-c778-7e01-488917537636@broadcom.com>
 <20180920063924.GG12913@lst.de>
 <41fde3c0-076f-ca4d-79ed-2d86d25ac94f@broadcom.com>
Message-ID: <20180921070554.GB14529@lst.de>

On Thu, Sep 20, 2018@04:39:24PM -0700, James Smart wrote:
>> The multipath code handles failures from nvme_complete_rq just fine,
>> in fact even with this patch we still don't accept the command into
>> queue_rq.  It is just that BLK_STS_RESOURCE is a magic indicator
>> for the blk-mq core to retry internally and not hand it back to the
>> next higher level (which would be the multipath code, either nvme
>> or dm for that matter).
>
> your response is a bit cryptic

Or confused.  I meant handles failures from nvme_*queue_rq just fine
above.

> I agree with you - that nvme_complete_rq() handles it fine. But in the path 
> where the transport->queue_rq() is called, and the io is bounced due to 
> controller state checks, nvme_complete_rq() isn't being called.? If 
> queue_rq() return BLK_STS_RESOURCE, its ok as the io gets requeued in 
> blk-mq, but it could sit there for 60s or so. But if queue_rq() see the io 
> marked NVME_MPATH, it returns BLK_STS_IOERR? (blk_mq_complete_request() 
> isn't called), and the blk-mq layer ends up calling blk_mq_end_request().

Yes.  And that is probably why the current code is doing the right(-ish)
thing.
