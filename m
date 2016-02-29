From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Feb 2016 15:42:52 +0000
Subject: [PATCH 4/4] nvme: return the whole CQE through the request
 passthrough interface
In-Reply-To: <1456757987-7244-5-git-send-email-hch@lst.de>
References: <1456757987-7244-1-git-send-email-hch@lst.de>
 <1456757987-7244-5-git-send-email-hch@lst.de>
Message-ID: <20160229154251.GA15406@localhost.localdomain>

On Mon, Feb 29, 2016@03:59:47PM +0100, Christoph Hellwig wrote:
> Both LighNVM and NVMe over Fabrics need to look at more than just the
> status and result field.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Matias Bj?rling <m at bjorling.me>
> Reviewed-by: Jay Freyensee <james.p.freyensee at intel.com>
> Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
> Signed-off-by: Sagi Grimberg <sagig at mellanox.com>

Looks good,

Reviewed-by: Keith Busch <keith.busch at intel.com>
