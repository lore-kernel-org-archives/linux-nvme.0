From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Dec 2016 13:07:24 -0500
Subject: [PATCH] nvme: support bi-directional commands
In-Reply-To: <20161207174427.GA25211@lst.de>
References: <1481132364-20583-1-git-send-email-keith.busch@intel.com>
 <20161207173323.GA24967@lst.de>
 <20161207175049.GD29574@localhost.localdomain>
 <20161207174427.GA25211@lst.de>
Message-ID: <20161207180723.GE29574@localhost.localdomain>

On Wed, Dec 07, 2016@06:44:27PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 07, 2016@12:50:50PM -0500, Keith Busch wrote:
> > NVMe defines this capability, so why would we want to make it unreachable
> > in Linux?
> 
> NVMe defines no user of it, so that defintion is entirely theoretical
> and it's a giant mess

It defines the use, but no user today. We can burn that bridge when we
get there.
