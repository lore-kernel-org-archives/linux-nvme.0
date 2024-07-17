Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4460C3DA49
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 03:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ApJbfss3dCXyJos/wq9h5ugofYa+NQL77FxkgEzJiYc=; b=b0lS+urhy1mFEmKlYHaddLn57D
	KXy/tZPqs4MtruNOzEo6DVZ9/YAYNgP2wjo7qFfL98Nkp2hPVaiiq9RGLXtRQRkqFOFYHXLUsdCao
	BOldftAxdV5xxZbfo2qvh9DOos9xNAH0DBqdiLPxcN7xyjoZoN1DgLjWk6i57IxcIHBkgQcJMZ8k/
	5sk89Jap1k42mpSBRqObuMNC+G2OgaLzboWgL4U0CJVbLC2wJzr0t84djxGHSABhKPkZlDFRLL075
	19JgLrr7I2BB/Q7lr3pSsflLmpqqPEaZT6dRcx1XIIkMY5URGLwyF2ABk2WBM1TqbNHo/TpjoN7BE
	90+0Iklg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTvX1-0000000CXIq-23BG;
	Wed, 17 Jul 2024 03:40:43 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTvWz-0000000CXHf-089y
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 03:40:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721187641; x=1752723641;
  h=date:from:to:cc:subject:message-id;
  bh=EnTiPmwyJMOrrVlaTlaDwFWCW7nZbSZHX/HDlP8ieHc=;
  b=Bvwj5uo35ii/5O3xLwEw5e2PmmMu+/b0B+dsqpojpF7JDtPnIBZ/fpdv
   bcQMnZmBQRqhVsrmV3YbilXKjLIDURdvtzfe+4ShWlUGPgYvlgfC3aOuG
   0VX+5jusr7xX87jDvVpdU8XzQWnZN5yK+iklA7fpUO2LaJr+ilwIL2DFd
   vrQjyKfxztn9p5XxZWX5PtdTXZ0oIjdQG3z6B28IGCUZeaQL08c0w5rD9
   lTjGMMvoywYNzhnd2H2lGbVtYofwty4xdFDZgzE6GzPmBW47pttcs2NRd
   wuEqd1VjfkWyTUzXshStj+POxsPF1QjPpPnycYYAWN3JT3rCLZlc+KJyT
   g==;
X-CSE-ConnectionGUID: olI5JeH/SQmE564PFYb6Hw==
X-CSE-MsgGUID: 2yOW32UsQaW3MZJPM5VGqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18797891"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="18797891"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 20:40:39 -0700
X-CSE-ConnectionGUID: jbfi7S6xRKG5IoHKVPO8fQ==
X-CSE-MsgGUID: wzYJNEXARBO808kfwxXO9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="55085930"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Jul 2024 20:40:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTvWt-000fwI-1F;
	Wed, 17 Jul 2024 03:40:35 +0000
Date: Wed, 17 Jul 2024 11:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.11] BUILD SUCCESS
 415fb383ec2bbe4d4bb1a1b5593cd67eb058f1de
Message-ID: <202407171133.qCgAaFwV-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_204041_151664_562BC49B 
X-CRM114-Status: UNSURE (   4.59  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.11
branch HEAD: 415fb383ec2bbe4d4bb1a1b5593cd67eb058f1de  nvme-core: choose PIF from QPIF if QPIFS supports and PIF is QTYPE

elapsed time: 729m

configs tested: 137
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240717   gcc-13.2.0
arc                   randconfig-002-20240717   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240717   gcc-14.1.0
arm                   randconfig-002-20240717   gcc-14.1.0
arm                   randconfig-003-20240717   gcc-14.1.0
arm                   randconfig-004-20240717   clang-19
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240717   gcc-14.1.0
arm64                 randconfig-002-20240717   clang-19
arm64                 randconfig-003-20240717   clang-16
arm64                 randconfig-004-20240717   clang-19
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240717   gcc-14.1.0
csky                  randconfig-002-20240717   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240717   clang-19
hexagon               randconfig-002-20240717   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240716   clang-18
i386         buildonly-randconfig-002-20240716   clang-18
i386         buildonly-randconfig-003-20240716   clang-18
i386         buildonly-randconfig-004-20240716   clang-18
i386         buildonly-randconfig-005-20240716   clang-18
i386         buildonly-randconfig-006-20240716   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240716   clang-18
i386                  randconfig-002-20240716   clang-18
i386                  randconfig-003-20240716   gcc-9
i386                  randconfig-004-20240716   gcc-7
i386                  randconfig-005-20240716   clang-18
i386                  randconfig-006-20240716   gcc-9
i386                  randconfig-011-20240716   gcc-8
i386                  randconfig-012-20240716   clang-18
i386                  randconfig-013-20240716   gcc-8
i386                  randconfig-014-20240716   clang-18
i386                  randconfig-015-20240716   clang-18
i386                  randconfig-016-20240716   gcc-10
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240717   gcc-14.1.0
loongarch             randconfig-002-20240717   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240717   gcc-14.1.0
nios2                 randconfig-002-20240717   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240717   gcc-14.1.0
parisc                randconfig-002-20240717   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240717   clang-19
powerpc               randconfig-002-20240717   gcc-14.1.0
powerpc               randconfig-003-20240717   clang-19
powerpc64             randconfig-001-20240717   gcc-14.1.0
powerpc64             randconfig-002-20240717   gcc-14.1.0
powerpc64             randconfig-003-20240717   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240717   clang-19
riscv                 randconfig-002-20240717   clang-17
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240717   gcc-14.1.0
s390                  randconfig-002-20240717   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240717   gcc-14.1.0
sh                    randconfig-002-20240717   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240717   gcc-14.1.0
sparc64               randconfig-002-20240717   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240717   gcc-8
um                    randconfig-002-20240717   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240717   gcc-13
x86_64       buildonly-randconfig-002-20240717   gcc-13
x86_64       buildonly-randconfig-003-20240717   gcc-13
x86_64       buildonly-randconfig-004-20240717   clang-18
x86_64       buildonly-randconfig-005-20240717   clang-18
x86_64       buildonly-randconfig-006-20240717   gcc-13
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240717   gcc-7
x86_64                randconfig-002-20240717   gcc-9
x86_64                randconfig-003-20240717   clang-18
x86_64                randconfig-004-20240717   gcc-9
x86_64                randconfig-005-20240717   clang-18
x86_64                randconfig-006-20240717   gcc-11
x86_64                randconfig-011-20240717   gcc-8
x86_64                randconfig-012-20240717   clang-18
x86_64                randconfig-013-20240717   gcc-12
x86_64                randconfig-014-20240717   gcc-10
x86_64                randconfig-015-20240717   clang-18
x86_64                randconfig-016-20240717   clang-18
x86_64                randconfig-071-20240717   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-002-20240717   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

