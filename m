Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E39CD3431
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 12:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xpaDiAt0dT14e65AN1OJtS8JYV0B36H3ISnxboXqd0s=; b=KGhU9DtP2YkwtlCAhfrtXqqRQy
	8BuYm3MMrr07Pg3y9Y1xSbqZdrz7UigMh69aj+HO3Sig7je/m132WS066GHMeHGE2Q8OEqHF+X1s6
	ZC2nm7oPwxP4sVZwPKU2lghDmAOWJByBJtbGn7qz4KpIUObx+crfEColOPh2Qn3f0NjuM94lmBlFL
	h9U0h3F8FmoYQvSznDj//odN/r3xTW4BraWuV7iaAxMPGvRHZu1AfN6quOYJ+2wJ+YIPYqmctMTSI
	KvS3Yqem5SaM+ZUR8YKDdL0lLeeNwoH8WgthPRMzoNWW9H/0jVOd5vK1lxLl9YDSBbPTwGU5vTOlk
	coKsJXnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slpBU-00000004NDp-3Xfn;
	Wed, 04 Sep 2024 12:32:28 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slpBJ-00000004NCz-0GPz
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 12:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725453137; x=1756989137;
  h=date:from:to:cc:subject:message-id;
  bh=4DlsvUyJc2KDrDABh8XHcHxgyrx1to7UNQ+2mAouaXU=;
  b=OIrseFwiZkoaYyVZKDw/NZJX5fzyHIb6fWqPSPEyRtMzYs5PvxlYwPWV
   7bhBLhifhCmucMrsnZP+1pSGqS2Ldm81WgthCLvksFW/bXnTGwiukfMoE
   YTERnOpFvnTeqGkwu9L7GwwKcYO/fGDCDij5A8wIKZG4gyqTHALX+LyPj
   sMdpmNABZr19fbb8JzfuY2g6KAvtCaPFsozoVoYA0JQie1Zu3JyVepUDU
   45n+BuqtM8hbmbt5/UC2gDxOfgXoa3cBZmZ4e/Ty7rb4GJRIU4SexP8YA
   WjpILFyTmvh9gZF6RGwDXv484jiDCgDROosSW2Kc/0h3adEoRVYA74jfR
   g==;
X-CSE-ConnectionGUID: 9rGZbQ8QQSmjRsSdm/36pQ==
X-CSE-MsgGUID: V/wFHP7XSiiU7M7EzcqUzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24301673"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24301673"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:32:17 -0700
X-CSE-ConnectionGUID: 50xnVpyJTieuGD2x/0EOrg==
X-CSE-MsgGUID: q10KKKHPTiiJVb81jAYAxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="70123153"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 04 Sep 2024 05:32:16 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slpBF-00083H-1T;
	Wed, 04 Sep 2024 12:32:13 +0000
Date: Wed, 04 Sep 2024 20:32:01 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.11] BUILD SUCCESS
 899d2e5a4e3d36689e8938e152f4b69a4bcc6b4d
Message-ID: <202409042059.4wEV3MNJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_053217_136510_3EB4C15A 
X-CRM114-Status: UNSURE (   5.11  )
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
branch HEAD: 899d2e5a4e3d36689e8938e152f4b69a4bcc6b4d  nvmet: Identify-Active Namespace ID List command should reject invalid nsid

elapsed time: 1108m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                        neponset_defconfig   gcc-14.1.0
arm                         socfpga_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                             alldefconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          multi_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           gcw0_defconfig   gcc-14.1.0
mips                           ip28_defconfig   gcc-14.1.0
mips                           jazz_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                 simple_smp_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                     akebono_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   gcc-14.1.0
powerpc                          g5_defconfig   gcc-14.1.0
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          sdk7786_defconfig   gcc-14.1.0
sh                           se7724_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

