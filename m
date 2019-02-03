From: lkp@intel.com (kbuild test robot)
Date: Sun, 3 Feb 2019 08:17:12 +0800
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
Message-ID: <201902030842.PIdG3wbw%fengguang.wu@intel.com>

Hi Takao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.0-rc4 next-20190201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Takao-Indoh/nvme-Enable-acceleration-feature-of-A64FX-processor/20190203-033331
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/pci.c:840:19: sparse: warning: invalid assignment: |=
   drivers/nvme/host/pci.c:840:19: sparse:    left side has type restricted __le64
   drivers/nvme/host/pci.c:840:19: sparse:    right side has type unsigned long long
>> drivers/nvme/host/pci.c:840:19: sparse: warning: invalid assignment: |=
   drivers/nvme/host/pci.c:840:19: sparse:    left side has type restricted __le64
   drivers/nvme/host/pci.c:840:19: sparse:    right side has type unsigned long long

sparse warnings: (new ones prefixed by >>)

   drivers/nvme/host/pci.c:840:19: sparse: warning: invalid assignment: |=
>> drivers/nvme/host/pci.c:840:19: sparse:    left side has type restricted __le64
>> drivers/nvme/host/pci.c:840:19: sparse:    right side has type unsigned long long
   drivers/nvme/host/pci.c:840:19: sparse: warning: invalid assignment: |=
>> drivers/nvme/host/pci.c:840:19: sparse:    left side has type restricted __le64
>> drivers/nvme/host/pci.c:840:19: sparse:    right side has type unsigned long long

vim +840 drivers/nvme/host/pci.c

   837	
   838	static inline void nvme_pci_enable_a64fx_relax_bit(struct nvme_sgl_desc *sge)
   839	{
 > 840		sge->addr |= (1ULL << 56);
   841	}
   842	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 67277 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190203/e8f0916c/attachment-0001.gz>
