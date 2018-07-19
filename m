From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Jul 2018 00:29:18 +0800
Subject: [PATCH 1/4] nvme: factor out pci abort handling into core
In-Reply-To: <20180719132838.15556-2-jthumshirn@suse.de>
References: <20180719132838.15556-2-jthumshirn@suse.de>
Message-ID: <201807192335.ptGDRSvD%fengguang.wu@intel.com>

Hi Johannes,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc5 next-20180719]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/Rework-NVMe-abort-handling/20180719-230642
config: x86_64-randconfig-x011-201828 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'abort_endio':
>> drivers/nvme/host/core.c:711:40: error: 'struct nvme_request' has no member named 'ctrl'
     struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
                                           ^~

vim +711 drivers/nvme/host/core.c

   707	
   708	
   709	static void abort_endio(struct request *req, blk_status_t error)
   710	{
 > 711		struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
   712	
   713		dev_warn(ctrl->device,
   714			 "Abort status: 0x%x", nvme_req(req)->status);
   715		atomic_inc(&ctrl->abort_limit);
   716		blk_mq_free_request(req);
   717	}
   718	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34695 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180720/d222223b/attachment-0001.gz>
