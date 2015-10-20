From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 20 Oct 2015 13:07:06 +0300
Subject: [PATCH 03/18] nvme: split command submission helpers out of pci.c
In-Reply-To: <1444975128-8768-4-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-4-git-send-email-hch@lst.de>
Message-ID: <5626124A.7000709@dev.mellanox.co.il>

On 10/16/2015 8:58 AM, Christoph Hellwig wrote:
> Create a new core.c and start by adding the command submission helpers
> to it, which are already abstracted away from the actual hardware queues
> by the block layer.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Acked-by: Keith Busch <keith.busch at intel.com>

looks good to me,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
