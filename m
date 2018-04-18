From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Apr 2018 17:34:45 +0200
Subject: [PATCH] nvme: Fix disk names when not using nvme multipath
In-Reply-To: <20180418153410.GM11513@localhost.localdomain>
References: <20180417220344.14698-1-keith.busch@intel.com>
 <20180418064412.GB11757@lst.de>
 <20180418132657.GJ11513@localhost.localdomain> <20180418150429.GA7862@lst.de>
 <20180418153410.GM11513@localhost.localdomain>
Message-ID: <20180418153445.GA8513@lst.de>

On Wed, Apr 18, 2018@09:34:11AM -0600, Keith Busch wrote:
> I think the permissions just have to be 0444 so that the user can't change the
> naming method after some disks were named with the alternate method.

True.  We should do that anyway.  I'll turn this into a real series
with a few more final touches tomorrow.
