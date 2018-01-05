From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 4 Jan 2018 17:00:47 -0700
Subject: [PATCH 04/12] pci-p2p: Clear ACS P2P flags for all client devices
In-Reply-To: <20180104153551.3118f71b@t450s.home>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-5-logang@deltatee.com>
 <20180104215721.GF189897@bhelgaas-glaptop.roam.corp.google.com>
 <20180104153551.3118f71b@t450s.home>
Message-ID: <20fdb5bb-0236-c093-ed53-e12664022f53@deltatee.com>



On 04/01/18 03:35 PM, Alex Williamson wrote:
> Yep, flipping these ACS bits invalidates any IOMMU groups that depend
> on the isolation of that downstream port and I suspect also any peers
> within the same PCI slot of that port and their downstream devices.  The
> entire sub-hierarchy grouping needs to be re-evaluated.  This
> potentially affects running devices that depend on that isolation, so
> I'm not sure how that happens dynamically.  A boot option might be
> easier.  Thanks,

I don't see how this is the case in current kernel code. It appears to 
only enable ACS globally if the IOMMU requests it.

I also don't see how turning off ACS isolation for a specific device is 
going to hurt anything. The IOMMU should still be able to keep going on 
unaware that anything has changed. The only worry is that a security 
hole may now be created if a user was relying on the isolation between 
two devices that are in different VMs or something. However, if a user 
was relying on this, they probably shouldn't have turned on P2P in the 
first place.

We started with a fairly unintelligent choice to simply disable ACS on 
any kernel that had CONFIG_PCI_P2P set. However, this did not seem like 
a good idea going forward. Instead, we now selectively disable the ACS 
bit only on the downstream ports that are involved in P2P transactions. 
This seems like the safest choice and still allows people to (carefully) 
use P2P adjacent to other devices that need to be isolated.

I don't think anyone wants another boot option that must be set in order 
to use this functionality (and only some hardware would require this). 
That's just a huge pain for users.

Logan
