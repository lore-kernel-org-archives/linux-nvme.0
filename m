From: lkp@intel.com (kbuild test robot)
Date: Tue, 23 Jul 2019 10:04:23 +0800
Subject: [PATCH v2 1/3] block: introduce LED block device activity trigger
In-Reply-To: <1563807552-23498-2-git-send-email-akinobu.mita@gmail.com>
References: <1563807552-23498-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <201907231015.ELtC6gvZ%lkp@intel.com>

Hi Akinobu,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.3-rc1 next-20190722]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Akinobu-Mita/block-introduce-LED-block-device-activity-trigger/20190723-074956
config: x86_64-fedora-25 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp at intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/block/umem.c:52:0:
>> drivers/block/umem.h:39:19: error: expected identifier before numeric constant
    #define  LED_OFF  0x00
                      ^
>> include/linux/leds.h:27:2: note: in expansion of macro 'LED_OFF'
     LED_OFF  = 0,
     ^~~~~~~

vim +/LED_OFF +27 include/linux/leds.h

af410fc1 Johannes Berg  2006-09-29  19  
c72a1d60 Richard Purdie 2006-03-31  20  struct device;
5fd752b6 Baolin Wang    2018-10-11  21  struct led_pattern;
c72a1d60 Richard Purdie 2006-03-31  22  /*
c72a1d60 Richard Purdie 2006-03-31  23   * LED Core
c72a1d60 Richard Purdie 2006-03-31  24   */
c72a1d60 Richard Purdie 2006-03-31  25  
c72a1d60 Richard Purdie 2006-03-31  26  enum led_brightness {
c72a1d60 Richard Purdie 2006-03-31 @27  	LED_OFF		= 0,
4e552c8c Andi Shyti     2017-01-05  28  	LED_ON		= 1,
c72a1d60 Richard Purdie 2006-03-31  29  	LED_HALF	= 127,
c72a1d60 Richard Purdie 2006-03-31  30  	LED_FULL	= 255,
c72a1d60 Richard Purdie 2006-03-31  31  };
c72a1d60 Richard Purdie 2006-03-31  32  

:::::: The code at line 27 was first introduced by commit
:::::: c72a1d608dd0eb3d553a08bfdf1c0041bebaa8a0 [PATCH] LED: add LED class

:::::: TO: Richard Purdie <rpurdie at rpsys.net>
:::::: CC: Linus Torvalds <torvalds at g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50846 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190723/bf1adebb/attachment-0001.gz>
