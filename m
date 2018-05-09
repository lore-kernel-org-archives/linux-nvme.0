From: sbates@raithlin.com (Stephen  Bates)
Date: Wed, 9 May 2018 13:12:53 +0000
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <20180508205005.GC15608@redhat.com>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
Message-ID: <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>

Jerome and Christian
    
> I think there is confusion here, Alex properly explained the scheme
> PCIE-device do a ATS request to the IOMMU which returns a valid
> translation for a virtual address. Device can then use that address
> directly without going through IOMMU for translation.

So I went through ATS in version 4.0r1 of the PCI spec. It looks like even a ATS translated TLP is still impacted by ACS though it has a separate control knob for translated address TLPs (see 7.7.7.2 of 4.0r1 of the spec). So even if your device supports ATS a P2P DMA will still be routed to the associated RP of the domain and down again unless we disable ACS DT P2P on all bridges between the two devices involved in the P2P DMA. 

So we still don't get fine grained control with ATS and I guess we still have security issues because a rogue or malfunctioning EP could just as easily issue TLPs with TA set vs not set.

> Also ATS is meaningless without something like PASID as far as i know.
    
ATS is still somewhat valuable without PSAID in the sense you can cache IOMMU address translations at the EP. This saves hammering on the IOMMU as much in certain workloads.

Interestingly Section 7.7.7.2 almost mentions that Root Ports that support ATS AND can implement P2P between root ports should advertise "ACS Direct Translated P2P (T)" capability. This ties into the discussion around P2P between route ports we had a few weeks ago...

Stephen    
