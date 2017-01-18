From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Jan 2017 10:09:21 +0100
Subject: [PATCH 3/4] nvme: use blk_rq_payload_bytes
In-Reply-To: <7532e18a-6cd3-294f-085d-e1ecdc48af6e@grimberg.me>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
 <1484306953-3194-4-git-send-email-hch@lst.de>
 <7532e18a-6cd3-294f-085d-e1ecdc48af6e@grimberg.me>
Message-ID: <20170118090921.GA24058@lst.de>

On Tue, Jan 17, 2017@10:06:51PM +0200, Sagi Grimberg wrote:
>
>> @@ -1014,9 +1013,9 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
>>  	}
>>
>
> Christoph, a little above here we still look at blk_rq_bytes(),
> shouldn't that look at blk_rq_payload_bytes() too?

The check is ok for now as it's just zero vs non-zero.  It's somewhat
broken for Write Zeroes, though.  I've fixed it in this series
which I need to submit:

	http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/write-zeroes-take-2
