From: haggaie@mellanox.com (Haggai Eran)
Date: Tue, 2 Aug 2016 07:15:26 +0000
Subject: [RFC 6/7] NVMe: Use genalloc to allocate CMB regions
In-Reply-To: <20160801162057.GA11476@localhost.localdomain>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
 <1470034653-9097-7-git-send-email-haggaie@mellanox.com>
 <20160801155348.GB23224@infradead.org>
 <20160801162057.GA11476@localhost.localdomain>
Message-ID: <1470122126.20129.11.camel@mellanox.com>

On ?', 2016-08-01@10:20 -0600, Jon Derrick wrote:
> On Mon, Aug 01, 2016@08:53:49AM -0700, Christoph Hellwig wrote:
> > 
> > On Mon, Aug 01, 2016@09:57:32AM +0300, Haggai Eran wrote:
> > > 
> > > Register the CMB in a gen_pool dedicated to manage CMB regions.
> > > Use the
> > > pool to allocate the SQs to make sure they are registered.
> > And why would the NVMe driver care if "they are registered"?
> > 
> > Once we start allowing diverse CMB uses (what happened to Jon's
> > patches
> > btw?) genalloc might be a good backend allocator, but without that
> > it's entirely pointless.??Also please don't introduce useless
> > header
> > files.
> My concern is using CMB as a generic memory space could lead to
> invalid uses and untested paths in broken firmware (leading to
> bricked drives...). The spec defines what it's allowed to be used
> for, but doesn't really leave it open for general purpose usage
> outside of that. Because of that I think it needs more hand-holding
> by the kernel to prevent invalid usage.
I understand. Did you happen to think of how the kernel would expose
it?

> What I would like to see is a set of knobs controlling the 'chunks'
> of memory's usages (controlled through sysfs/configfs?) and the
> kernel takes care of allocation. My set was going to expose a
> resource file for WDS/RDS but everything else was unhandled except
> for its current sqes usage. I think the genalloc could fit into this
> scheme quite well.
What do you mean by a resource file? Are you referring to the
sysfs/configfs knob or to a file that exposes the resource to user-
space?

Thanks,
Haggai
