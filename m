Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D67D0EE18
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 21:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zQYbsdoh5iLMfnPIE8gR1Zphgon72BYY58aeFh8jKeY=; b=sk9yaDzdoaSk9V80oJ74j/bhKI
	pnSkqCx5PVwIOlVGbLw4qA1qBbUj9w89l1LbF7Y6UkD+oEMoEMAG2FSUfpVGPfX8iAKOFP0zkgfLk
	26qoK3O9Wk+x6P3X4JMU9i3ZIW/9V69mHajzem0VqytvojsZPZyjOoqarkzcCf3Uj6ekWna75PF64
	p1fTEkCQUy6DzohGzkgk5vHWeqEov/EPLxbxfmNJt8nG3YTrkAaBx7Xyex8riIqCdwgE7E+bQ1yQW
	e/PbnZdXQp0/0IWGz4D8DeM82/FlgDkbv50sQoa7E2f8NjHiU1xD8EgyRtKRBaXQml4t6Lk7NAZro
	Yo1S8rZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO0RX-0000000Dx0j-2zIq;
	Tue, 25 Nov 2025 21:19:23 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO0RU-0000000DwzH-1nZH
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 21:19:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764105561; x=1795641561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tHReAClY+18HFickbZdyBGjV0pf+yYtvp16HndzBVuk=;
  b=fiwfZXSYS+CxLUj/96VU4EYW0QJDtmz3ZcJTPgeTbFeDQ4gZrBCSuDWS
   mISrKYs/wI7ix72pvoGQpqof+PfpYdeYx1jO8p6gLxeITRWElqfRYt90G
   Ion7isHPRBCyIF24bffw6PJse77TRTjUO9Om3KD+Y52ECM+T366DPXwOf
   lNBFdka/lK0Cn4zZ90iJAuswprPRleFlSNW8pepOwiGMLQUNM/X7n3jLX
   AAWSPLLLWAL4yy3ChWAM4qHXBL3LSYFhLMHEN8/m2wT3t1Z29JaS1vHrg
   imaoU8WZdVB3r4rD/w77GMq2BUZ2QVEojD/tnvBTrtTHZHer6mE55uUts
   g==;
X-CSE-ConnectionGUID: SqIq4HbLTA6zW82mD9n+zQ==
X-CSE-MsgGUID: SMQDpMCkTQ+QNuxPFHUNig==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="83525961"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="83525961"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 13:19:18 -0800
X-CSE-ConnectionGUID: G67XL42VQuqp8KxUC3FLAg==
X-CSE-MsgGUID: 0bQuqz7RS8KvuZSMS1H40A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="216107957"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 25 Nov 2025 13:19:16 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO0RO-000000002Gv-0ZTN;
	Tue, 25 Nov 2025 21:19:14 +0000
Date: Wed, 26 Nov 2025 05:19:13 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [linux-nvme:nvme-6.19 3/27] include/linux/kern_levels.h:5:25:
 warning: format '%ld' expects argument of type 'long int', but argument 2
 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202511260537.R9DHSTOl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_131920_504573_A005589C 
X-CRM114-Status: GOOD (  10.96  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.19
head:   db2792e1d7696594dcd09dcc97f262e69819a820
commit: 00eecf662c6e30736357ffd007ea2f3964f6eb04 [3/27] nvme-auth: modify nvme_auth_transform_key() to return status
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20251126/202511260537.R9DHSTOl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251126/202511260537.R9DHSTOl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511260537.R9DHSTOl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:18,
                    from drivers/nvme/common/auth.c:6:
   drivers/nvme/common/auth.c: In function 'nvme_auth_transform_key':
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:486:25: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:567:9: note: in expansion of macro 'printk'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:567:16: note: in expansion of macro 'KERN_WARNING'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/nvme/common/auth.c:278:17: note: in expansion of macro 'pr_warn'
     278 |                 pr_warn("incompatible digest size %ld for key (hash %s, len %ld)\n",
         |                 ^~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:486:25: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:567:9: note: in expansion of macro 'printk'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:567:16: note: in expansion of macro 'KERN_WARNING'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/nvme/common/auth.c:278:17: note: in expansion of macro 'pr_warn'
     278 |                 pr_warn("incompatible digest size %ld for key (hash %s, len %ld)\n",
         |                 ^~~~~~~


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

