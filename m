From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 24 Jul 2019 00:28:28 +0900
Subject: [PATCH v2 1/3] block: introduce LED block device activity trigger
In-Reply-To: <201907231041.n2ZW7zai%lkp@intel.com>
References: <1563807552-23498-2-git-send-email-akinobu.mita@gmail.com>
 <201907231041.n2ZW7zai%lkp@intel.com>
Message-ID: <CAC5umyi0O7iXW3x4vE2yTgjTkerKn+VQHJVOwdD7qPJnwJUyAQ@mail.gmail.com>

2019?7?23?(?) 11:22 kbuild test robot <lkp at intel.com>:
>
> Hi Akinobu,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc1 next-20190722]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Akinobu-Mita/block-introduce-LED-block-device-activity-trigger/20190723-074956
> config: x86_64-rhel (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp at intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/scsi/mvsas/mv_94xx.c:11:0:
> >> drivers/scsi/mvsas/mv_94xx.h:278:2: error: redeclaration of enumerator 'LED_OFF'
>      LED_OFF = 0,
>      ^~~~~~~
>    In file included from include/linux/genhd.h:20:0,
>                     from include/linux/blkdev.h:11,
>                     from include/linux/blk-mq.h:5,
>                     from include/scsi/scsi_host.h:11,
>                     from include/linux/libata.h:21,
>                     from include/scsi/libsas.h:16,
>                     from drivers/scsi/mvsas/mv_sas.h:27,
>                     from drivers/scsi/mvsas/mv_94xx.c:10:
>    include/linux/leds.h:27:2: note: previous definition of 'LED_OFF' was here
>      LED_OFF  = 0,
>      ^~~~~~~
>    In file included from drivers/scsi/mvsas/mv_94xx.c:11:0:
> >> drivers/scsi/mvsas/mv_94xx.h:279:2: error: redeclaration of enumerator 'LED_ON'
>      LED_ON = 1,
>      ^~~~~~
>    In file included from include/linux/genhd.h:20:0,
>                     from include/linux/blkdev.h:11,
>                     from include/linux/blk-mq.h:5,
>                     from include/scsi/scsi_host.h:11,
>                     from include/linux/libata.h:21,
>                     from include/scsi/libsas.h:16,
>                     from drivers/scsi/mvsas/mv_sas.h:27,
>                     from drivers/scsi/mvsas/mv_94xx.c:10:
>    include/linux/leds.h:28:2: note: previous definition of 'LED_ON' was here
>      LED_ON  = 1,
>      ^~~~~~

The mvsas driver declares LED_* enums for enum sgpio_led_status.
I'm going to prepare a patch that adds 'SGPIO_' prefix to these enums.
