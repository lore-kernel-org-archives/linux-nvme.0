From: lkp@intel.com (kbuild test robot)
Date: Sun, 21 Jan 2018 01:24:41 +0800
Subject: [PATCH 3/6] mpt3sas: Introduce API's to get BAR0 mapped buffer
 address.
In-Reply-To: <1516365462-14708-4-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1516365462-14708-4-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <201801210120.wtT4VJUt%fengguang.wu@intel.com>

Hi Suganath,

I love your patch! Perhaps something to improve:

[auto build test WARNING on scsi/for-next]
[also build test WARNING on v4.15-rc8 next-20180119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suganath-Prabu-S/mpt3sas-Add-PCI-device-ID-for-Andromeda/20180121-002454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: i386-randconfig-x017-201803 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_get_chain_phys':
>> drivers/scsi/mpt3sas/mpt3sas_base.c:171:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     base_chain_phys  = (void *)ioc->chip_phys + MPI_FRAME_START_OFFSET +
                        ^
   At top level:
   drivers/scsi/mpt3sas/mpt3sas_base.c:212:1: warning: '_base_get_buffer_phys_bar0' defined but not used [-Wunused-function]
    _base_get_buffer_phys_bar0(struct MPT3SAS_ADAPTER *ioc, u16 smid)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_base.c:191:1: warning: '_base_get_buffer_bar0' defined but not used [-Wunused-function]
    _base_get_buffer_bar0(struct MPT3SAS_ADAPTER *ioc, u16 smid)
    ^~~~~~~~~~~~~~~~~~~~~

vim +171 drivers/scsi/mpt3sas/mpt3sas_base.c

   152	
   153	/**
   154	 * _base_get_chain_phys - Calculates and Returns physical address
   155	 *			in BAR0 for scatter gather chains, for
   156	 *			the provided smid.
   157	 *
   158	 * @ioc: per adapter object
   159	 * @smid: system request message index
   160	 * @sge_chain_count: Scatter gather chain count.
   161	 *
   162	 * @Return - Physical chain address.
   163	 */
   164	static inline void *
   165	_base_get_chain_phys(struct MPT3SAS_ADAPTER *ioc, u16 smid,
   166			u8 sge_chain_count)
   167	{
   168		void *base_chain_phys, *chain_phys;
   169		u16 cmd_credit = ioc->facts.RequestCredit + 1;
   170	
 > 171		base_chain_phys  = (void *)ioc->chip_phys + MPI_FRAME_START_OFFSET +
   172			(cmd_credit * ioc->request_sz) +
   173			REPLY_FREE_POOL_SIZE;
   174		chain_phys = base_chain_phys + (smid * ioc->facts.MaxChainDepth *
   175				ioc->request_sz) + (sge_chain_count * ioc->request_sz);
   176		return chain_phys;
   177	}
   178	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29932 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180121/26642ac9/attachment-0001.gz>
