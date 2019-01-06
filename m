From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 6 Jan 2019 14:21:53 +0200
Subject: [PATCH 1/1] nvme-pci: check that sqid match in nvme cqe
In-Reply-To: <20190104181336.GA25593@lst.de>
References: <1546349838-5126-1-git-send-email-maxg@mellanox.com>
 <20190104181336.GA25593@lst.de>
Message-ID: <d45e8fe6-5c58-f8f5-5b74-3e261222e089@mellanox.com>


On 1/4/2019 8:13 PM, Christoph Hellwig wrote:
> On Tue, Jan 01, 2019@03:37:18PM +0200, Max Gurtovoy wrote:
>> This patch protects against faulty drives (e.g: a drive might send
>> the completion on a wrong msix).
> Where/how do you see this issue?

maybe it wasn't a good example but let's say I can change 1 line in QEMU 
code (@hw/block/nvme.c) to trigger this issue.

if I'll change

req->cqe.sq_id = cpu_to_le16(sq->sqid);

to be

req->cqe.sq_id = 0;

we'll always get wrong sq_id except of admin queue commands.

This patch tries to protect against HW/FW bugs and we need to decide if 
it's in of our driver interest to do so.

if not, let's abandon this commit.
