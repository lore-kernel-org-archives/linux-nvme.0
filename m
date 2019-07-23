From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 24 Jul 2019 00:26:49 +0900
Subject: [PATCH v2 1/3] block: introduce LED block device activity trigger
In-Reply-To: <201907231015.ELtC6gvZ%lkp@intel.com>
References: <1563807552-23498-2-git-send-email-akinobu.mita@gmail.com>
 <201907231015.ELtC6gvZ%lkp@intel.com>
Message-ID: <CAC5umygkNgxori1RKi7UqvxEBDfM7i9UUzYvtgRreht=qTFkGw@mail.gmail.com>

2019?7?23?(?) 11:05 kbuild test robot <lkp at intel.com>:
>
> Hi Akinobu,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.3-rc1 next-20190722]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Akinobu-Mita/block-introduce-LED-block-device-activity-trigger/20190723-074956
> config: x86_64-fedora-25 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp at intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from drivers/block/umem.c:52:0:
> >> drivers/block/umem.h:39:19: error: expected identifier before numeric constant
>     #define  LED_OFF  0x00
>                       ^
> >> include/linux/leds.h:27:2: note: in expansion of macro 'LED_OFF'
>      LED_OFF  = 0,
>      ^~~~~~~

The umem driver defines LED_* macros for MEMCTRLCMD_LEDCTRL register
values. I'm going to prepare a patch that renames these macros with
s/LED_/LEDCTRL_/ in umem.
