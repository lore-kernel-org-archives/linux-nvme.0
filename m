From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Oct 2015 04:43:18 +0800
Subject: [PATCH 5/5 v2] drivers/nvme: default to the IOMMU page size
In-Reply-To: <20151002203022.GK8040@linux.vnet.ibm.com>
Message-ID: <201510030427.x9GJ7csD%fengguang.wu@intel.com>

Hi Nishanth,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: sparc64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All error/warnings (new ones prefixed by >>):

   drivers/block/nvme-core.c: In function 'nvme_configure_admin_queue':
>> drivers/block/nvme-core.c:1717:2: error: implicit declaration of function 'dma_get_page_shift' [-Werror=implicit-function-declaration]
     unsigned page_shift = dma_get_page_shift(dev->dev);
     ^
   cc1: some warnings being treated as errors

vim +/dma_get_page_shift +1717 drivers/block/nvme-core.c

  1711	static int nvme_configure_admin_queue(struct nvme_dev *dev)
  1712	{
  1713		int result;
  1714		u32 aqa;
  1715		u64 cap = readq(&dev->bar->cap);
  1716		struct nvme_queue *nvmeq;
> 1717		unsigned page_shift = dma_get_page_shift(dev->dev);
  1718		unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
  1719		unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
  1720	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43733 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151003/9547770b/attachment-0001.obj>
