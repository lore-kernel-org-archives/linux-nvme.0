From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 21 Feb 2019 09:22:52 -0500
Subject: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
In-Reply-To: <20190221133700.GA20189@lst.de> (Christoph Hellwig's message of
 "Thu, 21 Feb 2019 14:37:00 +0100")
References: <20190220031122.GA17298@ming.t460p> <20190220141701.GA26537@lst.de>
 <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <yq1tvgyhxyv.fsf@oracle.com>
 <722BE5B7-B32B-4B2F-9AC2-E6F5AB5E12D4@wdc.com>
 <20190221133700.GA20189@lst.de>
Message-ID: <yq1k1hti5kz.fsf@oracle.com>


Christoph,

>> 1. We are using RQF_SPECIAL_PAYLOAD for only discard commands and not
>> for write-zeroes because it does not have any payload. Using this in
>> the code will trigger more code changes to handle in the completion
>> path.
>
> Yes.  And that is the big difference to SCSI where REQ_OP_WRITE_ZEROES
> turns into a WRITE SAME command that has a payload.  So for SCSI
> RQF_SPECIAL_PAYLOAD for REQ_OP_WRITE_ZEROES makes a lot of sense, for
> NVMe it does not.

I don't actually care about using RQF_SPECIAL, it just seemed like a
quick workaround to set it and make bv_len 0.

My concern is purely rooted in all the grief we've had throughout the
block I/O stack distinguishing between the bytes acted upon on media and
the DMA transfer length. And consequently, I don't particularly like
that blk_rq_payload_bytes() doesn't handle the NVMe WRITE ZEROES
command. That seems like something that will cause us headaches in the
future...

-- 
Martin K. Petersen	Oracle Linux Engineering
