From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Feb 2019 14:37:00 +0100
Subject: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
In-Reply-To: <722BE5B7-B32B-4B2F-9AC2-E6F5AB5E12D4@wdc.com>
References: <20190220031122.GA17298@ming.t460p> <20190220141701.GA26537@lst.de>
 <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <yq1tvgyhxyv.fsf@oracle.com> <722BE5B7-B32B-4B2F-9AC2-E6F5AB5E12D4@wdc.com>
Message-ID: <20190221133700.GA20189@lst.de>

On Thu, Feb 21, 2019@01:29:57AM +0000, Chaitanya Kulkarni wrote:
> Hi Martin,
> 
> I don't mind going though that route, here are some points about
> benefits of not using REQ_SPECIAL_PAYLOAD for write-zeroes :-
> 
> 1. We are using RQF_SPECIAL_PAYLOAD for only discard commands and not for
>      write-zeroes because it does not have any payload. Using this in the code will
>      trigger more code changes to handle in the completion path.

Yes.  And that is the big difference to SCSI where REQ_OP_WRITE_ZEROES
turns into a WRITE SAME command that has a payload.  So for SCSI
RQF_SPECIAL_PAYLOAD for REQ_OP_WRITE_ZEROES makes a lot of sense, for
NVMe it does not.
