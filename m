From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Oct 2016 19:00:47 +0200
Subject: [PATCH v3 2/6] rdma_cm: add rdma_is_consumer_reject() helper
 function
In-Reply-To: <66890f3b3abede2fe9fa658b91450c24ab516ed1.1477336045.git.swise@opengridcomputing.com>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <66890f3b3abede2fe9fa658b91450c24ab516ed1.1477336045.git.swise@opengridcomputing.com>
Message-ID: <20161025170047.GB9732@lst.de>

On Mon, Oct 24, 2016@11:59:03AM -0700, Steve Wise wrote:
> Return true if the peer consumer application rejected the
> connection attempt.
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
