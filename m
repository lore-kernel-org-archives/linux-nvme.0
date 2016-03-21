From: keith.busch@intel.com (Keith Busch)
Date: Mon, 21 Mar 2016 16:29:31 +0000
Subject: [PATCH RFC] nvme: rewrite discard support
In-Reply-To: <20160321155736.GA14643@lst.de>
References: <1458170132-16031-1-git-send-email-mlin@kernel.org>
 <20160317153335.GB6217@localhost.lm.intel.com>
 <20160321144759.GA12934@lst.de>
 <20160321155138.GA19307@localhost.localdomain>
 <20160321155736.GA14643@lst.de>
Message-ID: <20160321162930.GB19307@localhost.localdomain>

On Mon, Mar 21, 2016@04:57:36PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 21, 2016@03:51:39PM +0000, Keith Busch wrote:
> > It looks like SCSI's special handling lead to what the code comments
> > describe as a "horrible hack", so that's not convincing this is a good
> > example to follow.
> 
> Nah, the "horrible hack" is adding a payload to the request.  We went
> over and over this and everyone but Kent agrees it's the least horrible
> option to handle discards in generic code.  NVMe side steps this a bit
> by not trying to handle this in common code, but that only works as
> long as it's a single tightly integrated driver, not for a layer
> architecture like SCSI, or what NVMe is increasingly moving to.

Fair enough. Every discard payload is specific to the protocol, so
understood on the need. General consensus prevails.

Let's see the next version. It'd be nice if we can get away with
allocating only the necessary amount for the payload.

Final comment on the original patch: it shouldn't return BLKPREP_DEFER
when out of memory as it's not applicable for blk-mq drivers.
