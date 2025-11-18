Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C259FCEE35B
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 21:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NJXp5uhIaPgT5D5p3uLglDYSOOkBsAMy0g3AT+kN16E=; b=PA7VNP6mNGejaOk3KoBlgs10aK
	e+WpSRWCqp0Rz7sLo/R+YXzX2a3aXPdw1V++O8exq+TzGdEkhkYLbMkeueW97Jg36Zuq219RwhjZe
	1zDg5Rdhn+s6k4GqQZrD1ztGH8AUm5lZahNunG7t/2Ist8Mu51CkGQo/4THQWxAQEpTe1PK4dhpEo
	CNWhT5Wx6tSAhyF1ROYXSRJ5UWR/5H1P04P7nCThaXEL7CplCIi2PRoxjSAcJFF2sBWVYWQUgJqA6
	/PMHCpZ3xytSwkIxZc/esehYl+wfTmHKs3YG/xM+2KGp5z65FWjwicspM8gaOmH5FzbC7iFaCMJkm
	nqX8Z8Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLTKK-000000017xB-41QT;
	Tue, 18 Nov 2025 21:33:28 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLTKH-000000017wo-1Dyl
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 21:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763501605; x=1795037605;
  h=date:from:to:cc:subject:message-id;
  bh=nvmwpQuWru2+5PEZpKGM4QL1ySSq+lnaMAt2UthP37o=;
  b=eyar9yc1Gf0I+1VDlvUjrZskLTle24UypE22eEGKyPFZruSUKdWVwLo7
   QEHZd39awfkDZLTDqKqq64skkM6riULJjawoqQu4xe0VTznzZuGzFaFbU
   YmC5JHuaFef4AD9w0SkewgbacuYpVb6L6DSbSQWiXPxtxr8fbmPwlFQsL
   eYSXLasSCnCHGbAj14aQHVtBUb2ZHwQoKAUzsuUk6VdlOUUHo+bbqU+XU
   uY4rHwb77w6HZxSnBF2sJ+6HwJqhjZIW4rOU5ZFEakTGAgUR12mFVFGef
   ipwDfNIdpG1wH8j2T0IYO2WopkrEr2tl5SdJGjw6fwqRqtpRTnX7lUg4Q
   A==;
X-CSE-ConnectionGUID: Iqa40uatRmCj6XFxD9L2tw==
X-CSE-MsgGUID: rb02qku/Qf6fpoJfFcU2RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="64538831"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="64538831"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 13:33:19 -0800
X-CSE-ConnectionGUID: ZALai/98TDeBNQaoao7ZQA==
X-CSE-MsgGUID: PeNzmB/zRzSZCWew26egug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="194988494"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Nov 2025 13:33:18 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLTK8-0002CX-0X;
	Tue, 18 Nov 2025 21:33:16 +0000
Date: Wed, 19 Nov 2025 05:32:28 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.18] BUILD SUCCESS
 0a2c5495b6d1ecb0fa18ef6631450f391a888256
Message-ID: <202511190523.riwokIYn-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_133325_347133_793D7E4F 
X-CRM114-Status: UNSURE (   5.51  )
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
branch HEAD: 0a2c5495b6d1ecb0fa18ef6631450f391a888256  nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

elapsed time: 1637m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20251118    gcc-14.3.0
arc                   randconfig-002-20251118    gcc-15.1.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                          gemini_defconfig    clang-20
arm                   randconfig-001-20251118    gcc-8.5.0
arm                   randconfig-002-20251118    gcc-10.5.0
arm                   randconfig-003-20251118    clang-22
arm                   randconfig-004-20251118    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251118    clang-20
arm64                 randconfig-002-20251118    clang-22
arm64                 randconfig-003-20251118    clang-19
arm64                 randconfig-004-20251118    clang-17
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251118    gcc-10.5.0
csky                  randconfig-002-20251118    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251118    clang-16
hexagon               randconfig-002-20251118    clang-22
i386                              allnoconfig    gcc-14
i386                  randconfig-001-20251118    clang-20
i386                  randconfig-002-20251118    clang-20
i386                  randconfig-003-20251118    gcc-14
i386                  randconfig-004-20251118    gcc-14
i386                  randconfig-005-20251118    clang-20
i386                  randconfig-006-20251118    gcc-14
i386                  randconfig-007-20251118    gcc-14
i386                  randconfig-011-20251118    gcc-14
i386                  randconfig-012-20251118    gcc-12
i386                  randconfig-014-20251118    gcc-14
i386                  randconfig-015-20251118    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251118    gcc-15.1.0
loongarch             randconfig-002-20251118    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251118    gcc-11.5.0
nios2                 randconfig-002-20251118    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251118    gcc-14.3.0
parisc                randconfig-002-20251118    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251118    clang-22
powerpc               randconfig-002-20251118    clang-22
powerpc                    socrates_defconfig    gcc-15.1.0
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20251118    gcc-13.4.0
powerpc64             randconfig-002-20251118    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251118    gcc-10.5.0
riscv                 randconfig-002-20251118    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-002-20251118    gcc-9.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20251118    gcc-11.5.0
sh                    randconfig-002-20251118    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251119    gcc-15.1.0
sparc                 randconfig-002-20251119    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251119    gcc-15.1.0
sparc64               randconfig-002-20251119    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251119    gcc-14
x86_64      buildonly-randconfig-002-20251119    gcc-14
x86_64      buildonly-randconfig-003-20251119    clang-20
x86_64      buildonly-randconfig-004-20251119    clang-20
x86_64      buildonly-randconfig-005-20251119    gcc-14
x86_64      buildonly-randconfig-006-20251119    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20251118    gcc-13
x86_64                randconfig-072-20251118    clang-20
x86_64                randconfig-073-20251118    gcc-14
x86_64                randconfig-074-20251118    gcc-13
x86_64                randconfig-075-20251118    gcc-14
x86_64                randconfig-076-20251118    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

