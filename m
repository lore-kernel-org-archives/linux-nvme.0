From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:26:40 +0200
Subject: [PATCH 12/17] nvme-rdma: Introduce nvme_rdma_set_keyed_sgl
 helper func
In-Reply-To: <1527436222-15494-13-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-13-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072640.GK5618@lst.de>

On Sun, May 27, 2018@06:50:17PM +0300, Max Gurtovoy wrote:
> This function will be used to avoid code duplication while
> setting keyed sgl fields.

Does this really buy us anything?

> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  drivers/nvme/host/rdma.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)

Because the diffstate doesn't look very promising, and the code isn't
really more readable either.
