From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 Sep 2017 09:53:16 -0600
Subject: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170925134031.10548-9-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
Message-ID: <20170928155315.GK8463@localhost.localdomain>

On Mon, Sep 25, 2017@03:40:30PM +0200, Christoph Hellwig wrote:
> The new block devices nodes for multipath access will show up as
> 
> 	/dev/nvm-subXnZ

Just thinking ahead ... Once this goes in, someone will want to boot their
OS from a multipath target. It was a pain getting installers to recognize
/dev/nvmeXnY as an install destination. I'm not sure if installers have
gotten any better in the last 5 years about recognizing new block names.
