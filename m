Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48095C02185
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jan 2025 01:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wKKNSvA/FHlRkXq6rWb+x+F54e8IXns6yACRFFnQoZo=; b=eHowMR38JfEMudFtgXtrW1EbH0
	jSRaxLPfzVB9jtrJxN66JY/lgqiWrbaWGycEOkPpmVIpc82mVq/VfwOdV72jPIouLo/nUjlnlvrtu
	A3givvD2nynq4nzGHl84rTunAsw4y4UX+5a6fWhM9jgDKY3YYWT90XGWiZUMguWCr1fFl5l+FV1d2
	DeVqSjBcshe7SMblGKqrv4+HzgNznBBIpPbIR4S6F+uZvLU8Yh3b5+OB03r3db4yiUKGmgERUJZjl
	5QqvoYONowSlWjzuWgHueEfBUcjZd7oR+G27KfktRw1qK1l+HtoURbxkBDzlF6h7bI5Azi9+CQSs7
	4k7yCxaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZJsh-0000000397d-1rOz;
	Sun, 19 Jan 2025 01:13:39 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZJsb-00000003971-1OkS
	for linux-nvme@lists.infradead.org;
	Sun, 19 Jan 2025 01:13:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737249213; x=1768785213;
  h=date:from:to:cc:subject:message-id;
  bh=xCOjCchauweAPypEm1MjePe5f+1sEmSjKi6Eo9M9oxM=;
  b=Bfa2SBazwS6703ioR9scPYoAFTDqM/Qo9m/DB2gIFgLZBeGK+d/AXiXd
   K4m/HcpEWxsoa13KqiFpRHQjUcvif6YRPP3LAnsyBCbudQ1lXjdBRBdQs
   0gj5TlGnGgWHlwyaGLCQ4miTPk6+oPH//bBz3YoOWVXNsOlHrK6evHQfE
   2pC3eptNXAJD6Kf8qlLd1qzehDTum1iR367MsXlw8XrPpbh/PH8NWGFDZ
   sZGrFhl/y1ECvQHt+2C18KvlfXr8X7WkR6pM21toGFOWMKTSTjmgoKisQ
   1CZOqAo/hZv2T8VfuqpqBR4abdyQwcBLg6yuZjgsUFyo15BBYAF2TU+BO
   w==;
X-CSE-ConnectionGUID: uPs4ZOciRiieoxBVbbGitA==
X-CSE-MsgGUID: ScgOpXsGS0uR3fTpEuSQQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11319"; a="48237643"
X-IronPort-AV: E=Sophos;i="6.13,216,1732608000"; 
   d="scan'208";a="48237643"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 17:13:26 -0800
X-CSE-ConnectionGUID: WC36N/HxQxuAycBwe8PI/w==
X-CSE-MsgGUID: nyQfQEmJTrGRzDLvUiEq5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106598719"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Jan 2025 17:13:25 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZJsR-000UzH-00;
	Sun, 19 Jan 2025 01:13:23 +0000
Date: Sun, 19 Jan 2025 09:13:06 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.14] BUILD SUCCESS
 11cb3529d18514f7d28ad2190533192aedefd761
Message-ID: <202501190959.7sLZzUuZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250118_171333_415359_DEFF2D93 
X-CRM114-Status: UNSURE (   5.22  )
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
branch HEAD: 11cb3529d18514f7d28ad2190533192aedefd761  nvme-pci: Add TUXEDO IBP Gen9 to Samsung sleep quirk

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arm-randconfig-003-20250118
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- hexagon-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- hexagon-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- i386-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- s390-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- s390-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- sh-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- sh-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- sparc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- um-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- um-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
`-- um-randconfig-002-20250118
    |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
    `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead

elapsed time: 1443m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250118    gcc-13.2.0
arc                   randconfig-002-20250118    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                       aspeed_g4_defconfig    clang-20
arm                           h3600_defconfig    gcc-14.2.0
arm                   randconfig-001-20250118    gcc-14.2.0
arm                   randconfig-002-20250118    clang-20
arm                   randconfig-003-20250118    gcc-14.2.0
arm                   randconfig-004-20250118    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250118    clang-17
arm64                 randconfig-002-20250118    gcc-14.2.0
arm64                 randconfig-003-20250118    clang-20
arm64                 randconfig-004-20250118    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250118    gcc-14.2.0
csky                  randconfig-002-20250118    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250118    clang-20
hexagon               randconfig-002-20250118    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250118    gcc-12
i386        buildonly-randconfig-002-20250118    clang-19
i386        buildonly-randconfig-003-20250118    clang-19
i386        buildonly-randconfig-004-20250118    gcc-11
i386        buildonly-randconfig-005-20250118    clang-19
i386        buildonly-randconfig-006-20250118    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250118    gcc-14.2.0
loongarch             randconfig-002-20250118    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250118    gcc-14.2.0
nios2                 randconfig-002-20250118    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250118    gcc-14.2.0
parisc                randconfig-002-20250118    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250118    clang-15
powerpc               randconfig-002-20250118    clang-20
powerpc               randconfig-003-20250118    clang-20
powerpc64                        alldefconfig    clang-20
powerpc64             randconfig-001-20250118    clang-17
powerpc64             randconfig-002-20250118    clang-19
powerpc64             randconfig-003-20250118    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250118    gcc-14.2.0
riscv                 randconfig-002-20250118    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250118    clang-20
s390                  randconfig-002-20250118    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250118    gcc-14.2.0
sh                    randconfig-002-20250118    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250118    gcc-14.2.0
sparc                 randconfig-002-20250118    gcc-14.2.0
sparc64               randconfig-001-20250118    gcc-14.2.0
sparc64               randconfig-002-20250118    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250118    clang-17
um                    randconfig-002-20250118    clang-15
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250118    clang-19
x86_64      buildonly-randconfig-002-20250118    gcc-12
x86_64      buildonly-randconfig-003-20250118    clang-19
x86_64      buildonly-randconfig-004-20250118    gcc-12
x86_64      buildonly-randconfig-005-20250118    clang-19
x86_64      buildonly-randconfig-006-20250118    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250118    gcc-14.2.0
xtensa                randconfig-002-20250118    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

