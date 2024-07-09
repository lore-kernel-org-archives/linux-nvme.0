Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DA3C2BD09
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vNtD5NpkmCOz3eHZHSs6fEfPD2eX4F8PRAg3A1sXohk=; b=Gyo2qsH/XsY3KS7E8b7e4lnPhU
	/MqUL4ynyqzbbM3HsaoLZqD59PJDuupzGHd/ho++hOO8MfhH2mIy4DsDRpAsr3qdIhou1uakEpJyh
	pNM7dSNzU1S9b0TMtx0LPtkUWcma8Ns0jdWIkKjpQ+3gYFLoP6hX0Bilw6BXChLWfPdOK0C3Zty39
	bgEuD9NhnMBLB6IVsow3QTcNU/7f60QYeH4fZILiGYro5Jcy9mclv+M6P+tK278SvzjIZBAlhDpP+
	Vr9GbqjOEtY2kMjFkq5yzwcxtdd/gjmc2zLvYrQ2COfMSdjMlbSeAlSs4L4oG0KR6pzoD34X9dIcQ
	AFbyvZTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR9nl-0000000761P-0vfX;
	Tue, 09 Jul 2024 12:18:33 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR9ni-0000000760y-45rX
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 12:18:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720527511; x=1752063511;
  h=date:from:to:cc:subject:message-id;
  bh=xBBHsDTYbtJAUlt7W8Dr3iD1eal8C0TjApMvNG+Ycyo=;
  b=Ub+A55CrBIqk4vJi6r8frkOZTIrx2HGnnSUaVOMG6mbakqOSDT39JFw0
   yFgLEw81VXo3BH5RHNjimHnUZfL8pYNc4I3z4d3Pekv6EYdK1QG6SgSRy
   o/fSwaj5jeBLkBz7P0Hp9YRiF9FYC9hRRUxPA300QxfwUG02Wk831+Kl9
   iRSP7ctSFo79KknNxFz73SBvLgeI+GtTM2ujvvOf5HfZdttNSzm9oOXGq
   qA9qM7pQvFYgsP4EvgxZLXMg1WcrIz1/hg+x53NxyExxBTcbn3YW2kRAk
   cNMFf+X0hEF0msnovU3oxP4CE/td5ZaAO1mhOtgnx/GCXe+DXMnLNyhtj
   A==;
X-CSE-ConnectionGUID: 1Q+gEQa+Qd+Gu9g5q4U3yA==
X-CSE-MsgGUID: 2ng0V4eMT6CKAs61Km5WVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="21545439"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="21545439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 05:18:27 -0700
X-CSE-ConnectionGUID: OX6XQIHZTR2ZxQGUv6a1vQ==
X-CSE-MsgGUID: XsYQfM6RSR+8OGaC3+uLxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="85379753"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Jul 2024 05:18:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sR9nb-000Weh-39;
	Tue, 09 Jul 2024 12:18:23 +0000
Date: Tue, 09 Jul 2024 20:17:30 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-fdp] BUILD SUCCESS
 266c0b5092161ad0e83155552944f223e8ef1680
Message-ID: <202407092028.49DOa7P9-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_051831_138356_65FD1B74 
X-CRM114-Status: UNSURE (   5.00  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-fdp
branch HEAD: 266c0b5092161ad0e83155552944f223e8ef1680  nvme: enable FDP support

elapsed time: 1098m

configs tested: 228
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240709   gcc-13.2.0
arc                   randconfig-002-20240709   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.2.0
arm                   randconfig-001-20240709   gcc-13.2.0
arm                   randconfig-002-20240709   clang-19
arm                   randconfig-002-20240709   gcc-13.2.0
arm                   randconfig-003-20240709   clang-19
arm                   randconfig-003-20240709   gcc-13.2.0
arm                   randconfig-004-20240709   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240709   clang-19
arm64                 randconfig-001-20240709   gcc-13.2.0
arm64                 randconfig-002-20240709   clang-17
arm64                 randconfig-002-20240709   gcc-13.2.0
arm64                 randconfig-003-20240709   clang-19
arm64                 randconfig-003-20240709   gcc-13.2.0
arm64                 randconfig-004-20240709   clang-19
arm64                 randconfig-004-20240709   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240709   gcc-13.2.0
csky                  randconfig-002-20240709   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240709   clang-19
hexagon               randconfig-002-20240709   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240709   gcc-11
i386         buildonly-randconfig-002-20240709   gcc-11
i386         buildonly-randconfig-002-20240709   gcc-13
i386         buildonly-randconfig-003-20240709   clang-18
i386         buildonly-randconfig-003-20240709   gcc-11
i386         buildonly-randconfig-004-20240709   clang-18
i386         buildonly-randconfig-004-20240709   gcc-11
i386         buildonly-randconfig-005-20240709   clang-18
i386         buildonly-randconfig-005-20240709   gcc-11
i386         buildonly-randconfig-006-20240709   clang-18
i386         buildonly-randconfig-006-20240709   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240709   gcc-11
i386                  randconfig-001-20240709   gcc-13
i386                  randconfig-002-20240709   clang-18
i386                  randconfig-002-20240709   gcc-11
i386                  randconfig-003-20240709   gcc-11
i386                  randconfig-004-20240709   gcc-11
i386                  randconfig-004-20240709   gcc-13
i386                  randconfig-005-20240709   gcc-11
i386                  randconfig-005-20240709   gcc-13
i386                  randconfig-006-20240709   gcc-11
i386                  randconfig-006-20240709   gcc-13
i386                  randconfig-011-20240709   clang-18
i386                  randconfig-011-20240709   gcc-11
i386                  randconfig-012-20240709   gcc-11
i386                  randconfig-012-20240709   gcc-13
i386                  randconfig-013-20240709   gcc-11
i386                  randconfig-013-20240709   gcc-12
i386                  randconfig-014-20240709   clang-18
i386                  randconfig-014-20240709   gcc-11
i386                  randconfig-015-20240709   clang-18
i386                  randconfig-015-20240709   gcc-11
i386                  randconfig-016-20240709   gcc-10
i386                  randconfig-016-20240709   gcc-11
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240709   gcc-13.2.0
loongarch             randconfig-002-20240709   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                       bvme6000_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         cobalt_defconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                    maltaup_xpa_defconfig   gcc-13.2.0
nios2                         3c120_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240709   gcc-13.2.0
nios2                 randconfig-002-20240709   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                    or1ksim_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240709   gcc-13.2.0
parisc                randconfig-002-20240709   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                   lite5200b_defconfig   gcc-13.2.0
powerpc                      mgcoge_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                     powernv_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240709   clang-19
powerpc               randconfig-001-20240709   gcc-13.2.0
powerpc               randconfig-002-20240709   gcc-13.2.0
powerpc               randconfig-003-20240709   clang-15
powerpc               randconfig-003-20240709   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                      tqm8xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240709   gcc-13.2.0
powerpc64             randconfig-002-20240709   gcc-13.2.0
powerpc64             randconfig-003-20240709   clang-19
powerpc64             randconfig-003-20240709   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240709   clang-17
riscv                 randconfig-001-20240709   gcc-13.2.0
riscv                 randconfig-002-20240709   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240709   gcc-13.2.0
s390                  randconfig-002-20240709   clang-19
s390                  randconfig-002-20240709   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        dreamcast_defconfig   gcc-13.2.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                            hp6xx_defconfig   gcc-13.2.0
sh                    randconfig-001-20240709   gcc-13.2.0
sh                    randconfig-002-20240709   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                          alldefconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240709   gcc-13.2.0
sparc64               randconfig-002-20240709   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240709   gcc-13
um                    randconfig-001-20240709   gcc-13.2.0
um                    randconfig-002-20240709   gcc-11
um                    randconfig-002-20240709   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240709   gcc-11
x86_64       buildonly-randconfig-002-20240709   gcc-11
x86_64       buildonly-randconfig-003-20240709   gcc-11
x86_64       buildonly-randconfig-004-20240709   gcc-11
x86_64       buildonly-randconfig-005-20240709   gcc-11
x86_64       buildonly-randconfig-006-20240709   gcc-11
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240709   gcc-11
x86_64                randconfig-002-20240709   gcc-11
x86_64                randconfig-003-20240709   gcc-11
x86_64                randconfig-004-20240709   gcc-11
x86_64                randconfig-005-20240709   gcc-11
x86_64                randconfig-006-20240709   gcc-11
x86_64                randconfig-011-20240709   gcc-11
x86_64                randconfig-012-20240709   gcc-11
x86_64                randconfig-013-20240709   gcc-11
x86_64                randconfig-014-20240709   gcc-11
x86_64                randconfig-015-20240709   gcc-11
x86_64                randconfig-016-20240709   gcc-11
x86_64                randconfig-071-20240709   gcc-11
x86_64                randconfig-072-20240709   gcc-11
x86_64                randconfig-073-20240709   gcc-11
x86_64                randconfig-074-20240709   gcc-11
x86_64                randconfig-075-20240709   gcc-11
x86_64                randconfig-076-20240709   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240709   gcc-13.2.0
xtensa                randconfig-002-20240709   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

