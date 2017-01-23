From: hch@lst.de (Christoph Hellwig)
Date: Mon, 23 Jan 2017 19:38:15 +0100
Subject: [PATCH 1/1] nvmet: avoid dereferencing nvmet_req
In-Reply-To: <1485162072-10335-1-git-send-email-maxg@mellanox.com>
References: <1485162072-10335-1-git-send-email-maxg@mellanox.com>
Message-ID: <20170123183815.GA24026@lst.de>

On Mon, Jan 23, 2017@11:01:12AM +0200, Max Gurtovoy wrote:
> No need to dereference req twice to get the cmd when we already
> have it stored in a local variable.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> Reviewed-by: Parav Pandit <parav at mellanox.com>

Looks good (for 4.11)
