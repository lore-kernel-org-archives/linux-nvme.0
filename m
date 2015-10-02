From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Oct 2015 04:33:00 +0800
Subject: [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
In-Reply-To: <20151002202151.GJ8040@linux.vnet.ibm.com>
Message-ID: <201510030421.d9fvrbXU%fengguang.wu@intel.com>

Hi Nishanth,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: powerpc-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All error/warnings (new ones prefixed by >>):

   arch/powerpc/platforms/pseries/iommu.c: In function 'iommu_init_early_pSeries':
>> arch/powerpc/platforms/pseries/iommu.c:1433:9: error: 'struct machdep_calls' has no member named 'dma_get_page_shift'
      ppc_md.dma_get_page_shift = dma_get_page_shift_pSeriesLP;
            ^

vim +1433 arch/powerpc/platforms/pseries/iommu.c

  1427	
  1428		if (firmware_has_feature(FW_FEATURE_LPAR)) {
  1429			pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeriesLP;
  1430			pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
  1431			ppc_md.dma_set_mask = dma_set_mask_pSeriesLP;
  1432			ppc_md.dma_get_required_mask = dma_get_required_mask_pSeriesLP;
> 1433			ppc_md.dma_get_page_shift = dma_get_page_shift_pSeriesLP;
  1434		} else {
  1435			pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeries;
  1436			pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeries;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21511 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151003/f5223439/attachment-0001.obj>
