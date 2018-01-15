From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 15 Jan 2018 09:20:40 -0700
Subject: [PATCH] nvme/pci: Check segement valid for SGL use
In-Reply-To: <20180115160148.GA9749@lst.de>
References: <20180115130723.31469-1-keith.busch@intel.com>
 <20180115160148.GA9749@lst.de>
Message-ID: <04bc104b-34c6-ecd6-63a2-fc775b554dff@kernel.dk>

On 1/15/18 9:01 AM, Christoph Hellwig wrote:
> Actually this needs to go into nvme-4.15.  The offending commit is
> only in 4.15-rc, and not in nvme-4.16 or Jens' for-4.16 tree.

I can queue it up for 4.15, there's already been one report of
this...

-- 
Jens Axboe
