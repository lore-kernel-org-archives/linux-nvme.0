From: james.smart@broadcom.com (James Smart)
Date: Fri, 21 Sep 2018 11:21:53 -0700
Subject: [PATCH] nvme-fabrics -in case of REQ_NVME_MPATH we should return
 BLK_STS_RESOURCE
In-Reply-To: <20180921070554.GB14529@lst.de>
References: <CY4PR17MB1368DE7C1E52DF30E17060BBE61D0@CY4PR17MB1368.namprd17.prod.outlook.com>
 <20180918162526.GA5038@lst.de>
 <2866a0d5-9864-a2fd-572b-6e6f2c581de5@broadcom.com>
 <20180918190834.GA26013@localhost.localdomain>
 <19b26262-686c-c778-7e01-488917537636@broadcom.com>
 <20180920063924.GG12913@lst.de>
 <41fde3c0-076f-ca4d-79ed-2d86d25ac94f@broadcom.com>
 <20180921070554.GB14529@lst.de>
Message-ID: <56083021-22a9-5a40-5e0d-82854ab038a7@broadcom.com>

On 9/21/2018 12:05 AM, hch@lst.de wrote:
>> I agree with you - that nvme_complete_rq() handles it fine. But in the path
>> where the transport->queue_rq() is called, and the io is bounced due to
>> controller state checks, nvme_complete_rq() isn't being called.? If
>> queue_rq() return BLK_STS_RESOURCE, its ok as the io gets requeued in
>> blk-mq, but it could sit there for 60s or so. But if queue_rq() see the io
>> marked NVME_MPATH, it returns BLK_STS_IOERR? (blk_mq_complete_request()
>> isn't called), and the blk-mq layer ends up calling blk_mq_end_request().
> Yes.  And that is probably why the current code is doing the right(-ish)
> thing.

So I agree that what we're doing currently is correct - except that the 
IOERR bounces all the way up to the caller above multipath - so they get 
an erroneous EIO rather than having us insulate it (waiting somewhere, 
but not on blk-mq for a long time) over a very short reset/reconnect window.

I'll post something shortly that seems to resolve it, although maybe not 
optimally.

And as I look at this - I think we need to invent a 
linux-nvme-stack-specific status code to indicate a path-connectivity 
error like we did on SCSI.? I/O's are currently returning 
NVME_SC_ABORT_REQ status. We could cheat and use an ANA_TRANSITIONING 
status, but that probably isn't the smartest thing to do.? The new 
status would give nvme multipath a better hint about what to do next.

-- james
