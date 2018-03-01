From: jglisse@redhat.com (Jerome Glisse)
Date: Thu, 1 Mar 2018 16:35:33 -0500
Subject: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <EE1B4EB7-D3C0-4916-81CE-E647222D03E4@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
 <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>
 <20180301142155.5966c4c0@w520.home>
 <EE1B4EB7-D3C0-4916-81CE-E647222D03E4@raithlin.com>
Message-ID: <20180301213533.GE6742@redhat.com>

On Thu, Mar 01, 2018@09:32:20PM +0000, Stephen  Bates wrote:
> > your kernel provider needs to decide whether they favor device assignment or p2p
> 
> Thanks Alex! The hardware requirements for P2P (switch, high performance EPs) are such that we really only expect CONFIG_P2P_DMA to be enabled in specific instances and in those instances the users have made a decision to favor P2P over IOMMU isolation. Or they have setup their PCIe topology in a way that gives them IOMMU isolation where they want it and P2P where they want it.
> 
> 

Note that they are usecase for P2P where IOMMU isolation matter and
the traffic through root complex isn't see as an issue. For instance
for GPU the idea is that you want to allow the RDMA device to directly
read or write from GPU memory to avoid having to migrate memory to
system memory. This isn't so much for performance than for ease of
use.

Cheers,
J?r?me
