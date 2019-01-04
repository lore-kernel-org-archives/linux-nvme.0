From: keith.busch@intel.com (Keith Busch)
Date: Fri, 4 Jan 2019 11:19:48 -0700
Subject: [PATCH 1/4] nvme-pci: Set tagset nr_maps just once
In-Reply-To: <20190104181528.GA25651@lst.de>
References: <20190103210954.11129-1-keith.busch@intel.com>
 <20190104181528.GA25651@lst.de>
Message-ID: <20190104181947.GA12498@localhost.localdomain>

On Fri, Jan 04, 2019@07:15:28PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 03, 2019@02:09:51PM -0700, Keith Busch wrote:
> > The driver overwrites the intermediate nr_map assignments to
> > HCTX_MAX_TYPES, so remove those unnecessary temporary settings.
> > 
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> 
> Actually the more complex calculation is the right one here.
> I've just merged a patch from Jianchao to remove the other line.

Yep, I just saw that. Jianchao's is the right way to go here.
