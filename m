From: scott.bauer@intel.com (Scott Bauer)
Date: Fri, 20 Jul 2018 08:53:02 -0600
Subject: [RCF PATCH 2/2] nvme-pci: Bounce data from Host memory to CMB
 Memory
In-Reply-To: <20180720144949.GC29886@infradead.org>
References: <20180719230628.31494-1-scott.bauer@intel.com>
 <20180719230628.31494-3-scott.bauer@intel.com>
 <20180720142343.GB4093@localhost.localdomain>
 <20180720144949.GC29886@infradead.org>
Message-ID: <20180720145301.GC9294@sbauer-Z170X-UD5>

On Fri, Jul 20, 2018@07:49:49AM -0700, Christoph Hellwig wrote:
> On Fri, Jul 20, 2018@08:23:43AM -0600, Keith Busch wrote:
> > On Thu, Jul 19, 2018@05:06:28PM -0600, Scott Bauer wrote:
> > > Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> > 
> > What does this gain us? I don't think this would do anything except
> > increase the CPU utilization. If this actually buys additional
> > performance, could you include some relative data and workload
> > characteristics in the changelog?
> 
> Yes, as-is this seems rather counter productive..

Unfortunately I still don't have a drive to do perf testing on. The
only thing I can do is quickly hack this into QEMU, but I suspect that's
far too different to get us any relevant numbers.
