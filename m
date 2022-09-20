Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084CFC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 04:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e2yjJAGfOFAiKVU31vc/zjdvB3ymd+rTW8x9FZYGb/4=; b=BdathYMZA55NN4buXRkGpwO06y
	EFRcVYNJlrLzEbXy4YG2vfSNqTIuV/OocS+oTkq9jfViM6AX5wls2mgYuukhZP5e0yGLJorXsFJGu
	T8XqUEZwurzgma3bYAfZF5OdDAeYWamdPwdiG44s03Rv29W8L/zmfXsDQIFlC7EkZLEi1e5sKno5h
	bjgxdfxO90F0YF8zlYziDaOQcu0b02bt4n0yH2IaQTJIB5e3KLYVN/dBpnUnQ6h18ntz/52Mwz75C
	FWJsaCXQ7xGdi1N3ENzn3eRQ/aebOPdiBuNAsDPeudLfGc4WhSt7fLjblZOiRICKBLJAiS5PY4lcH
	VbSjWgjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaVLk-000Z8Q-0L; Tue, 20 Sep 2022 04:59:12 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaVLg-000Z23-KD
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 04:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663649948; x=1695185948;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Q962UNz8q52zHH8y8Tr4QkswQ0XH+KKW2R2B2NuuwZo=;
  b=KUku4SEVyBZr50spCGxUYvCJXk3zdGLvcOvb895mTRhdJqyHp6mufF2C
   TIiLpBLM6VSx69JqBCkCQgh/N0SXCJ//sSiIvEZcaNXv1f7AjjSQvltO2
   9wwTtH3ckC6fCG/nkypLcxEXazsXyF/ksFG3iuS33EmFfUgM1+52/p8Q1
   ioZON4zny8WqpWUeb7+rGDWi4RgU+w1YlV9qY4KFDWnQauWHxD7npuaxf
   ztCWjRUoSoon8Mxf4tqqtOE1cZ7QvW5sOyVre9OfBnbro/4iQSSerZ2Xf
   mdoCuWlovvMzGn7yRNMNlzf9tjoWQp66TXMoMiGLYEH0k/CGVV9wXjNcl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="286644084"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="286644084"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 21:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="569931907"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2022 21:59:02 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oaVLZ-0002U6-15;
	Tue, 20 Sep 2022 04:59:01 +0000
Date: Tue, 20 Sep 2022 12:58:43 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 02c57a82c0081141abc19150beab48ef47f97f18
Message-ID: <63294883.Cf9fCrJ2ERGf7xRt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_215908_740038_2F5FCA07 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.1
branch HEAD: 02c57a82c0081141abc19150beab48ef47f97f18  nvme-tcp: print actual source IP address through sysfs "address" attr

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                 randconfig-a012-20220919
um                             i386_defconfig
i386                 randconfig-a011-20220919
um                           x86_64_defconfig
i386                 randconfig-a013-20220919
arc                                 defconfig
i386                 randconfig-a014-20220919
alpha                               defconfig
i386                 randconfig-a016-20220919
mips                             allyesconfig
s390                                defconfig
x86_64                              defconfig
i386                 randconfig-a015-20220919
powerpc                           allnoconfig
s390                             allmodconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
sh                               allmodconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                           allyesconfig
riscv                randconfig-r042-20220919
alpha                            allyesconfig
arc                  randconfig-r043-20220919
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20220919
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64               randconfig-a012-20220919
i386                                defconfig
arm                                 defconfig
x86_64               randconfig-a016-20220919
x86_64               randconfig-a011-20220919
x86_64               randconfig-a014-20220919
x86_64               randconfig-a015-20220919
x86_64               randconfig-a013-20220919
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
i386                             allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220919
i386                 randconfig-a001-20220919
x86_64               randconfig-a003-20220919
hexagon              randconfig-r045-20220919
x86_64               randconfig-a001-20220919
x86_64               randconfig-a005-20220919
i386                 randconfig-a002-20220919
x86_64               randconfig-a002-20220919
i386                 randconfig-a003-20220919
x86_64               randconfig-a004-20220919
x86_64               randconfig-a006-20220919
i386                 randconfig-a004-20220919
i386                 randconfig-a005-20220919
i386                 randconfig-a006-20220919

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

