From: hch@lst.de (Christoph Hellwig)
Date: Mon, 15 Jan 2018 18:22:18 +0100
Subject: [PATCH] nvme/pci: Check segement valid for SGL use
In-Reply-To: <04bc104b-34c6-ecd6-63a2-fc775b554dff@kernel.dk>
References: <20180115130723.31469-1-keith.busch@intel.com>
 <20180115160148.GA9749@lst.de>
 <04bc104b-34c6-ecd6-63a2-fc775b554dff@kernel.dk>
Message-ID: <20180115172218.GA12251@lst.de>

On Mon, Jan 15, 2018@09:20:40AM -0700, Jens Axboe wrote:
> On 1/15/18 9:01 AM, Christoph Hellwig wrote:
> > Actually this needs to go into nvme-4.15.  The offending commit is
> > only in 4.15-rc, and not in nvme-4.16 or Jens' for-4.16 tree.
> 
> I can queue it up for 4.15, there's already been one report of
> this...

I think we'll need at least another related fix as well.  I'll
send you a pull request by tomorrow or so.
