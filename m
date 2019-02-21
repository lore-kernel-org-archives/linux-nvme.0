From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 21 Feb 2019 01:29:57 +0000
Subject: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
In-Reply-To: <yq1tvgyhxyv.fsf@oracle.com>
References: <20190220031122.GA17298@ming.t460p> <20190220141701.GA26537@lst.de>
 <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <yq1tvgyhxyv.fsf@oracle.com>
Message-ID: <722BE5B7-B32B-4B2F-9AC2-E6F5AB5E12D4@wdc.com>

Hi Martin,

I don't mind going though that route, here are some points about
benefits of not using REQ_SPECIAL_PAYLOAD for write-zeroes :-

1. We are using RQF_SPECIAL_PAYLOAD for only discard commands and not for
     write-zeroes because it does not have any payload. Using this in the code will
     trigger more code changes to handle in the completion path.

2. Right now, blk_rq_nr_phys_segments() is used in:-
    nvme/host/pci.c
    nvme/target/loop.c

    In order to keep the code consistent, I think we should use the same function
    call everywhere in the nvme code base:-
    nvme/host/rdam.c : nvme_rdma_map_data() for the first check.
    nvme/host/fc.c : nvme_fc_queue_rq().

 3. Also blk_rq_nr_phys_segments() takes RQF_SPECIAL_PAYLOAD into account so
     no more changes required for discard and write-zeroes cases.

Regards,
-Chaitanya

On 2/20/19, 2:55 PM, "Martin K. Petersen" <martin.petersen@oracle.com> wrote:

    
    Chaitanya,
    
    > -	if (!blk_rq_payload_bytes(rq))
    > +	if (!blk_rq_nr_phys_segments(rq))
    
    Wouldn't it be better to set RQF_SPECIAL_PAYLOAD and friends in
    nvme_setup_write_zeroes() like it's done for discard?
    
    -- 
    Martin K. Petersen	Oracle Linux Engineering
    
