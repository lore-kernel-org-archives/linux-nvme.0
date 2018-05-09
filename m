From: jglisse@redhat.com (Jerome Glisse)
Date: Wed, 9 May 2018 13:49:53 -0400
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
References: <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
 <20180509160722.GB4140@redhat.com>
 <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
Message-ID: <20180509174952.GC4140@redhat.com>

On Wed, May 09, 2018@04:30:32PM +0000, Stephen  Bates wrote:
> Hi Jerome
> 
> > Now inside that page table you can point GPU virtual address
> > to use GPU memory or use system memory. Those system memory entry can
> > also be mark as ATS against a given PASID.
>     
> Thanks. This all makes sense. 
> 
> But do you have examples of this in a kernel driver (if so can you point me too it) or is this all done via user-space? Based on my grepping of the kernel code I see zero EP drivers using in-kernel ATS functionality right now...
> 

As it is tie to PASID this is done using IOMMU so looks for caller
of amd_iommu_bind_pasid() or intel_svm_bind_mm() in GPU the existing
user is the AMD GPU driver see:

drivers/gpu/drm/amd/
drivers/gpu/drm/amd/amdkfd/
drivers/gpu/drm/amd/amdgpu/

Lot of codes there. The GPU code details do not really matter for
this discussions thought. You do not need to do much to use PASID.

Cheers,
J?r?me
