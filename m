From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 10 May 2018 14:20:00 +0000
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <20180509174952.GC4140@redhat.com>
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
 <20180509174952.GC4140@redhat.com>
Message-ID: <405531AE-8315-4A4F-9B0C-8DBE49BFCAB4@raithlin.com>

Hi Jerome

> As it is tie to PASID this is done using IOMMU so looks for caller
> of amd_iommu_bind_pasid() or intel_svm_bind_mm() in GPU the existing
>  user is the AMD GPU driver see:
    
Ah thanks. This cleared things up for me. A quick search shows there are still no users of intel_svm_bind_mm() but I see the AMD version used in that GPU driver.

One thing I could not grok from the code how the GPU driver indicates which DMA events require ATS translations and which do not. I am assuming the driver implements someway of indicating that and its not just a global ON or OFF for all DMAs? The reason I ask is that I looking at if NVMe was to support ATS what would need to be added in the NVMe spec above and beyond what we have in PCI ATS to support efficient use of ATS (for example would we need a flag in the submission queue entries to indicate a particular IO's SGL/PRP should undergo ATS).

Cheers

Stephen    
