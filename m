From: kbusch@kernel.org (Keith Busch)
Date: Thu, 23 May 2019 09:42:39 -0600
Subject: [PATCHv3 1/2] nvme: Export get and set features
In-Reply-To: <20190523153626.GA21238@lst.de>
References: <20190523152735.15052-1-keith.busch@intel.com>
 <20190523153626.GA21238@lst.de>
Message-ID: <20190523154239.GC14943@localhost.localdomain>

On Thu, May 23, 2019@05:36:26PM +0200, Christoph Hellwig wrote:
> > Change since v2: Use 'unsigned int' instead of just 'unsiged'
> 
> Those are equivalent in C, why bother changing it?

Just to shut up checkpatch.pl:

  WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
 
> > +int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid, unsigned int dword11,
> 
> Especially as this now creates lines > 80 characters in various places.

*facepalm*
