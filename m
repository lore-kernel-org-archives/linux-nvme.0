From: kbusch@kernel.org (Keith Busch)
Date: Tue, 12 Mar 2019 09:59:17 -0600
Subject: [PATCH 1/3] nvme: remove nvme_ns_config_oncs
In-Reply-To: <20190312152453.9550-2-hch@lst.de>
References: <20190312152453.9550-1-hch@lst.de>
 <20190312152453.9550-2-hch@lst.de>
Message-ID: <20190312155917.GA12696@localhost.localdomain>

On Tue, Mar 12, 2019@04:24:51PM +0100, Christoph Hellwig wrote:
> Just opencode the two function calls in the caller.

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
