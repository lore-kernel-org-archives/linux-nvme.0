From: david@gibson.dropbear.id.au (David Gibson)
Date: Tue, 6 Oct 2015 14:19:43 +1100
Subject: [PATCH 1/2] powerpc/iommu: expose IOMMU page shift
In-Reply-To: <20151002171800.GB41011@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
Message-ID: <20151006031943.GC3861@voom.fritz.box>

On Fri, Oct 02, 2015@10:18:00AM -0700, Nishanth Aravamudan wrote:
> We will leverage this macro in the NVMe driver, which needs to know the
> configured IOMMU page shift to properly configure its device's page
> size.
> 
> Signed-off-by: Nishanth Aravamudan <nacc at linux.vnet.ibm.com>
> 
> ---
> Given this is available, it seems reasonable to expose -- and it doesn't
> really make sense to make the driver do a log2 call on the existing
> IOMMU_PAGE_SIZE() value.
> 
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index ca18cff..6fdf857 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -36,6 +36,7 @@
>  #define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
>  #define IOMMU_PAGE_ALIGN_4K(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE_4K)
>  
> +#define IOMMU_PAGE_SHIFT(tblptr) (tblptr)->it_page_shift
>  #define IOMMU_PAGE_SIZE(tblptr) (ASM_CONST(1) << (tblptr)->it_page_shift)

Seems like it would be a touch safer to alter IOMMU_PAGE_SIZE so it
uses the new IOMMU_PAGE_SHIFT macro.

>  #define IOMMU_PAGE_MASK(tblptr) (~((1 << (tblptr)->it_page_shift) - 1))
>  #define IOMMU_PAGE_ALIGN(addr, tblptr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE(tblptr))
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151006/655bdd8a/attachment.sig>
