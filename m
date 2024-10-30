Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D247FD74954
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 03:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lcvFB5AqUtvPnog6PzTkUDs4E4N2JP9DdXCxrhC97A8=; b=CLzsolKgs/jLYbzz8b6ZwcIVYo
	wndiOJRPJYI4OqIoO1X6fSzBIccCf71CHPrdNgKEjih2XFjNDPcb8zHIXJzR7AliNE+rrRfcoeW6y
	VTRsXA1uzQY4c5C6RpphMEHCwOwITpJF2IUp9QGeGPbFQE43PHg4cItiZoGbYqBe/F1Aq+UJ3vWhP
	bzpaonNBHDYO7BLCuVAizC3GgT8YwsP+scIzDsyXKnWq/5IfCWRNwW8+I6UzhBz1ne4w1WAs1ayP/
	WboUYv1xjsJZIO94PwBhAsDSB3Q8PU19wzGEALIKMDI+o5Q7ZYlWuBNB9XcydrHpCjEvp/mmSlxS8
	VdzBd4pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5zBO-0000000GaHl-2vDn;
	Wed, 30 Oct 2024 03:15:42 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5y9W-0000000GUxH-2eC9
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 02:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730254182; x=1761790182;
  h=date:from:to:cc:subject:message-id;
  bh=0a9N687trTriW3xPnlK1DMIKbfYiSKmotdgkGz0tAwA=;
  b=FeYETg3M1T+6bLym1GSZeCvVtJHdtMXrz1LOJQiUWHxPpw/fYiPwaCb0
   kRZkVeiFl1/2y2ujWcZ8N/+HrWDnNkTrLU+Yv71Stof2N09ZKkKPOPbKm
   7Lb3q8EbIx0hoiedjtpSvEDweQV0sCqqRjyZMoy0qDqC/kP68jW+djozx
   C4EpJYvUMweGEUyqcELWpvXvVoS98JGC1d0cMhAmMhom1tXRSzZ7yMvJ3
   4odUerFOgawhAvkSJNGbuN0CqZbmn1FbiCnWwovYpIhFnf86gl8vq8Ji8
   Ma3TVlawYXy4DYf4XVMJTFnTkYTwVh8czVGJ3opgzxdyue7XIJdeKqtH7
   A==;
X-CSE-ConnectionGUID: T/ytmIbORHSvsiFk9vGqMw==
X-CSE-MsgGUID: Nuee/H6vR16MkVv0H9UW0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33735788"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="33735788"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 19:09:42 -0700
X-CSE-ConnectionGUID: 5oqFiHedQwqI9DYTSN/qfQ==
X-CSE-MsgGUID: OK6bdHN0Qeq6AYHs9J/rHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82971053"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 29 Oct 2024 19:09:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5y9S-000eOw-0l;
	Wed, 30 Oct 2024 02:09:38 +0000
Date: Wed, 30 Oct 2024 10:08:46 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.12] BUILD SUCCESS
 2d89ef5c62fef1fbfc90a55f9e97aed8de0b3818
Message-ID: <202410301040.2X9lsrqL-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_190942_761363_49ED0911 
X-CRM114-Status: UNSURE (   5.10  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.12
branch HEAD: 2d89ef5c62fef1fbfc90a55f9e97aed8de0b3818  nvme: re-fix error-handling for io_uring nvme-passthrough

elapsed time: 728m

configs tested: 76
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
alpha              defconfig    gcc-14.1.0
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arc                defconfig    gcc-14.1.0
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm                defconfig    gcc-14.1.0
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
arm64              defconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
csky               defconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
hexagon            defconfig    gcc-14.1.0
i386            allmodconfig    clang-19
i386             allnoconfig    clang-19
i386            allyesconfig    clang-19
i386               defconfig    clang-19
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
loongarch          defconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
m68k               defconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
microblaze         defconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
nios2              defconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
parisc64           defconfig    gcc-14.1.0
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-19
x86_64          allyesconfig    clang-19
x86_64             defconfig    clang-19
x86_64                 kexec    clang-19
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

