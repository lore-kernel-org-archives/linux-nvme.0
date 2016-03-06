From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 5 Mar 2016 22:20:37 -0800
Subject: [PATCH] NVMe: Create discard zero quirk white list
In-Reply-To: <20160305223949.GD5530@linux.intel.com>
References: <1457113522-14099-1-git-send-email-keith.busch@intel.com>
 <20160304180443.GA3972@infradead.org>
 <20160305223949.GD5530@linux.intel.com>
Message-ID: <20160306062037.GA15050@infradead.org>

On Sat, Mar 05, 2016@05:39:49PM -0500, Matthew Wilcox wrote:
> > Meh, indeed:
> > 
> > "If a read occurs to a deallocated range, the controller shall return
> > all zeros, all ones, or the last data written to the associated LBA."
> > 
> > time to write a TP for a bit on the identify page..
> 
> Since we have a WRITE ZEROES command, do we need this?

WRITE ZEROES has no way to request deallocating blocks.  It's the moral
equivalent of a WRITE SAME without the unmap bit of all zeroes.
