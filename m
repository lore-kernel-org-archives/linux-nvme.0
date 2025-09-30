Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44393CCA468
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1goEzI8sIBXGxtGg4h4CaxJCPlv3QlEuH5NdiMkRTHo=; b=is8YbOp+pPTyFWUhQhpGaFPW/u
	bV+JhhaPg2uW5gfXQ3Hh1/q5SSDXKQ3BNIBMXnyLwiZFCpT3Am0AMo+fqRJDvWTGlSzDMbWeR3t8T
	cWF9q0pf5IqFsJcD+71NXgAxTgJTwJ/DoGax0kaXPPo/tscXN1JDO4NFPs56IdDHFBZQUpqVQIs/L
	3XBenjkCWAuVEANimR838BIklrxaoSkFvb6kuwBBGC51e0RFJwq58Q++r9JXyoO5NVCgNc1x1y5Qz
	25snT07fD8E2oc4Xg0LNlHgPIEgwIwmDj4CDS7zUeTVE3O9mnedp9x4FQg48Fn9dGjAz6Hco58v4U
	KD/oZ6UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3aw3-00000005SH1-3DhM;
	Tue, 30 Sep 2025 14:02:31 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3aw1-00000005SGf-24VI
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 14:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759240949; x=1790776949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fZ2Q/oiUArxeHjMnVz8UUGxPawifeCHpdKtdKNs/ssI=;
  b=jiQ0tYjOS0xzr+Cfx25yTgxEy8GWqXFF40g8vq0SDi4rlwsteNaE/Ti5
   Wjih5KNLGtNY1800wawAlbNRlvgpTRgKeed7g9ssd2WKcWCnlIXwEacew
   JrwV+WfojHIbqUU/NClcxAGKA98NFGx0zkNkGsNvjWbnFu/OeLP2PK0Eq
   iuiHUUNMwoEZ3RP7e1IQ21vIRxQLYplq7WQP5+mUd13soM80LtnfrTlAZ
   zYLhO3EdXYhf9fhRNsd1muwKnbN2DYvq3FX42M0VMiGdaO+ekjBa/fGBk
   lnk/lVxfh51HThgV56x1Limn0bhqhSZuSvl/l8eVPFTD7fMKFjd5/IWUY
   g==;
X-CSE-ConnectionGUID: zCJGGkiJR5qOTF9nhi7xEw==
X-CSE-MsgGUID: rDDTtFGTSTuzHPf4sC03BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61414072"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61414072"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 07:02:27 -0700
X-CSE-ConnectionGUID: ogEPciQXQzCoZDiy7EzuKQ==
X-CSE-MsgGUID: UnM3L6LASiyKLMtPTilLDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="177651316"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Sep 2025 07:02:25 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3avv-0001OT-0K;
	Tue, 30 Sep 2025 14:02:23 +0000
Date: Tue, 30 Sep 2025 22:02:06 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [linux-nvme:nvme-6.18 4/11] include/linux/kern_levels.h:5:18:
 warning: format '%lu' expects argument of type 'long unsigned int', but
 argument 3 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202509302151.WHyjRfcE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_070229_545045_D893E2BD 
X-CRM114-Status: GOOD (  10.77  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree:   git://git.infradead.org/nvme.git nvme-6.18
head:   876f5e3e3b1e3e78aec9b7e53bec4b949a13ce09
commit: 2907c26f418da9a46deae686598e3006958fb1c5 [4/11] nvme-keyring: add 'dhchap' key type
config: arc-randconfig-001-20250930 (https://download.01.org/0day-ci/archive/20250930/202509302151.WHyjRfcE-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250930/202509302151.WHyjRfcE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509302151.WHyjRfcE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:18,
                    from drivers/nvme/common/keyring.c:6:
   drivers/nvme/common/keyring.c: In function 'nvme_dhchap_psk_preparse':
>> include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:135:11: note: in definition of macro 'no_printk'
     135 |   _printk(fmt, ##__VA_ARGS__);  \
         |           ^~~
   include/linux/kern_levels.h:15:20: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG KERN_SOH "7" /* debug-level messages */
         |                    ^~~~~~~~
   include/linux/printk.h:644:12: note: in expansion of macro 'KERN_DEBUG'
     644 |  no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |            ^~~~~~~~~~
   drivers/nvme/common/keyring.c:343:3: note: in expansion of macro 'pr_debug'
     343 |   pr_debug("%s: Invalid data length %lu\n", __func__, datalen);
         |   ^~~~~~~~
   drivers/nvme/common/keyring.c:343:39: note: format string is defined here
     343 |   pr_debug("%s: Invalid data length %lu\n", __func__, datalen);
         |                                     ~~^
         |                                       |
         |                                       long unsigned int
         |                                     %u


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

