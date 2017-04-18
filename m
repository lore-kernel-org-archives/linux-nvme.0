From: roger.pau@citrix.com (Roger Pau =?iso-8859-1?Q?Monn=E9?=)
Date: Tue, 18 Apr 2017 16:00:51 +0100
Subject: [PATCH 16/25] xen-blkfront: don't use req->errors
In-Reply-To: <20170406153944.10058-17-hch@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-17-hch@lst.de>
Message-ID: <20170418150051.muglaxwfydaxypd6@dhcp-3-128.uk.xensource.com>

On Thu, Apr 06, 2017@05:39:35PM +0200, Christoph Hellwig wrote:
> xen-blkfron is the last users using rq->errros for passing back error to
> blk-mq, and I'd like to get rid of that.  In the longer run the driver
> should be moving more of the completion processing into .complete, but
> this is the minimal change to move forward for now.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Acked-by: Roger Pau Monn? <roger.pau at citrix.com>
