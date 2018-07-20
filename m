From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 20 Jul 2018 07:49:49 -0700
Subject: [RCF PATCH 2/2] nvme-pci: Bounce data from Host memory to CMB
 Memory
In-Reply-To: <20180720142343.GB4093@localhost.localdomain>
References: <20180719230628.31494-1-scott.bauer@intel.com>
 <20180719230628.31494-3-scott.bauer@intel.com>
 <20180720142343.GB4093@localhost.localdomain>
Message-ID: <20180720144949.GC29886@infradead.org>

On Fri, Jul 20, 2018@08:23:43AM -0600, Keith Busch wrote:
> On Thu, Jul 19, 2018@05:06:28PM -0600, Scott Bauer wrote:
> > Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> 
> What does this gain us? I don't think this would do anything except
> increase the CPU utilization. If this actually buys additional
> performance, could you include some relative data and workload
> characteristics in the changelog?

Yes, as-is this seems rather counter productive..
