From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 Feb 2016 10:40:31 -0800
Subject: [PATCH for-4.5 04/13] NVMe: Set queue limits max_dev_sectors
In-Reply-To: <20160210182416.GC32064@localhost.localdomain>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-5-git-send-email-keith.busch@intel.com>
 <20160210182051.GA28235@infradead.org>
 <20160210182416.GC32064@localhost.localdomain>
Message-ID: <20160210184031.GB7512@infradead.org>

On Wed, Feb 10, 2016@06:24:17PM +0000, Keith Busch wrote:
> On Wed, Feb 10, 2016@10:20:51AM -0800, Christoph Hellwig wrote:
> > On Wed, Feb 10, 2016@11:17:21AM -0700, Keith Busch wrote:
> > > Signed-off-by: Keith Busch <keith.busch at intel.com>
> > 
> > why?
> 
> Ah, missing change log here.
> 
> It is so the queue limits will be correct. The max_hw_sectors will be
> wrong without this.

How so?  We only ever look at max_dev_sectors in blk_queue_max_hw_sectors
and blk_stack_limits, and both do a min_not_zero.  A zero max_dev_sectors
should thus be perfectly fine, and in fact no one but the SCSI disk
driver even bothers to set one.

Ohh, I see now - blk_set_default_limits initializes max_dev_sectors to
BLK_SAFE_MAX_SECTORS instead of leaving it as zero.  I think that's the
issue which needs to be fixed.
