From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Jun 2017 18:36:11 +0300
Subject: [PATCH 1/4] nvme-pci: merge init_request methods
In-Reply-To: <20170613071521.5191-1-hch@lst.de>
References: <20170613071521.5191-1-hch@lst.de>
Message-ID: <59d60648-24aa-9bdd-d084-1986b9f04fb0@mellanox.com>



On 6/13/2017 10:15 AM, Christoph Hellwig wrote:
> Now that we get the tagset passed we can have a single implementation for
> the I/O and admin queues.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/pci.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
>

Look good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
