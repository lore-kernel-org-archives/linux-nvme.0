From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Oct 2016 19:01:16 +0200
Subject: [PATCH v3 3/6] rdma_cm: add rdma_consumer_reject_data helper
 function
In-Reply-To: <7690d653aefbf9ff51dfa6c1ebef57b47616be23.1477336045.git.swise@opengridcomputing.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <7690d653aefbf9ff51dfa6c1ebef57b47616be23.1477336045.git.swise@opengridcomputing.com>
Message-ID: <20161025170116.GC9732@lst.de>

On Mon, Oct 24, 2016@11:59:03AM -0700, Steve Wise wrote:
> rdma_consumer_reject_data() will return the private data pointer
> and length if any is available.
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
