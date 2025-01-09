Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE3BE7719A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zy7jXmA/gIignEOQKgCCS4uycBRh9D4cNPDbETbHoKk=; b=Rrmi8Z7mYtRAM0fJLu2JxwuMdx
	xV1UJgh+rtFxh8azMYfjqZrCQ0WqqxM4eySeZVWGcxxoLSw6mHMxV4EPBtWvKuDK1FDD1/zFxD66w
	L55SRu61Jw+BwOXHi3XrMn1twPaNGWwWt5TiAMVlZlN4VuWGIFP44U7HLoc6CHah6JeoJChk1ntDU
	4O5V/jqigrjbd5idlEx+/w/e+y+x2AOc5vToTE0KWQTArT/Buyh/v2J72hyFosciNvwG7gkP1g0iM
	VweNEYMd3GNSPEcDlV9NgRo8WLKK/XD1JLB+wQl2Nl8KN0wd0jS0yFuInFBawfp9eDPr1U74mRmuF
	gNHlQmtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW0bn-0000000DQMe-3ktn;
	Thu, 09 Jan 2025 22:02:31 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW0bl-0000000DQMJ-0rdl
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 22:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736460149; x=1767996149;
  h=date:from:to:cc:subject:message-id;
  bh=PPgd3C17W+hufv97QXQbH8H5CWfs6Qx3mf9D8Jl+ixI=;
  b=m6JzJl4VC82/0kwSOwCeb/mJmPos2ujaX3jr5TNGxFEbIekZvpodI28m
   cYUg50IV7bNGYEuw8u4UZKuJ02bprzHP+WnLDopfdHVR7jcGDKHMX0Ka/
   GoO2JEeuJT7bBLnn6u+rI2S5vrkm9iiAwnJpcnaZ9AM1RlV1bg1DoZ0J7
   LN14gF7JTA1QRn8e1I8GHijNCh805jOAn/GTN5BInepWtrHWd8ILFNchH
   zGkJwzu9ByccqTtdJBDoHQMNTUJ8jcs18S/B3p9oempg538UO0rQTMVIJ
   6AgmSh8pS5UWdDJ9F9R3mAvFyTjZMCuzs3wuBoeTwzafUNNmhWedNQRGM
   g==;
X-CSE-ConnectionGUID: GS3RhyGFQfuusOQNWtvswQ==
X-CSE-MsgGUID: ZxREPKXbSP2Z4+sCSgn/mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47321221"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="47321221"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 14:02:29 -0800
X-CSE-ConnectionGUID: WAecy1VnSRCIpzttlEkANw==
X-CSE-MsgGUID: c0xB87zhQaesqyLx+CT7Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108157840"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jan 2025 14:02:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tW0bh-000IBb-18;
	Thu, 09 Jan 2025 22:02:25 +0000
Date: Fri, 10 Jan 2025 06:02:15 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.14] BUILD SUCCESS WITH WARNING
 b9973aa4d0507c4969ad87763b535edb77b7dceb
Message-ID: <202501100608.JTe1QBNW-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_140229_301882_3C88A724 
X-CRM114-Status: UNSURE (   4.69  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.14
branch HEAD: b9973aa4d0507c4969ad87763b535edb77b7dceb  nvme-pci: fix comment typo

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202501090934.Dhw69M6j-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202501091328.r4kJ6xhy-lkp@intel.com

    drivers/nvme/host/tcp.c:1578: warning: Function parameter or struct member 'queue' not described in 'nvme_tcp_set_queue_io_cpu'
    drivers/nvme/host/tcp.c:1578: warning: expecting prototype for Track the number of queues assigned to each cpu using a global per(). Prototype was for nvme_tcp_set_queue_io_cpu() instead
    drivers/nvme/host/tcp.c:1583:18: warning: variable 'n' set but not used [-Wunused-but-set-variable]
    drivers/nvme/host/tcp.c:1594:13: warning: variable 'mq_map' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- alpha-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- arc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- i386-buildonly-randconfig-006-20250109
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- loongarch-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- m68k-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- m68k-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- mips-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- openrisc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- parisc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- powerpc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   |-- drivers-nvme-host-tcp.c:warning:variable-mq_map-is-used-uninitialized-whenever-if-condition-is-false
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- s390-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   |-- drivers-nvme-host-tcp.c:warning:variable-mq_map-is-used-uninitialized-whenever-if-condition-is-false
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- s390-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- s390-randconfig-001-20250109
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- sh-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- sh-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- sparc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
|-- x86_64-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|   |-- drivers-nvme-host-tcp.c:warning:variable-mq_map-is-used-uninitialized-whenever-if-condition-is-false
|   `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used
`-- x86_64-allyesconfig
    |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
    |-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
    |-- drivers-nvme-host-tcp.c:warning:variable-mq_map-is-used-uninitialized-whenever-if-condition-is-false
    `-- drivers-nvme-host-tcp.c:warning:variable-n-set-but-not-used

elapsed time: 1456m

configs tested: 90
configs skipped: 2

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                         axs101_defconfig    gcc-13.2.0
arc                  randconfig-001-20250109    gcc-13.2.0
arc                  randconfig-002-20250109    gcc-13.2.0
arm                             alldefconfig    gcc-14.2.0
arm                              allnoconfig    clang-17
arm                         exynos_defconfig    clang-20
arm                  randconfig-001-20250109    gcc-14.2.0
arm                  randconfig-002-20250109    clang-17
arm                  randconfig-003-20250109    clang-20
arm                  randconfig-004-20250109    gcc-14.2.0
arm                       shmobile_defconfig    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250109    gcc-14.2.0
arm64                randconfig-002-20250109    clang-20
arm64                randconfig-003-20250109    gcc-14.2.0
arm64                randconfig-004-20250109    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250109    gcc-14.2.0
csky                 randconfig-002-20250109    gcc-14.2.0
hexagon                          allnoconfig    clang-20
hexagon              randconfig-001-20250109    clang-14
hexagon              randconfig-002-20250109    clang-20
i386       buildonly-randconfig-001-20250109    gcc-12
i386       buildonly-randconfig-002-20250109    gcc-12
i386       buildonly-randconfig-003-20250109    clang-19
i386       buildonly-randconfig-004-20250109    clang-19
i386       buildonly-randconfig-005-20250109    clang-19
i386       buildonly-randconfig-006-20250109    gcc-12
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250109    gcc-14.2.0
loongarch            randconfig-002-20250109    gcc-14.2.0
mips                        bigsur_defconfig    gcc-14.2.0
mips                     bmips_stb_defconfig    clang-18
nios2                randconfig-001-20250109    gcc-14.2.0
nios2                randconfig-002-20250109    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
openrisc                           defconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc                             defconfig    gcc-14.2.0
parisc               randconfig-001-20250109    gcc-14.2.0
parisc               randconfig-002-20250109    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                         allyesconfig    clang-16
powerpc                     ppc44x_defconfig    clang-20
powerpc              randconfig-001-20250109    clang-15
powerpc              randconfig-002-20250109    gcc-14.2.0
powerpc              randconfig-003-20250109    gcc-14.2.0
powerpc                     tqm8xx_defconfig    clang-20
powerpc64            randconfig-001-20250109    gcc-14.2.0
powerpc64            randconfig-002-20250109    clang-20
powerpc64            randconfig-003-20250109    clang-17
riscv                            allnoconfig    gcc-14.2.0
riscv                              defconfig    clang-19
riscv                randconfig-001-20250109    gcc-14.2.0
riscv                randconfig-002-20250109    clang-15
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250109    gcc-14.2.0
s390                 randconfig-002-20250109    clang-16
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250109    gcc-14.2.0
sh                   randconfig-002-20250109    gcc-14.2.0
sh                  rts7751r2dplus_defconfig    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250109    gcc-14.2.0
sparc                randconfig-002-20250109    gcc-14.2.0
sparc64              randconfig-001-20250109    gcc-14.2.0
sparc64              randconfig-002-20250109    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250109    gcc-12
um                   randconfig-002-20250109    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250109    clang-19
x86_64     buildonly-randconfig-002-20250109    gcc-12
x86_64     buildonly-randconfig-003-20250109    clang-19
x86_64     buildonly-randconfig-004-20250109    clang-19
x86_64     buildonly-randconfig-005-20250109    clang-19
x86_64     buildonly-randconfig-006-20250109    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250109    gcc-14.2.0
xtensa               randconfig-002-20250109    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

