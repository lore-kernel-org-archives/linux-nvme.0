Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C4BD41D55
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 06:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TUbQTUy9cZ7PuAbtE3ge8wU69wzq7Kd19Plbo2I/L+A=; b=t6LTiAZH3R4H4p+OBtmumG/EOE
	QZQOjWPtp7uF7SUJLLx9vJo0cdJX0vYuMqGitdeppmy3YoeT728qwsTF+dZy7T3tNNKSyeQ7y76Dx
	ry3cOhhvQRx6XzqQPbt0BZDnn4pWAD/YGo43TyZ0sQplX05nXMG8VPJ9YzvEA7HeuC5NrMEB7xybP
	XAg9XUA2E5jN2PjOM/a/Wvz/LA39ZmVHFVhm2iiQaAc4WQrBqnSEYgAfEJ9tRyqUTnsdTG5v72utr
	a+rG6k58hzi8TNt+5gw8OEPnFMdHCl+ZtA8U8/qcYLPHEPlTu0GJxtm2kRIG7Se587eHP3Y6Y6CPU
	k6zVXqQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAjzM-00000002J18-0wTF;
	Tue, 12 Nov 2024 06:02:56 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAjzH-00000002Iyy-3Mhr
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 06:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731391372; x=1762927372;
  h=date:from:to:cc:subject:message-id;
  bh=qmMdeO9eCqMp+Tku4hqVBx51wh1Ujw4UfQhMr7PTEkg=;
  b=J+wmQdbiPXe8TUhxgZCDEdmA81URhzs2c09Q4TW+Hd9WdmToyzB1HTmu
   Rz7PPI9+aRIZXsr6plDiLqW/5BQZ7EHmj0CfHRrXgTKvkEm/3DazBLD5Q
   7nbe4NTM1r92wgg7fSTvSan6VdimDMt/hIYm1pwAD/bftWv5VR/cilHAv
   P1d4tzzEMNbFTWu7m/22nQ8Q876I8IhcVg2kmh5dT/6/bzj7SyhA3vdeK
   VQ8GqhViCyIbA1hbPT+vVFNGrCtJ8wkaH35RUL02JVDo4oiSNji+Iyc52
   n34VEZr1z+cxoIy9SZlpS9LwUEcJzVnjoV6ZWmUyHBu8xSPlq1ssA0C0W
   A==;
X-CSE-ConnectionGUID: C/j0UINjRQy2+n87gBTb3A==
X-CSE-MsgGUID: ZFCMo8xzQcmeN1K+yH7jIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="41835405"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="41835405"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 22:02:44 -0800
X-CSE-ConnectionGUID: n1VZYAusRlGzVMKow7Easw==
X-CSE-MsgGUID: CXTVY+FxSa2d0yKsrTV53g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92234721"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Nov 2024 22:02:43 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAjz6-0000WT-1V;
	Tue, 12 Nov 2024 06:02:40 +0000
Date: Tue, 12 Nov 2024 14:02:32 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 8a825d22a70915bd80c811fa93538cf2540af29d
Message-ID: <202411121425.vJcc2dHO-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_220251_927934_2FB0D7BB 
X-CRM114-Status: UNSURE (   5.47  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.13
branch HEAD: 8a825d22a70915bd80c811fa93538cf2540af29d  nvme: check ns's volatile write cache not present

elapsed time: 727m

configs tested: 152
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                        nsim_700_defconfig    gcc-14.2.0
arc                           tb10x_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                          collie_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                        mvebu_v7_defconfig    gcc-14.2.0
arm                       omap2plus_defconfig    gcc-14.2.0
arm                          pxa168_defconfig    gcc-14.2.0
arm                        realview_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241112    clang-19
i386        buildonly-randconfig-002-20241112    clang-19
i386        buildonly-randconfig-003-20241112    clang-19
i386        buildonly-randconfig-004-20241112    clang-19
i386        buildonly-randconfig-005-20241112    clang-19
i386        buildonly-randconfig-006-20241112    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241112    clang-19
i386                  randconfig-002-20241112    clang-19
i386                  randconfig-003-20241112    clang-19
i386                  randconfig-004-20241112    clang-19
i386                  randconfig-005-20241112    clang-19
i386                  randconfig-006-20241112    clang-19
i386                  randconfig-011-20241112    clang-19
i386                  randconfig-012-20241112    clang-19
i386                  randconfig-013-20241112    clang-19
i386                  randconfig-014-20241112    clang-19
i386                  randconfig-015-20241112    clang-19
i386                  randconfig-016-20241112    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                           ip32_defconfig    gcc-14.2.0
mips                          rb532_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc64                         alldefconfig    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    gcc-14.2.0
powerpc                     skiroot_defconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          landisk_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241112    gcc-12
x86_64      buildonly-randconfig-002-20241112    gcc-12
x86_64      buildonly-randconfig-003-20241112    gcc-12
x86_64      buildonly-randconfig-004-20241112    gcc-12
x86_64      buildonly-randconfig-005-20241112    gcc-12
x86_64      buildonly-randconfig-006-20241112    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241112    gcc-12
x86_64                randconfig-002-20241112    gcc-12
x86_64                randconfig-003-20241112    gcc-12
x86_64                randconfig-004-20241112    gcc-12
x86_64                randconfig-005-20241112    gcc-12
x86_64                randconfig-006-20241112    gcc-12
x86_64                randconfig-011-20241112    gcc-12
x86_64                randconfig-012-20241112    gcc-12
x86_64                randconfig-013-20241112    gcc-12
x86_64                randconfig-014-20241112    gcc-12
x86_64                randconfig-015-20241112    gcc-12
x86_64                randconfig-016-20241112    gcc-12
x86_64                randconfig-071-20241112    gcc-12
x86_64                randconfig-072-20241112    gcc-12
x86_64                randconfig-073-20241112    gcc-12
x86_64                randconfig-074-20241112    gcc-12
x86_64                randconfig-075-20241112    gcc-12
x86_64                randconfig-076-20241112    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

