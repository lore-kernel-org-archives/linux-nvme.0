From: lkp@intel.com (kbuild test robot)
Date: Tue, 23 Jul 2019 10:22:11 +0800
Subject: [PATCH v2 1/3] block: introduce LED block device activity trigger
In-Reply-To: <1563807552-23498-2-git-send-email-akinobu.mita@gmail.com>
References: <1563807552-23498-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <201907231041.n2ZW7zai%lkp@intel.com>

Hi Akinobu,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc1 next-20190722]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Akinobu-Mita/block-introduce-LED-block-device-activity-trigger/20190723-074956
config: x86_64-rhel (attached as .config)
compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp at intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/mvsas/mv_94xx.c:11:0:
>> drivers/scsi/mvsas/mv_94xx.h:278:2: error: redeclaration of enumerator 'LED_OFF'
     LED_OFF = 0,
     ^~~~~~~
   In file included from include/linux/genhd.h:20:0,
                    from include/linux/blkdev.h:11,
                    from include/linux/blk-mq.h:5,
                    from include/scsi/scsi_host.h:11,
                    from include/linux/libata.h:21,
                    from include/scsi/libsas.h:16,
                    from drivers/scsi/mvsas/mv_sas.h:27,
                    from drivers/scsi/mvsas/mv_94xx.c:10:
   include/linux/leds.h:27:2: note: previous definition of 'LED_OFF' was here
     LED_OFF  = 0,
     ^~~~~~~
   In file included from drivers/scsi/mvsas/mv_94xx.c:11:0:
>> drivers/scsi/mvsas/mv_94xx.h:279:2: error: redeclaration of enumerator 'LED_ON'
     LED_ON = 1,
     ^~~~~~
   In file included from include/linux/genhd.h:20:0,
                    from include/linux/blkdev.h:11,
                    from include/linux/blk-mq.h:5,
                    from include/scsi/scsi_host.h:11,
                    from include/linux/libata.h:21,
                    from include/scsi/libsas.h:16,
                    from drivers/scsi/mvsas/mv_sas.h:27,
                    from drivers/scsi/mvsas/mv_94xx.c:10:
   include/linux/leds.h:28:2: note: previous definition of 'LED_ON' was here
     LED_ON  = 1,
     ^~~~~~

vim +/LED_OFF +278 drivers/scsi/mvsas/mv_94xx.h

c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  276  
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  277  enum sgpio_led_status {
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27 @278  	LED_OFF	= 0,
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27 @279  	LED_ON	= 1,
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  280  	LED_BLINKA	= 2,
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  281  	LED_BLINKA_INV	= 3,
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  282  	LED_BLINKA_SOF	= 4,
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  283  	LED_BLINKA_EOF	= 5,
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  284  	LED_BLINKB	= 6,
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  285  	LED_BLINKB_INV	= 7,
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  286  };
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  287  
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  288  #define DEFAULT_SGPIO_BITS ((LED_BLINKA_SOF << \
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  289  				MVS_SGPIO_DCTRL_ACT_SHIFT) << (8 * 3) | \
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  290  			(LED_BLINKA_SOF << \
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  291  				MVS_SGPIO_DCTRL_ACT_SHIFT) << (8 * 2) | \
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  292  			(LED_BLINKA_SOF << \
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  293  				MVS_SGPIO_DCTRL_ACT_SHIFT) << (8 * 1) | \
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  294  			(LED_BLINKA_SOF << \
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  295  				MVS_SGPIO_DCTRL_ACT_SHIFT) << (8 * 0))
c56f5f1de3a6ab8 Wilfried Weissmann 2015-12-27  296  
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  297  /*
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  298   * these registers are accessed through port vendor
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  299   * specific address/data registers
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  300   */
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  301  enum sas_sata_phy_regs {
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  302  	GENERATION_1_SETTING		= 0x118,
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  303  	GENERATION_1_2_SETTING		= 0x11C,
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  304  	GENERATION_2_3_SETTING		= 0x120,
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  305  	GENERATION_3_4_SETTING		= 0x124,
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  306  };
f1f82a919d7fff2 Xiangliang Yu      2011-05-24  307  
20b09c2992fefbe Andy Yan           2009-05-08  308  #define SPI_CTRL_REG_94XX           	0xc800
20b09c2992fefbe Andy Yan           2009-05-08  309  #define SPI_ADDR_REG_94XX            	0xc804
20b09c2992fefbe Andy Yan           2009-05-08  310  #define SPI_WR_DATA_REG_94XX         0xc808
20b09c2992fefbe Andy Yan           2009-05-08  311  #define SPI_RD_DATA_REG_94XX         	0xc80c
20b09c2992fefbe Andy Yan           2009-05-08  312  #define SPI_CTRL_READ_94XX         	(1U << 2)
20b09c2992fefbe Andy Yan           2009-05-08  313  #define SPI_ADDR_VLD_94XX         	(1U << 1)
20b09c2992fefbe Andy Yan           2009-05-08  314  #define SPI_CTRL_SpiStart_94XX     	(1U << 0)
20b09c2992fefbe Andy Yan           2009-05-08  315  
20b09c2992fefbe Andy Yan           2009-05-08  316  static inline int
20b09c2992fefbe Andy Yan           2009-05-08  317  mv_ffc64(u64 v)
20b09c2992fefbe Andy Yan           2009-05-08  318  {
beecadea1b8d67f Xi Wang            2012-11-16  319  	u64 x = ~v;
beecadea1b8d67f Xi Wang            2012-11-16  320  	return x ? __ffs64(x) : -1;
20b09c2992fefbe Andy Yan           2009-05-08  321  }
20b09c2992fefbe Andy Yan           2009-05-08  322  
20b09c2992fefbe Andy Yan           2009-05-08  323  #define r_reg_set_enable(i) \
20b09c2992fefbe Andy Yan           2009-05-08  324  	(((i) > 31) ? mr32(MVS_STP_REG_SET_1) : \
20b09c2992fefbe Andy Yan           2009-05-08  325  	mr32(MVS_STP_REG_SET_0))
20b09c2992fefbe Andy Yan           2009-05-08  326  
20b09c2992fefbe Andy Yan           2009-05-08  327  #define w_reg_set_enable(i, tmp) \
20b09c2992fefbe Andy Yan           2009-05-08  328  	(((i) > 31) ? mw32(MVS_STP_REG_SET_1, tmp) : \
20b09c2992fefbe Andy Yan           2009-05-08  329  	mw32(MVS_STP_REG_SET_0, tmp))
20b09c2992fefbe Andy Yan           2009-05-08  330  
20b09c2992fefbe Andy Yan           2009-05-08  331  extern const struct mvs_dispatch mvs_94xx_dispatch;
20b09c2992fefbe Andy Yan           2009-05-08  332  #endif
20b09c2992fefbe Andy Yan           2009-05-08  333  

:::::: The code at line 278 was first introduced by commit
:::::: c56f5f1de3a6ab8ec985edbc358e1fd8d4e36a65 mvsas: Add SGPIO support to Marvell 94xx

:::::: TO: Wilfried Weissmann <Wilfried.Weissmann at gmx.at>
:::::: CC: Martin K. Petersen <martin.petersen at oracle.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43527 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190723/3e9578ef/attachment-0001.gz>
