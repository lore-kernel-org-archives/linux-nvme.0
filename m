From: lkp@intel.com (kbuild test robot)
Date: Wed, 12 Jul 2017 10:27:43 +0800
Subject: [PATCH 02/13] mpt3sas: SGL to PRP Translation for I/Os to NVMe
 devices
In-Reply-To: <1499763313-7214-3-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <201707121048.UGjUxQvb%fengguang.wu@intel.com>

Hi Suganath,

[auto build test ERROR on scsi/for-next]
[also build test ERROR on v4.12 next-20170711]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suganath-Prabu-S/mpt3sas-Add-nvme-device-support-in-slave-alloc-target-alloc-and-probe/20170711-204831
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: x86_64-kexec (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the linux-review/Suganath-Prabu-S/mpt3sas-Add-nvme-device-support-in-slave-alloc-target-alloc-and-probe/20170711-204831 HEAD 46a9c8fb1d7fe7649aa0eaa925c6653a6fa3047e builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/mpt3sas/mpt3sas_base.c:66:0:
>> drivers/scsi/mpt3sas/mpt3sas_base.h:57:26: fatal error: mpi/mpi2_pci.h: No such file or directory
    #include "mpi/mpi2_pci.h"
                             ^
   compilation terminated.

vim +57 drivers/scsi/mpt3sas/mpt3sas_base.h

    48	
    49	#include "mpi/mpi2_type.h"
    50	#include "mpi/mpi2.h"
    51	#include "mpi/mpi2_ioc.h"
    52	#include "mpi/mpi2_cnfg.h"
    53	#include "mpi/mpi2_init.h"
    54	#include "mpi/mpi2_raid.h"
    55	#include "mpi/mpi2_tool.h"
    56	#include "mpi/mpi2_sas.h"
  > 57	#include "mpi/mpi2_pci.h"
    58	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25366 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170712/8895cd92/attachment-0001.gz>
