From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 01 Aug 2016 14:32:59 -0700
Subject: [PATCH v2] nvme-cli: user-defined hostnqn option for discover
In-Reply-To: <20160801111859.GA28246@infradead.org>
References: <1469824719-7378-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1469824719-7378-2-git-send-email-james_p_freyensee@linux.intel.com>
 <20160801111859.GA28246@infradead.org>
Message-ID: <1470087179.6134.51.camel@linux.intel.com>

On Mon, 2016-08-01@04:18 -0700, Christoph Hellwig wrote:
> On Fri, Jul 29, 2016@01:38:39PM -0700, Jay Freyensee wrote:
> > The nvme-cli will always use the default hostnqn
> > in /dev/nvme-fabrics  for the discovery query, even though
> > both the NVMe Target and NVMe Host rdma implementations allow
> > user-defined hostnqn naming.
> > 
> > For example, this is the current, somewhat broken behavior if you
> > used your own hostnqn provision naming on the NVMe kernel target:
> 
> Maybe -n or -N would be a good choice for the short option flag?

I thought Roy's suggestion for -q was fine.

> 
> Otherwise this looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Cool, thanks.
> 
> Any chance you could also send a patch that reads /etc/nvme/hostnqn
> for a default hostnqn so that we can have a persistent one?

I'm a tad unclear what is the request? The default hostnqn is buried
inside /dev/nvme-fabrics.  You want nvme-cli to read out the default
hostnqn from /dev/nvme-fabrics and place it in  /etc/nvme/hostnqn?

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
