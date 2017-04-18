From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 18 Apr 2017 11:06:09 -0400
Subject: [PATCH 17/25] blk-mq: remove the error argument to
 blk_mq_complete_request
In-Reply-To: <20170418150321.s7yqpt63reutbs24@dhcp-3-128.uk.xensource.com>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-18-hch@lst.de>
 <20170418150321.s7yqpt63reutbs24@dhcp-3-128.uk.xensource.com>
Message-ID: <20170418150609.GB12001@char.us.oracle.com>

On Tue, Apr 18, 2017@04:03:21PM +0100, Roger Pau Monn? wrote:
> On Thu, Apr 06, 2017@05:39:36PM +0200, Christoph Hellwig wrote:
> > Now that we always have a ->complete callback we can remove the direct
> > call to blk_mq_end_request, as well as the error argument to
> > blk_mq_complete_request.
> > 
> > Signed-off-by: Christoph Hellwig <hch at lst.de>
> 
> For blkfront:
> 
> Acked-by: Roger Pau Monn? <roger.pau at citrix.com>
> 

And also
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk at oracle.com>
