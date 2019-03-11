From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Mar 2019 19:33:24 +0100
Subject: [PATCH 7/8] nvme/pci: Remove volatile from cqe
In-Reply-To: <20190308174313.5134-7-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-7-keith.busch@intel.com>
Message-ID: <20190311183324.GG11448@lst.de>

On Fri, Mar 08, 2019@10:43:12AM -0700, Keith Busch wrote:
> The cqe isn't volatile once we confirm the phase bit. Remove the volatile
> keyword and let the compiler optimize out an unnecessary additional read
> to the command id.

Hmm.  I've never been happy about how we used volatile to start with,
but I'm not sure more casts sort out this problem.

Wouldn't the right fix be to drop the volatile entirely and force
a strong barrier before first reading the phase bit?
