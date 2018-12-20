From: lkp@intel.com (kbuild test robot)
Date: Fri, 21 Dec 2018 06:23:28 +0800
Subject: [PATCH] nvme-pci: fix dbbuf_sq_db point to freed memory
In-Reply-To: <E5D59058E6941147BD3ACF9CB4AA49E3B3572D68@DGGEMA505-MBX.china.huawei.com>
References: <E5D59058E6941147BD3ACF9CB4AA49E3B3572D68@DGGEMA505-MBX.china.huawei.com>
Message-ID: <201812210657.GOiKRN0i%fengguang.wu@intel.com>

Hi Lulina,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.20-rc7 next-20181220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lulina-A/nvme-pci-fix-dbbuf_sq_db-point-to-freed-memory/20181221-060322
config: x86_64-randconfig-x001-201850 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/nvme//host/pci.c: In function 'nvme_dbbuf_dma_free':
>> drivers/nvme//host/pci.c:261:18: error: invalid type argument of '->' (have 'struct nvme_queue')
       dev->queues[i]->dbbuf_sq_db = NULL;
                     ^~
   drivers/nvme//host/pci.c:262:18: error: invalid type argument of '->' (have 'struct nvme_queue')
       dev->queues[i]->dbbuf_cq_db = NULL;
                     ^~
   drivers/nvme//host/pci.c:270:18: error: invalid type argument of '->' (have 'struct nvme_queue')
       dev->queues[i]->dbbuf_sq_ei = NULL;
                     ^~
   drivers/nvme//host/pci.c:271:18: error: invalid type argument of '->' (have 'struct nvme_queue')
       dev->queues[i]->dbbuf_cq_ei = NULL;
                     ^~

vim +261 drivers/nvme//host/pci.c

   250	
   251	static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
   252	{
   253		unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
   254		unsigned int i;
   255	
   256		if (dev->dbbuf_dbs) {
   257			dma_free_coherent(dev->dev, mem_size,
   258					  dev->dbbuf_dbs, dev->dbbuf_dbs_dma_addr);
   259			dev->dbbuf_dbs = NULL;
   260			for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
 > 261				dev->queues[i]->dbbuf_sq_db = NULL;
   262				dev->queues[i]->dbbuf_cq_db = NULL;
   263			}
   264		}
   265		if (dev->dbbuf_eis) {
   266			dma_free_coherent(dev->dev, mem_size,
   267					  dev->dbbuf_eis, dev->dbbuf_eis_dma_addr);
   268			dev->dbbuf_eis = NULL;
   269			for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
   270				dev->queues[i]->dbbuf_sq_ei = NULL;
   271				dev->queues[i]->dbbuf_cq_ei = NULL;
   272			}
   273		}
   274	}
   275	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29736 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20181221/150f347b/attachment-0001.gz>
