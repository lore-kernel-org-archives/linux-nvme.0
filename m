From: mpe@ellerman.id.au (Michael Ellerman)
Date: Thu, 08 Oct 2015 11:11:59 +1100
Subject: [kbuild-all] [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
In-Reply-To: <20151007135602.GA17377@wfg-t540p.sh.intel.com>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
 <1444102746.16909.4.camel@ellerman.id.au>
 <20151007135602.GA17377@wfg-t540p.sh.intel.com>
Message-ID: <1444263119.31685.4.camel@ellerman.id.au>

On Wed, 2015-10-07@21:56 +0800, Fengguang Wu wrote:
> On Tue, Oct 06, 2015@02:39:06PM +1100, Michael Ellerman wrote:
> > On Sat, 2015-10-03@04:33 +0800, kbuild test robot wrote:
> > > Hi Nishanth,
> > > 
> > > [auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]
> > > 
> > > config: powerpc-defconfig (attached as .config)
> > > reproduce:
> > >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         make.cross ARCH=powerpc 
> > > 
> > > All error/warnings (new ones prefixed by >>):
> > > 
> > >    arch/powerpc/platforms/pseries/iommu.c: In function 'iommu_init_early_pSeries':
> > > >> arch/powerpc/platforms/pseries/iommu.c:1433:9: error: 'struct machdep_calls' has no member named 'dma_get_page_shift'
> > >       ppc_md.dma_get_page_shift = dma_get_page_shift_pSeriesLP;
> > 
> > It was added in patch 3/5, so I think this error is bogus. Unless there's a
> > typo I'm missing?
> 
> Yes sorry, the patchset was not detected correctly in your case,
> ending up the patches being tested as individual ones.
> 
> I'll fixup the robot.

Thanks.

How did the robot decide to build this series in the first place? Does it build
everything sent to one of the lists on CC?

cheers
