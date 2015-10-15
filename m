From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 09:09:51 +0800
Subject: [PATCH v10 3/5] rrpc: Round-robin sector target with cost-based gc
In-Reply-To: <1444850524-16827-4-git-send-email-m@bjorling.me>
Message-ID: <201510150917.fYoN1atS%fengguang.wu@intel.com>

Hi Matias,

[auto build test WARNING on block/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Matias-Bj-rling/Support-for-Open-Channel-SSDs/20151014-224617
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/lightnvm/rrpc.c:917:27: sparse: cast to restricted __le64

vim +917 drivers/lightnvm/rrpc.c

   901	static int rrpc_l2p_update(u64 slba, u64 nlb, u64 *entries, void *private)
   902	{
   903		struct rrpc *rrpc = (struct rrpc *)private;
   904		struct nvm_dev *dev = rrpc->dev;
   905		struct rrpc_addr *addr = rrpc->trans_map + slba;
   906		struct rrpc_rev_addr *raddr = rrpc->rev_trans_map;
   907		sector_t max_pages = dev->total_pages * (dev->sec_size >> 9);
   908		u64 elba = slba + nlb;
   909		u64 i;
   910	
   911		if (unlikely(elba > dev->total_pages)) {
   912			pr_err("nvm: L2P data from device is out of bounds!\n");
   913			return -EINVAL;
   914		}
   915	
   916		for (i = 0; i < nlb; i++) {
 > 917			u64 pba = le64_to_cpu(entries[i]);
   918			/* LNVM treats address-spaces as silos, LBA and PBA are
   919			 * equally large and zero-indexed.
   920			 */
   921			if (unlikely(pba >= max_pages && pba != U64_MAX)) {
   922				pr_err("nvm: L2P data entry is out of bounds!\n");
   923				return -EINVAL;
   924			}
   925	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
