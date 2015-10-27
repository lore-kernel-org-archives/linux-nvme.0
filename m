From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Oct 2015 06:24:08 +0800
Subject: [PATCH v12 4/5] null_nvm: LightNVM test driver
In-Reply-To: <1445957719-5368-5-git-send-email-m@bjorling.me>
Message-ID: <201510280624.MNBYeaNl%fengguang.wu@intel.com>

Hi Matias,

[auto build test ERROR on next-20151022 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Matias-Bj-rling/Support-for-Open-Channel-SSDs/20151027-230440
config: i386-allyesconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `addr_to_generic_mode':
   gennvm.c:(.text+0x88e078): undefined reference to `__umoddi3'
   gennvm.c:(.text+0x88e090): undefined reference to `__udivdi3'
   gennvm.c:(.text+0x88e0a1): undefined reference to `__umoddi3'
   gennvm.c:(.text+0x88e0c7): undefined reference to `__udivdi3'
   gennvm.c:(.text+0x88e0d5): undefined reference to `__umoddi3'
   gennvm.c:(.text+0x88e10d): undefined reference to `__udivdi3'
   gennvm.c:(.text+0x88e11b): undefined reference to `__umoddi3'
   gennvm.c:(.text+0x88e144): undefined reference to `__udivdi3'
   drivers/built-in.o: In function `gennvm_block_map':
   gennvm.c:(.text+0x88e298): undefined reference to `__udivdi3'
   gennvm.c:(.text+0x88e2c9): undefined reference to `__udivdi3'
   drivers/built-in.o: In function `gennvm_erase_blk':
   gennvm.c:(.text+0x88e459): undefined reference to `__umoddi3'
   drivers/built-in.o: In function `__linear_to_generic_addr':
   rrpc.c:(.text+0x88e961): undefined reference to `__umoddi3'
   rrpc.c:(.text+0x88e979): undefined reference to `__udivdi3'
   rrpc.c:(.text+0x88e98a): undefined reference to `__umoddi3'
   rrpc.c:(.text+0x88e9b0): undefined reference to `__udivdi3'
   rrpc.c:(.text+0x88e9be): undefined reference to `__umoddi3'
   rrpc.c:(.text+0x88e9f6): undefined reference to `__udivdi3'
   rrpc.c:(.text+0x88ea04): undefined reference to `__umoddi3'
   rrpc.c:(.text+0x88ea2d): undefined reference to `__udivdi3'
   drivers/built-in.o: In function `rrpc_capacity':
   rrpc.c:(.text+0x88ebd7): undefined reference to `__udivdi3'
   drivers/built-in.o: In function `rrpc_page_invalidate':
   rrpc.c:(.text+0x88ef75): undefined reference to `__umoddi3'
   drivers/built-in.o: In function `null_id':
>> null_nvm.c:(.text+0x890537): undefined reference to `__udivdi3'
   null_nvm.c:(.text+0x89054b): undefined reference to `__udivdi3'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51870 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151028/42234317/attachment-0001.obj>
