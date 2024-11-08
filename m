Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4961ED5E145
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 08:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B1tmaNRI+1A7r7DO7+CpFmRgleAZRDSS1XcIJEPTUAs=; b=h/3fHY6z9BILu6IdVUu7UD+JgI
	ohJoSp74HAbv4nEI9jssKyF9p4PTu5dBb9mm/FMCgwvMyBIHz0WgGIfWCxzD1Hfyd8iNFFVSr1oMu
	YVL+1Bu6DJY9IQv3zK91AfAh8FyKWiVuO5Ucz8Bt2JucIQ+qrI4hlqb+7Y8FCuqgOaqJYVPWqC4EP
	y+Go/LGJ3G12htoCts2x17QX5fEAm90Oe1lLjM5ZpgV4G+MbCnBDbEAsReBdQMGw7+nC3LV35Q2+i
	sEcc0t57VrNA91Ll6KH7xcfWRO56h2Ja9nkylb3SJzy3YknKiCRwUduSyZENC7ELl0/2w4gigJWHX
	WCVFeYDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9K92-00000009jV4-2BT5;
	Fri, 08 Nov 2024 08:15:04 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9K8z-00000009jUM-1eBj
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 08:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731053701; x=1762589701;
  h=date:from:to:cc:subject:message-id;
  bh=d6an5qiiCpL/YQ8xMwt3WSzuvHXNy9ZEh6NcuVvL56o=;
  b=iXkikA3EpjnS6oSGWQCPG+3/FBLYaeSSG0vn0iYKVB+W1DTJrrHI8hcT
   I7CeUtCHTtRAnYTWYyQOoeC86Kz8Rc7GSyTSFk9UnPEeqSy41uf4XfaVr
   rt0d4d/WfElVVoGdPOJBlUG+ynsmeEy2RrXugxmYim0+PONAFknYYr5ou
   g4xDvuUOQTbtQHYRd4s+PiPk5P1hqVnJxmAkJvltYLKg5WEqzmsL2DmBc
   Ju1gJqnAWvce7PP2a4M0Rf4Y0CsaRKcE1DHIHzKE4tJPkCi1UQcUFuBSI
   kDsCYXOA4yGCb+n+c10o32Uu94aXQEsFHQPKbLKiPq3iJ6h+FpXw65Zqm
   w==;
X-CSE-ConnectionGUID: 9mBNheq6QNqhgEWgmv/dvQ==
X-CSE-MsgGUID: LiQyzgctR0iMmI0hQFv0TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="48439594"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="48439594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:14:56 -0800
X-CSE-ConnectionGUID: nS6J4dArQf2IDkys3pwneQ==
X-CSE-MsgGUID: q/VEdqgTRou/fG9x69eh9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85438891"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Nov 2024 00:14:55 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9K8r-000rCZ-0P;
	Fri, 08 Nov 2024 08:14:53 +0000
Date: Fri, 08 Nov 2024 16:14:00 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 4c0ce9416cd06e9ef0e049f7a9226707c3786b1a
Message-ID: <202411081654.jiaDsdZp-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_001501_738211_12D672F7 
X-CRM114-Status: UNSURE (   5.04  )
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
branch HEAD: 4c0ce9416cd06e9ef0e049f7a9226707c3786b1a  nvmet: support reservation feature

Unverified Warning (likely false positive, kindly check if interested):

    drivers/nvme/target/pr.c:851 nvmet_execute_pr_report() warn: potential pointer math issue ('ctrl_eds' is a 512 bit pointer)

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-randconfig-r113-20241108
|   `-- drivers-nvme-target-pr.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-cntlid-got-int
|-- i386-randconfig-141-20241108
|   `-- drivers-nvme-target-pr.c-nvmet_execute_pr_report()-warn:potential-pointer-math-issue-(-ctrl_eds-is-a-bit-pointer)
|-- x86_64-randconfig-121-20241108
|   `-- drivers-nvme-target-pr.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-cntlid-got-int
|-- x86_64-randconfig-122-20241108
|   `-- drivers-nvme-target-pr.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-cntlid-got-int
|-- x86_64-randconfig-123-20241108
|   `-- drivers-nvme-target-pr.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-cntlid-got-int
`-- x86_64-randconfig-r133-20241108
    `-- drivers-nvme-target-pr.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le16-usertype-cntlid-got-int

elapsed time: 734m

configs tested: 171
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                      axs103_smp_defconfig    clang-20
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                            hsdk_defconfig    clang-14
arc                           tb10x_defconfig    gcc-14.2.0
arc                    vdk_hs38_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                            dove_defconfig    clang-14
arm                          ep93xx_defconfig    clang-14
arm                           h3600_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    gcc-14.2.0
arm                      integrator_defconfig    gcc-14.2.0
arm                        keystone_defconfig    clang-20
arm                        neponset_defconfig    gcc-14.2.0
arm                           omap1_defconfig    gcc-14.2.0
arm                       omap2plus_defconfig    gcc-14.2.0
arm                           sama7_defconfig    clang-14
arm                           sama7_defconfig    gcc-14.2.0
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241108    clang-19
i386        buildonly-randconfig-002-20241108    clang-19
i386        buildonly-randconfig-003-20241108    clang-19
i386        buildonly-randconfig-004-20241108    clang-19
i386        buildonly-randconfig-005-20241108    clang-19
i386        buildonly-randconfig-006-20241108    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241108    clang-19
i386                  randconfig-002-20241108    clang-19
i386                  randconfig-003-20241108    clang-19
i386                  randconfig-004-20241108    clang-19
i386                  randconfig-005-20241108    clang-19
i386                  randconfig-006-20241108    clang-19
i386                  randconfig-011-20241108    clang-19
i386                  randconfig-012-20241108    clang-19
i386                  randconfig-013-20241108    clang-19
i386                  randconfig-014-20241108    clang-19
i386                  randconfig-015-20241108    clang-19
i386                  randconfig-016-20241108    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
m68k                             alldefconfig    clang-20
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
mips                           jazz_defconfig    gcc-14.2.0
mips                     loongson1b_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-14
mips                   sb1250_swarm_defconfig    clang-14
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    clang-14
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    clang-14
powerpc                      chrp32_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-14
powerpc                     mpc512x_defconfig    clang-14
powerpc               mpc834x_itxgp_defconfig    clang-14
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc                      pmac32_defconfig    gcc-14.2.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-14
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                  storcenter_defconfig    clang-20
powerpc                     taishan_defconfig    clang-20
powerpc                     tqm8541_defconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    gcc-14.2.0
s390                             alldefconfig    clang-14
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    clang-20
sh                          kfr2r09_defconfig    clang-14
sh                            migor_defconfig    clang-14
sh                   rts7751r2dplus_defconfig    clang-20
sh                          sdk7786_defconfig    clang-20
sh                           se7724_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sh                            titan_defconfig    clang-20
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
x86_64      buildonly-randconfig-001-20241108    clang-19
x86_64      buildonly-randconfig-002-20241108    clang-19
x86_64      buildonly-randconfig-003-20241108    clang-19
x86_64      buildonly-randconfig-004-20241108    clang-19
x86_64      buildonly-randconfig-005-20241108    clang-19
x86_64      buildonly-randconfig-006-20241108    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241108    clang-19
x86_64                randconfig-002-20241108    clang-19
x86_64                randconfig-003-20241108    clang-19
x86_64                randconfig-004-20241108    clang-19
x86_64                randconfig-005-20241108    clang-19
x86_64                randconfig-006-20241108    clang-19
x86_64                randconfig-011-20241108    clang-19
x86_64                randconfig-012-20241108    clang-19
x86_64                randconfig-013-20241108    clang-19
x86_64                randconfig-014-20241108    clang-19
x86_64                randconfig-015-20241108    clang-19
x86_64                randconfig-016-20241108    clang-19
x86_64                randconfig-071-20241108    clang-19
x86_64                randconfig-072-20241108    clang-19
x86_64                randconfig-073-20241108    clang-19
x86_64                randconfig-074-20241108    clang-19
x86_64                randconfig-075-20241108    clang-19
x86_64                randconfig-076-20241108    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                         virt_defconfig    clang-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

