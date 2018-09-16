From: lkp@intel.com (kbuild test robot)
Date: Sun, 16 Sep 2018 15:31:34 +0800
Subject: [PATCH] trace nvme submit queue status
In-Reply-To: <20180915193341.1221-1-yupeng0921@gmail.com>
References: <20180915193341.1221-1-yupeng0921@gmail.com>
Message-ID: <201809161520.tdRuh0yj%fengguang.wu@intel.com>

Hi yupeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc3 next-20180913]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/yupeng/trace-nvme-submit-queue-status/20180916-095618
config: x86_64-rhel (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "__tracepoint_nvme_sq" [drivers/nvme/host/nvme.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41202 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180916/2b684a2c/attachment-0001.gz>
