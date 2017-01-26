From: lkp@intel.com (kbuild test robot)
Date: Fri, 27 Jan 2017 01:45:49 +0800
Subject: [PATCH] nvme: make nvmf_register_transport require a create_ctrl
 callback
In-Reply-To: <20170126152228.15330-1-jthumshirn@suse.de>
Message-ID: <201701270119.Vec32uLQ%fengguang.wu@intel.com>

Hi Johannes,

[auto build test ERROR on block/for-next]
[also build test ERROR on v4.10-rc5 next-20170125]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/nvme-make-nvmf_register_transport-require-a-create_ctrl-callback/20170126-234702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):


vim +2066 drivers/nvme/host/rdma.c

  2060		ret = ib_register_client(&nvme_rdma_ib_client);
  2061		if (ret) {
  2062			destroy_workqueue(nvme_rdma_wq);
  2063			return ret;
  2064		}
  2065	
> 2066		return = nvmf_register_transport(&nvme_rdma_transport);
> 2067	}
  2068	
  2069	static void __exit nvme_rdma_cleanup_module(void)
  2070	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45519 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170127/38ecb354/attachment-0001.gz>
