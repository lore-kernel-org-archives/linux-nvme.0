Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441EFCCD183
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XPpUWHcU/Vg3ukM5LhaIi09T+LuUnSMM28r+jMSH/pk=; b=QWeiPF7pnoSxn6Iq4phYfPiCft
	nfywVYNa+j6GYMe7q61n9aupIoMwkbG9HTbqf+fkI6OSNPU+Odn8hzgqwHf6mrQQoIOxTxqRph+g3
	ZrOrrsbhhJI2uI8N2lNbmLb1uGwrbMuq8aOPrIsDze/E1htMFHkIe7jwSRT/JuIDfmuwEVK3V3iu6
	t9lUCT1DYUG7JkzheevWZlX/Fpi2Xi/xMuPggfSa1wZWwBUm37RmG/xlMZNVmGaLKSRnD+f9Ow2Gg
	6fO4+1tOZaybFhjOl+lK9yVrBI2R1GaGAbbnthWI0mfwz0bGnDqcI63gF5YtcUiknxIf+hMmf3Sb0
	+LBBO7ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6xhx-0000000776e-2JpP;
	Thu, 09 Oct 2025 20:57:53 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6xhu-0000000775V-0usW
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 20:57:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760043470; x=1791579470;
  h=date:from:to:cc:subject:message-id;
  bh=/qpCMKRanqNC2T6vZzDtzGn6asZ4Fnw+i3HIdHkd3Cw=;
  b=PYg3lKto+qQXD380rhLv9Jf9i+t7r7uKcoyj8HVOLIWO/D70Gjfx7f9I
   5UuCiBOP6BreExGlryQyckiop1J22rhVY1gYYIjT4vlvqyUdwfFWz+vo2
   ebBQlvzXdLi8ZK2whw8kEdXZYpYssP8qRbK9EXQ/uTQebEMJCIfnzQpKL
   T/8zHspXNAMSyhWW6nduWtMmdOc1mlIM2DL7rjgdl6SGL/Cyy8HWYDjRt
   /jb8EDohC/JDd3ToPOfECKlPv4X++LQ76ztyT/lp6chzrPOyrbzMOV/Nl
   iiqRt3uHkTivqaQfwKwHj++k8myxj09ELKU221jNevel1gCk4JUlPOCNf
   w==;
X-CSE-ConnectionGUID: VBBfs/7iSSOxFebaxfw3MQ==
X-CSE-MsgGUID: oQheIO+OQ7ehaX2mIHPBsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="65914279"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="65914279"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 13:57:47 -0700
X-CSE-ConnectionGUID: EP4IKfvPSBC80/vf7tv24Q==
X-CSE-MsgGUID: HeJNbpRHTj65G8VQ2Z1new==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="185191339"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Oct 2025 13:57:46 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6xhn-0001Qd-2w;
	Thu, 09 Oct 2025 20:57:43 +0000
Date: Fri, 10 Oct 2025 04:56:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.18] BUILD SUCCESS
 510d76646a6a7beaa49fc0da7282e285a3dfce97
Message-ID: <202510100449.vacUOdjW-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_135750_295344_399593E2 
X-CRM114-Status: UNSURE (   5.14  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.18
branch HEAD: 510d76646a6a7beaa49fc0da7282e285a3dfce97  block: Update a comment of disk statistics

elapsed time: 846m

configs tested: 142
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                       imx_v4_v5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251009    clang-16
csky                  randconfig-002-20251009    clang-16
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251009    clang-16
hexagon               randconfig-002-20251009    clang-16
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251009    gcc-14
i386        buildonly-randconfig-002-20251009    gcc-14
i386        buildonly-randconfig-003-20251009    gcc-14
i386        buildonly-randconfig-004-20251009    gcc-14
i386        buildonly-randconfig-005-20251009    gcc-14
i386        buildonly-randconfig-006-20251009    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251010    clang-20
i386                  randconfig-002-20251010    clang-20
i386                  randconfig-003-20251010    clang-20
i386                  randconfig-004-20251010    clang-20
i386                  randconfig-005-20251010    clang-20
i386                  randconfig-006-20251010    clang-20
i386                  randconfig-007-20251010    clang-20
i386                  randconfig-011-20251009    clang-20
i386                  randconfig-012-20251009    clang-20
i386                  randconfig-013-20251009    clang-20
i386                  randconfig-014-20251009    clang-20
i386                  randconfig-015-20251009    clang-20
i386                  randconfig-016-20251009    clang-20
i386                  randconfig-017-20251009    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251009    clang-16
loongarch             randconfig-002-20251009    clang-16
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251009    clang-16
nios2                 randconfig-002-20251009    clang-16
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251009    clang-16
parisc                randconfig-002-20251009    clang-16
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        icon_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251009    clang-16
powerpc               randconfig-002-20251009    clang-16
powerpc               randconfig-003-20251009    clang-16
powerpc64             randconfig-002-20251009    clang-16
powerpc64             randconfig-003-20251009    clang-16
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20251009    clang-22
riscv                 randconfig-002-20251009    clang-22
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251009    clang-22
s390                  randconfig-002-20251009    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                    randconfig-001-20251009    clang-22
sh                    randconfig-002-20251009    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251009    clang-22
sparc                 randconfig-002-20251009    clang-22
sparc64               randconfig-001-20251009    clang-22
sparc64               randconfig-002-20251009    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                    randconfig-001-20251009    clang-22
um                    randconfig-002-20251009    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251009    clang-20
x86_64      buildonly-randconfig-002-20251009    clang-20
x86_64      buildonly-randconfig-003-20251009    clang-20
x86_64      buildonly-randconfig-004-20251009    clang-20
x86_64      buildonly-randconfig-005-20251009    clang-20
x86_64      buildonly-randconfig-006-20251009    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20251009    gcc-14
x86_64                randconfig-072-20251009    gcc-14
x86_64                randconfig-073-20251009    gcc-14
x86_64                randconfig-074-20251009    gcc-14
x86_64                randconfig-075-20251009    gcc-14
x86_64                randconfig-076-20251009    gcc-14
x86_64                randconfig-077-20251009    gcc-14
x86_64                randconfig-078-20251009    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251009    clang-22
xtensa                randconfig-002-20251009    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

