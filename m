From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Oct 2015 02:57:08 +0800
Subject: [PATCH 2/2] drivers/nvme: default to the IOMMU page size on Power
In-Reply-To: <20151002172313.GC41011@linux.vnet.ibm.com>
Message-ID: <201510030213.VRbm26W0%fengguang.wu@intel.com>

Hi Nishanth,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

>> drivers/block/nvme-core.c:45:23: fatal error: asm/iommu.h: No such file or directory
    #include <asm/iommu.h>
                          ^
   compilation terminated.

vim +45 drivers/block/nvme-core.c

    39	#include <linux/sched.h>
    40	#include <linux/slab.h>
    41	#include <linux/t10-pi.h>
    42	#include <linux/types.h>
    43	#include <scsi/sg.h>
    44	#include <asm-generic/io-64-nonatomic-lo-hi.h>
  > 45	#include <asm/iommu.h>
    46	
    47	#define NVME_MINORS		(1U << MINORBITS)
    48	#define NVME_Q_DEPTH		1024

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45525 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151003/961f1921/attachment-0001.obj>
