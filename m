From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 5 Jan 2018 10:10:51 -0700
Subject: [PATCH 04/12] pci-p2p: Clear ACS P2P flags for all client devices
In-Reply-To: <20180104203300.79487c98@w520.home>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-5-logang@deltatee.com>
 <20180104215721.GF189897@bhelgaas-glaptop.roam.corp.google.com>
 <20180104153551.3118f71b@t450s.home>
 <20fdb5bb-0236-c093-ed53-e12664022f53@deltatee.com>
 <20180104203300.79487c98@w520.home>
Message-ID: <77ec7893-6ff5-ebdf-163d-fc4e02077cc2@deltatee.com>



On 04/01/18 08:33 PM, Alex Williamson wrote:
> That's exactly what IOMMU groups represent, the smallest set of devices
> which have DMA isolation from other devices.  By poking this hole, the
> IOMMU group is invalid.  We cannot turn off ACS only for a specific
> device, in order to enable p2p it needs to be disabled at every
> downstream port between the devices where we want to enable p2p.
> Depending on the topology, that could mean we're also enabling p2p for
> unrelated devices.  Those unrelated devices might be in active use and
> the p2p IOVAs now have a different destination which is no longer IOMMU
> translated.

Oh, so IOMMU groups are created based on the existing hierarchy at boot 
time and not based on the user's needs for isolation?

Logan
