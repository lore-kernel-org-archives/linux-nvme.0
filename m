From: lkp@intel.com (kbuild test robot)
Date: Sat, 4 Feb 2017 00:17:29 +0800
Subject: [PATCH 3/6] genirq/affinity: update CPU affinity for CPU hotplug
 events
In-Reply-To: <20170203143600.32307-4-hch@lst.de>
Message-ID: <201702040030.n76DhcEL%fengguang.wu@intel.com>

Hi Christoph,

[auto build test ERROR on block/for-next]
[also build test ERROR on v4.10-rc6]
[cannot apply to next-20170203]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christoph-Hellwig/genirq-allow-assigning-affinity-to-present-but-not-online-CPUs/20170203-224056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   kernel/irq/affinity.c: In function 'irq_affinity_offline_irq':
>> kernel/irq/affinity.c:264:2: error: implicit declaration of function 'irq_force_complete_move' [-Werror=implicit-function-declaration]
     irq_force_complete_move(desc);
     ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/irq_force_complete_move +264 kernel/irq/affinity.c

   258	
   259		/*
   260		 * Complete the irq move. This cpu is going down and for
   261		 * non intr-remapping case, we can't wait till this interrupt
   262		 * arrives at this cpu before completing the irq move.
   263		 */
 > 264		irq_force_complete_move(desc);
   265	
   266		/*
   267		 * The interrupt descriptor might have been cleaned up

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45922 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170204/bcc607d9/attachment-0001.gz>
