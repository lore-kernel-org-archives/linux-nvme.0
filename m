From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 14:26:57 -0700
Subject: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <20180301142155.5966c4c0@w520.home>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
 <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>
 <20180301142155.5966c4c0@w520.home>
Message-ID: <8202ea69-f0ed-db10-a0d3-9fd470c1c441@deltatee.com>



On 01/03/18 02:21 PM, Alex Williamson wrote:
> This is still a pretty terrible solution though, your kernel provider
> needs to decide whether they favor device assignment or p2p, because we
> can't do both, unless there's a patch I haven't seen yet that allows
> boot time rather than compile time configuration.  There are absolutely
> supported device assignment cases of switches proving isolation between
> devices allowing the downstream EPs to be used independently.  I think
> this is a non-starter for distribution support without boot time or
> dynamic configuration.  I could imagine dynamic configuration through
> sysfs that might trigger a soft remove and rescan of the affected
> devices in order to rebuild the IOMMU group.  The hard part might be
> determining which points to allow that to guarantee correctness.  For
> instance, upstream switch ports don't actually support ACS, but they'd
> otherwise be an obvious concentration point to trigger a
> reconfiguration.  Thanks,

At this point, I don't expect this to be enabled in any distribution. 
The use case is for custom hardware intended to do P2P which means they 
can have a custom kernel with P2P enabled. The default for 
CONFIG_PCI_P2P is 'no' and I expect it to stay that way for a long time.

Another boot option which has to be set for this to work isn't something 
we'd like to see.

Logan
