From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 20 Feb 2019 17:55:04 -0500
Subject: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
In-Reply-To: <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
 (Chaitanya Kulkarni's message of "Wed, 20 Feb 2019 18:16:27 +0000")
References: <20190220031122.GA17298@ming.t460p> <20190220141701.GA26537@lst.de>
 <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <yq1tvgyhxyv.fsf@oracle.com>


Chaitanya,

> -	if (!blk_rq_payload_bytes(rq))
> +	if (!blk_rq_nr_phys_segments(rq))

Wouldn't it be better to set RQF_SPECIAL_PAYLOAD and friends in
nvme_setup_write_zeroes() like it's done for discard?

-- 
Martin K. Petersen	Oracle Linux Engineering
