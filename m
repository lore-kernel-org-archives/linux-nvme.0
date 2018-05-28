From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:22:25 +0200
Subject: [PATCH 04/17] IB/isert: use T10-PI check mask definitions from
 core layer
In-Reply-To: <1527436222-15494-5-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-5-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072225.GE5618@lst.de>

On Sun, May 27, 2018@06:50:09PM +0300, Max Gurtovoy wrote:
> No reason to use hard-coded protection information checks in ib_isert driver.
> Use check masks from RDMA core driver.

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
