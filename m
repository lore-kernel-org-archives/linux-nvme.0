From: roger.pau@citrix.com (Roger Pau =?iso-8859-1?Q?Monn=E9?=)
Date: Tue, 18 Apr 2017 16:03:21 +0100
Subject: [PATCH 17/25] blk-mq: remove the error argument to
 blk_mq_complete_request
In-Reply-To: <20170406153944.10058-18-hch@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-18-hch@lst.de>
Message-ID: <20170418150321.s7yqpt63reutbs24@dhcp-3-128.uk.xensource.com>

On Thu, Apr 06, 2017@05:39:36PM +0200, Christoph Hellwig wrote:
> Now that we always have a ->complete callback we can remove the direct
> call to blk_mq_end_request, as well as the error argument to
> blk_mq_complete_request.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

For blkfront:

Acked-by: Roger Pau Monn? <roger.pau at citrix.com>
