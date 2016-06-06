From: lkp@intel.com (kbuild test robot)
Date: Tue, 7 Jun 2016 06:00:41 +0800
Subject: [PATCH 3/3] nvme-loop: add a NVMe loopback host driver
In-Reply-To: <1465248177-17970-4-git-send-email-hch@lst.de>
Message-ID: <201606070531.Qm5mRk3M%fengguang.wu@intel.com>

Hi,

[auto build test ERROR on block/for-next]
[also build test ERROR on v4.7-rc2 next-20160606]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christoph-Hellwig/block-Export-blk_poll/20160607-052554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/nvme/target/loop.c:22:0:
   drivers/nvme/target/nvmet.h:93:34: error: field 'disc_addr' has incomplete type
     struct nvmf_disc_rsp_page_entry disc_addr;
                                     ^~~~~~~~~
   drivers/nvme/target/nvmet.h:134:19: error: 'NVMF_NQN_FIELD_LEN' undeclared here (not in a function)
     char   subsysnqn[NVMF_NQN_FIELD_LEN];
                      ^~~~~~~~~~~~~~~~~~
   drivers/nvme/target/nvmet.h:139:24: error: field 'type' has incomplete type
     enum nvme_subsys_type type;
                           ^~~~
   drivers/nvme/target/nvmet.h: In function 'nvmet_data_dir':
   drivers/nvme/target/nvmet.h:249:9: error: implicit declaration of function 'nvme_is_write' [-Werror=implicit-function-declaration]
     return nvme_is_write(req->cmd) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
            ^~~~~~~~~~~~~
   drivers/nvme/target/loop.c: At top level:
>> drivers/nvme/target/loop.c:24:29: fatal error: ../host/fabrics.h: No such file or directory
    #include "../host/fabrics.h"
                                ^
   cc1: some warnings being treated as errors
   compilation terminated.

vim +24 drivers/nvme/target/loop.c

    18	#include <linux/nvme.h>
    19	#include <linux/module.h>
    20	#include <linux/parser.h>
    21	#include <linux/t10-pi.h>
    22	#include "nvmet.h"
    23	#include "../host/nvme.h"
  > 24	#include "../host/fabrics.h"
    25	
    26	#define NVME_LOOP_AQ_DEPTH		256
    27	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54457 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160607/194a9498/attachment-0001.obj>
