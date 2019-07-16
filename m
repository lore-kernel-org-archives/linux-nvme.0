From: hch@lst.de (Christoph Hellwig)
Date: Tue, 16 Jul 2019 07:59:14 +0200
Subject: [PATCH 1/3] nvme: Pass the queue to SQ_SIZE/CQ_SIZE macros
In-Reply-To: <20190716004649.17799-1-benh@kernel.crashing.org>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
Message-ID: <20190716055914.GA29414@lst.de>

On Tue, Jul 16, 2019@10:46:47AM +1000, Benjamin Herrenschmidt wrote:
> This will make it easier to handle variable queue entry sizes
> later. No functional change.

Looks good to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
