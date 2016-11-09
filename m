From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 Nov 2016 22:45:05 +0100
Subject: rework NVMe command passthrough
In-Reply-To: <20161109200027.GB3409@localhost.localdomain>
References: <1477411779-2993-1-git-send-email-hch@lst.de>
 <20161109193956.GA29228@lst.de> <20161109200027.GB3409@localhost.localdomain>
Message-ID: <20161109214505.GA32145@lst.de>

On Wed, Nov 09, 2016@03:00:27PM -0500, Keith Busch wrote:
> On Wed, Nov 09, 2016@08:39:56PM +0100, Christoph Hellwig wrote:
> > Jens, Keith:
> > 
> > any opinion on this series?  I'd really prefer to have something
> > like this in before merging the NVMe FC support.
> 
> Other than the issue you already pointed out in 2/2, this looks good to
> me. You can add my review if you just want to make the one fix and push
> to the nvme tree.
> 
> Reviewed-by: Keith Busch <keith.busch at intel.com>

Thanks.  I haven't had time to set the grand unified nvme tree up
yet, so for now we'll need Jens to apply it directly still after I resend.
Just doing a quick test run and it will be out ASAP.
