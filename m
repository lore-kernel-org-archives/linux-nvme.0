From: james.p.freyensee@intel.com (Freyensee, James P)
Date: Tue, 7 Jun 2016 15:15:31 +0000
Subject: [PATCH 5/5] nvme-rdma: add a NVMe over Fabrics RDMA host driver
In-Reply-To: <20160607144753.GA28414@localhost.localdomain>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-6-git-send-email-hch@lst.de>
 <20160607144753.GA28414@localhost.localdomain>
Message-ID: <1465312530.3505.2.camel@intel.com>

On Tue, 2016-06-07@10:47 -0400, Keith Busch wrote:
> On Mon, Jun 06, 2016@11:23:35PM +0200, Christoph Hellwig wrote:
> > To connect to all NVMe over Fabrics controller reachable on a given
> > taget
> > port using RDMA/CM use the following command:
> > 
> > 	nvme connect-all -t rdma -a $IPADDR
> > 
> > This requires the latest version of nvme-cli with Fabrics support.
> 
> Is there a public fork or patch set available for the user tools? I'd
> be happy to merge that in.
> 
> Overall, this whole series is looking really good. 

Special thanks to Sagi and Christoph for organizing all the patches of
this code project into a dynamite submission series for these mailing
lists.

> I'll try this out on
> some machines today.
