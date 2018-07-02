From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Jul 2018 15:16:10 +0200
Subject: [PATCH v2 1/1] nvmet-rdma: Add an error flow for post_recv
 failures
In-Reply-To: <1530436824-18229-1-git-send-email-maxg@mellanox.com>
References: <1530436824-18229-1-git-send-email-maxg@mellanox.com>
Message-ID: <20180702131610.GF4624@lst.de>

On Sun, Jul 01, 2018@12:20:24PM +0300, Max Gurtovoy wrote:
> Posting receive buffer operation can fail, thus we should make
> sure to have an error flow during initialization phase. While
> we're here, add a debug print in case of a failure.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

Looks fine to me.  Do you see an urgent enough issue to queue this
up for 4.18 or can it wait for 4.19?
