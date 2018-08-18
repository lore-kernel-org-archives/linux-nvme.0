From: lkp@intel.com (kbuild test robot)
Date: Sat, 18 Aug 2018 17:22:53 +0800
Subject: [PATCH] block: fix rdma queue mapping
In-Reply-To: <20180817223823.19566-1-sagi@grimberg.me>
References: <20180817223823.19566-1-sagi@grimberg.me>
Message-ID: <201808181744.BIqmnwvW%fengguang.wu@intel.com>

Hi Sagi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on v4.18 next-20180817]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sagi-Grimberg/block-fix-rdma-queue-mapping/20180818-103103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> block/blk-mq-rdma.c:105:34-35: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
