From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:22:09 +0200
Subject: [PATCH 03/17] IB/iser: use T10-PI check mask definitions from
 core layer
In-Reply-To: <1527436222-15494-4-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-4-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072209.GD5618@lst.de>

On Sun, May 27, 2018@06:50:08PM +0300, Max Gurtovoy wrote:
> No reason to re-define protection information check in ib_iser driver.
> Use check masks from RDMA core driver.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
