From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 28 Sep 2018 08:12:57 -0600
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <20180927230557.29444-1-hch@lst.de>
References: <20180927230557.29444-1-hch@lst.de>
Message-ID: <20180928141256.GA21979@localhost.localdomain>

On Thu, Sep 27, 2018@04:05:57PM -0700, Christoph Hellwig wrote:
> Make current_path an array with an entry for every possible node, and
> cache the best path on a per-node basis.  Take the node distance into
> account when selecting it.  This is primarily useful for dual-ported PCIe
> devices which are connected to PCIe root ports on different sockets.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks great!

Reviewed-by: Keith Busch <keith.busch at intel.com>
