From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Mon, 12 Oct 2015 09:03:52 -0700
Subject: [PATCH 1/2] powerpc/iommu: expose IOMMU page shift
In-Reply-To: <20151006031943.GC3861@voom.fritz.box>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
 <20151006031943.GC3861@voom.fritz.box>
Message-ID: <20151012160352.GA24212@linux.vnet.ibm.com>

On 06.10.2015 [14:19:43 +1100], David Gibson wrote:
> On Fri, Oct 02, 2015@10:18:00AM -0700, Nishanth Aravamudan wrote:
> > We will leverage this macro in the NVMe driver, which needs to know the
> > configured IOMMU page shift to properly configure its device's page
> > size.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc at linux.vnet.ibm.com>
> > 
> > ---
> > Given this is available, it seems reasonable to expose -- and it doesn't
> > really make sense to make the driver do a log2 call on the existing
> > IOMMU_PAGE_SIZE() value.
> > 
> > diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> > index ca18cff..6fdf857 100644
> > --- a/arch/powerpc/include/asm/iommu.h
> > +++ b/arch/powerpc/include/asm/iommu.h
> > @@ -36,6 +36,7 @@
> >  #define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
> >  #define IOMMU_PAGE_ALIGN_4K(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE_4K)
> >  
> > +#define IOMMU_PAGE_SHIFT(tblptr) (tblptr)->it_page_shift
> >  #define IOMMU_PAGE_SIZE(tblptr) (ASM_CONST(1) << (tblptr)->it_page_shift)
> 
> Seems like it would be a touch safer to alter IOMMU_PAGE_SIZE so it
> uses the new IOMMU_PAGE_SHIFT macro.

Yes absolutely! Sorry, I initially didn't add the first macro, so didn't
think that through. Will update.

-Nish
