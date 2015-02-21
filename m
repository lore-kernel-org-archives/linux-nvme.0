From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 21 Feb 2015 15:17:45 +0800
Subject: [block:for-linus 1/10] drivers/block/nvme-core.c:2008:22: sparse:
 symbol 'nvme_meta_noop' was not declared. Should it be static?
Message-ID: <201502211535.pykDvoRT%fengguang.wu@intel.com>

tree:   git://git.kernel.dk/linux-block.git for-linus
head:   decf6d79de84e427d409ff74156af2e77ffadd84
commit: e1e5e5641e6f271321aec257ed26a72715e4a8c2 [1/10] NVMe: Metadata format support
reproduce:
  # apt-get install sparse
  git checkout e1e5e5641e6f271321aec257ed26a72715e4a8c2
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/block/nvme-core.c:2008:22: sparse: symbol 'nvme_meta_noop' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
