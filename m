From: bart.vanassche@wdc.com (Bart Van Assche)
Date: Thu, 22 Feb 2018 07:58:51 -0800
Subject: [PATCH 2/3] nvme-rdma: use blk_rq_payload_bytes instead of
 blk_rq_bytes
In-Reply-To: <20180222152410.19222-3-hch@lst.de>
References: <20180222152410.19222-1-hch@lst.de>
 <20180222152410.19222-3-hch@lst.de>
Message-ID: <d3780f4a-c23f-ea8b-41fd-052fdbcd8743@wdc.com>

On 02/22/18 07:24, Christoph Hellwig wrote:
> blk_rq_bytes does the wrong thing for special payloads like discards and
> might cause the driver to not set up a SGL.

Should "Fixes:" and "Cc: stable" tags be added to this patch?

Thanks,

Bart.
