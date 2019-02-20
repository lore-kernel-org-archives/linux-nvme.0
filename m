From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 20 Feb 2019 16:59:26 +0000
Subject: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
References: <20190220031122.GA17298@ming.t460p> <20190220141701.GA26537@lst.de>
Message-ID: <SN6PR04MB452781E01A0B353574B55FDE867D0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 02/20/2019 06:17 AM, Christoph Hellwig wrote:
> We shouldn't be allocating a scatterlist for a command that doesn't
> have a payload.
>
> The blk_rq_payload_bytes check in nvme_rdma_map_data is supposed to
> prevent that.
>
> Chaitanya, can you try to debug why this is not working?  I'm on
> vacation and don't have much time right now unfortunately.
>
Yes, already working it.
