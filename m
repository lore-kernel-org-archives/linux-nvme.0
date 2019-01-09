From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 Jan 2019 19:35:21 +0100
Subject: [PATCH 1/1] nvme-pci: check that sqid match in nvme cqe
In-Reply-To: <d45e8fe6-5c58-f8f5-5b74-3e261222e089@mellanox.com>
References: <1546349838-5126-1-git-send-email-maxg@mellanox.com>
 <20190104181336.GA25593@lst.de>
 <d45e8fe6-5c58-f8f5-5b74-3e261222e089@mellanox.com>
Message-ID: <20190109183521.GA21992@lst.de>

On Sun, Jan 06, 2019@02:21:53PM +0200, Max Gurtovoy wrote:
> maybe it wasn't a good example but let's say I can change 1 line in QEMU 
> code (@hw/block/nvme.c) to trigger this issue.
>
> if I'll change
>
> req->cqe.sq_id = cpu_to_le16(sq->sqid);
>
> to be
>
> req->cqe.sq_id = 0;
>
> we'll always get wrong sq_id except of admin queue commands.
>
> This patch tries to protect against HW/FW bugs and we need to decide if 
> it's in of our driver interest to do so.
>
> if not, let's abandon this commit.

Yes, but hardware that gets this wrong will just blow up and timeout
anyway.  I'm not sure this case is worth adding a special detetion
in the slow path.
