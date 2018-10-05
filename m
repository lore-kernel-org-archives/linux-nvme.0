From: hch@lst.de (Christoph Hellwig)
Date: Fri, 5 Oct 2018 09:09:13 +0200
Subject: [PATCH v9 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
In-Reply-To: <20181004212747.6301-8-logang@deltatee.com>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-8-logang@deltatee.com>
Message-ID: <20181005070913.GD23761@lst.de>

On Thu, Oct 04, 2018@03:27:41PM -0600, Logan Gunthorpe wrote:
> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> supports targeting P2P memory. This will be used by P2P providers and
> orchestrators (in subsequent patches) to ensure block devices can
> support P2P memory before submitting P2P backed pages to submit_bio().
> 
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>

Reviewed-by: Christoph Hellwig <hch at lst.de>
