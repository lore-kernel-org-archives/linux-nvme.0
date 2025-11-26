Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09016D11196
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 20:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7RhMGEPM+MLc+GUgJs95ruAKU2EOGbAI/+l5HSzQbRU=; b=oLScmq+IRyvbMxSxrWwGPRKzLC
	BMs8+3tHbPPUktQZsNR/t05F9pmezAFeHEhZ5vsnnE9gBynCjRtgI6sBMJifoxGEcCl6nn1VP5WMw
	+KKzb69qu5Rs4RVxYy9gtKTge0Ra/6Ez8fHIyFil2yMYGURQ2dAOq8/zVn6kS9fxfd3eMbVjUycIy
	j6IrE8GmYTNlJANCMkV8r0bXAjxkbnKBBQgsQGpppgvJ8ehtYJOnGWbmfbH5khConkhlAkp56AcdP
	j8iEJAXYfFkDBGtTMWMdiPGry/3aTzdlk/GnvWiaFVItP3v98M598WzKDA6hCXlatNSrFoZbYyN2z
	1yGla/Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOMCa-0000000FcqI-28zz;
	Wed, 26 Nov 2025 20:33:24 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOMCX-0000000Fcpq-3gu4
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 20:33:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764189201; x=1795725201;
  h=date:from:to:cc:subject:message-id;
  bh=4NATtTTVWTwMOvRIldlN9oxbZcCMTRs9nOkC9XRIpUc=;
  b=KwbTRxHCr1YoYcCrslqY4zXsURsGnejU/F1y4+dAOB/X2MvdFUncTjyu
   7EKXVzfCG/hMPYDulbr6RjSKrHrnyf5QAgY4CnhhG8ZHqhhNlQyzWE7RF
   01OrBk4gON1pPypJ+ywerZ3dp04cB3jsj8r41LqHuM166Tx6ftwc5vV9p
   x6VXRm8dH940I9CA7JuCcyhbs+eSANDWL6vYbx7Im9j8nNlLEm0rUTGDS
   cpC9uL2iQzKj3f2+OWxn0KuAu/o/Uzj8XIP4UYXub3IbI1GvqAtwq3INF
   b5n7b/NvCPU9bEKwu7HzTC5HgFHaZYUyJ5pjFnRWI3SRYMcCCH0wZZb5L
   w==;
X-CSE-ConnectionGUID: 4d657uP2T0mBJiSQ7mq4jg==
X-CSE-MsgGUID: 3j/bYn9uSOGvM9rmZPl2mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="88881190"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="88881190"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 12:33:20 -0800
X-CSE-ConnectionGUID: HU1mUWLwRX2EJnyCxNu7SA==
X-CSE-MsgGUID: 6Qitdg78RquLyQ5aaOx/0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="197531330"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 26 Nov 2025 12:33:20 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOMCT-000000003L7-3iH0;
	Wed, 26 Nov 2025 20:33:17 +0000
Date: Thu, 27 Nov 2025 04:32:25 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.19] BUILD SUCCESS WITH WARNING
 db2792e1d7696594dcd09dcc97f262e69819a820
Message-ID: <202511270419.CKiuYhyW-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_123321_959775_88384CB0 
X-CRM114-Status: UNSURE (   5.07  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.19
branch HEAD: db2792e1d7696594dcd09dcc97f262e69819a820  nvme-fabrics: add ENOKEY to no retry criteria for authentication failures

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202511260537.R9DHSTOl-lkp@intel.com

    include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Wformat=]

Warning ids grouped by kconfigs:

recent_errors
`-- arm-allyesconfig
    `-- include-linux-kern_levels.h:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-size_t-aka-unsigned-int

elapsed time: 2931m

configs tested: 62
configs skipped: 0

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251125    gcc-9.5.0
arc         randconfig-002-20251125    gcc-8.5.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251125    clang-22
arm         randconfig-002-20251125    gcc-10.5.0
arm         randconfig-003-20251125    gcc-10.5.0
arm         randconfig-004-20251125    gcc-8.5.0
arm64                   allnoconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
hexagon                 allnoconfig    clang-22
hexagon     randconfig-001-20251125    clang-19
hexagon     randconfig-002-20251125    clang-22
i386                    allnoconfig    gcc-14
loongarch               allnoconfig    clang-22
loongarch   randconfig-001-20251125    gcc-15.1.0
loongarch   randconfig-002-20251125    gcc-12.5.0
m68k                    allnoconfig    gcc-15.1.0
m68k                atari_defconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips              qi_lb60_defconfig    clang-22
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251125    gcc-8.5.0
nios2       randconfig-002-20251125    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc      randconfig-001-20251125    gcc-13.4.0
parisc      randconfig-002-20251125    gcc-10.5.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc     randconfig-001-20251125    clang-19
powerpc     randconfig-002-20251125    gcc-8.5.0
powerpc64   randconfig-001-20251125    clang-16
powerpc64   randconfig-002-20251125    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251125    gcc-8.5.0
riscv       randconfig-002-20251125    gcc-13.4.0
s390                    allnoconfig    clang-22
s390        randconfig-001-20251125    gcc-8.5.0
s390        randconfig-002-20251125    gcc-14.3.0
s390             zfcpdump_defconfig    clang-22
sh                      allnoconfig    gcc-15.1.0
sh                r7780mp_defconfig    gcc-15.1.0
sh          randconfig-001-20251125    gcc-15.1.0
sh          randconfig-002-20251125    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc       randconfig-001-20251125    gcc-14.3.0
sparc       randconfig-002-20251125    gcc-13.4.0
sparc64                alldefconfig    gcc-15.1.0
sparc64     randconfig-001-20251125    clang-22
sparc64     randconfig-002-20251125    gcc-8.5.0
um                      allnoconfig    clang-22
um          randconfig-001-20251125    clang-22
um          randconfig-002-20251125    clang-22
x86_64                  allnoconfig    clang-20
xtensa                  allnoconfig    gcc-15.1.0
xtensa             common_defconfig    gcc-15.1.0
xtensa        nommu_kc705_defconfig    gcc-15.1.0
xtensa      randconfig-001-20251125    gcc-8.5.0
xtensa      randconfig-002-20251125    gcc-8.5.0
xtensa          smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

