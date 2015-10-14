From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 02:34:52 +0800
Subject: [PATCH v9 4/5] null_nvm: LightNVM test driver
In-Reply-To: <1444833738-8961-5-git-send-email-m@bjorling.me>
Message-ID: <201510150205.uihP5sQv%fengguang.wu@intel.com>

Hi Matias,

[auto build test ERROR on block/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Matias-Bj-rling/Support-for-Open-Channel-SSDs/20151014-224617
config: mips-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

>> drivers/lightnvm/built-in.o:(.discard+0x0): multiple definition of `__pcpu_unique_completion_queues'
   drivers/block/built-in.o:(.discard+0x0): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 39249 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151015/53f9c92e/attachment-0001.obj>
