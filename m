From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 1 Aug 2016 04:20:35 -0700
Subject: [PATCH 3/3] nvme-fabrics: Add host_traddr options field to host
 infrastructure
In-Reply-To: <579a9c9b.pfetMBhIGNhCI9uD%james.smart@broadcom.com>
References: <579a9c9b.pfetMBhIGNhCI9uD%james.smart@broadcom.com>
Message-ID: <20160801112035.GD28246@infradead.org>

On Thu, Jul 28, 2016@05:00:27PM -0700, James Smart wrote:
> 
> Add the host_traddr field to allow specification of the host-port
> connection info for the transport. Will be used by FC transport.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
