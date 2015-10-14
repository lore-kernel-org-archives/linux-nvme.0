From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 07:03:45 +0800
Subject: [PATCH v10 2/5] gennvm: Generic NVM manager
In-Reply-To: <1444850524-16827-3-git-send-email-m@bjorling.me>
Message-ID: <201510150725.Mgz2ut75%fengguang.wu@intel.com>

Hi Matias,

[auto build test WARNING on block/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Matias-Bj-rling/Support-for-Open-Channel-SSDs/20151014-224617
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +109 drivers/lightnvm/gennvm.c

    93	{
    94		struct nvm_dev *dev = private;
    95		struct gen_nvm *gn = dev->mp;
    96		sector_t max_pages = dev->total_pages * (dev->sec_size >> 9);
    97		u64 elba = slba + nlb;
    98		struct gen_lun *lun;
    99		struct nvm_block *blk;
   100		u64 i;
   101		int lun_id;
   102	
   103		if (unlikely(elba > dev->total_pages)) {
   104			pr_err("gen_nvm: L2P data from device is out of bounds!\n");
   105			return -EINVAL;
   106		}
   107	
   108		for (i = 0; i < nlb; i++) {
 > 109			u64 pba = le64_to_cpu(entries[i]);
   110	
   111			if (unlikely(pba >= max_pages && pba != U64_MAX)) {
   112				pr_err("gen_nvm: L2P data entry is out of bounds!\n");
   113				return -EINVAL;
   114			}
   115	
   116			/* Address zero is a special one. The first page on a disk is
   117			 * protected. It often holds internal device boot

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
