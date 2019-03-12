From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 12 Mar 2019 18:08:06 +0200
Subject: fix discard and write zeroes configureation for multipath devices
In-Reply-To: <20190312152453.9550-1-hch@lst.de>
References: <20190312152453.9550-1-hch@lst.de>
Message-ID: <3fd10a1c-a877-51cd-2e6e-005f6e787789@mellanox.com>


On 3/12/2019 5:24 PM, Christoph Hellwig wrote:
> Hi all,
>
> this series is based on earlier patches from Sagi and fixes up
> nvme_update_disk_info so that we properly configure discard and
> write zeroes for the multipath device node.

all this series looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
