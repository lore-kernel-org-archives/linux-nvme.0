From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 6 Jun 2017 15:08:09 +0300
Subject: [PATCH] nvme-pci: avoid 64-bit divisions in the HMB code
In-Reply-To: <20170606095411.22429-1-hch@lst.de>
References: <20170606095411.22429-1-hch@lst.de>
Message-ID: <1962082d-f9c7-d6d3-6f4b-b95a694c82dc@mellanox.com>



On 6/6/2017 12:54 PM, Christoph Hellwig wrote:
> [to be folded into "nvme-pci: implement host memory buffer support"]
>
> Avoid 64-bit division by using shifts instead.  All involved sizez are

small type: sizez --> sizes

> powers of two.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---

Looks good,
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
