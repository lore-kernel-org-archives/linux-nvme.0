From: mpe@ellerman.id.au (Michael Ellerman)
Date: Tue, 06 Oct 2015 14:39:06 +1100
Subject: [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
In-Reply-To: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
Message-ID: <1444102746.16909.4.camel@ellerman.id.au>

On Sat, 2015-10-03@04:33 +0800, kbuild test robot wrote:
> Hi Nishanth,
> 
> [auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]
> 
> config: powerpc-defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    arch/powerpc/platforms/pseries/iommu.c: In function 'iommu_init_early_pSeries':
> >> arch/powerpc/platforms/pseries/iommu.c:1433:9: error: 'struct machdep_calls' has no member named 'dma_get_page_shift'
>       ppc_md.dma_get_page_shift = dma_get_page_shift_pSeriesLP;

It was added in patch 3/5, so I think this error is bogus. Unless there's a
typo I'm missing?

cheers
