From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 May 2017 14:38:34 -0400
Subject: [PATCH nvme-cli] fabrics: add option to override drivers queue
 depth
In-Reply-To: <20170510144120.GA24518@lst.de>
References: <20170510090412.14132-1-jthumshirn@suse.de>
 <20170510144120.GA24518@lst.de>
Message-ID: <20170510183834.GH2572@localhost.localdomain>

On Wed, May 10, 2017@04:41:21PM +0200, Christoph Hellwig wrote:
> On Wed, May 10, 2017@11:04:12AM +0200, Johannes Thumshirn wrote:
> > Currently it is not possible to override the fabrics drivers default queue
> > depth with the nvme userspace utility, but only when manually writing the
> > parameters to the /dev/nvme-fabrics character device.
> > 
> > Add an option to override the drivers default queue depth for NVMe over
> > fabrics.
> 
> Looks fine, but we should probably also add this to connect-all.

Agreed. I applied the one as-is, and will apply the connect-all update
when that's posted.
