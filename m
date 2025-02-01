Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB4EC02190
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Feb 2025 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ocxDqX98AMbFQdhxfGYzc2BF89djJlIWCVxIt/TO1jM=; b=bSvGaAk3/QPyA3F2g5ihOdx0iD
	B/RNDVFQ3ldGoZjA6xuXEAzXb0wPoPV0WjIx5H23YamArYDTh2JVHbK6djAsh/BmoDlDqNlau0CG5
	vXBG0vEaaLYUXIDQGgWCat/iz7JfIHlOhOPPeVJJTwFeagatbKpAPqWNS+LUILNoElLccfBHoW5Bh
	DEm3ueZRIY7WkMq/w1NNijb5L0qnG2BPt+nS8bEF14POjn/AeYZXSECpoWrvhRHEUNfneHgCum356
	rbG/57dLM+m8rsr2B0sr232GeuITkEi34Q63Uf1cwjB4jx1Sp/RJT2gS3MQH0NXRAOiktzwKGoHoJ
	Rz6nEnQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1teBhL-0000000CE7a-12l5;
	Sat, 01 Feb 2025 11:30:03 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1teBhI-0000000CE6u-30QS
	for linux-nvme@lists.infradead.org;
	Sat, 01 Feb 2025 11:30:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738409400; x=1769945400;
  h=date:from:to:cc:subject:message-id;
  bh=C8vkaP/jKAcZOBj3OS5HTDSiglH7BwHcJ69fxjimRmQ=;
  b=MLMoLIkPVb3HiwN0koSVFR8wyXaM5HDIfTixyg3xO+zzEma+b3zu+RAh
   Xaasu/VfuvTFLIGWmXS1875nxMISqLq+N/b3AZGG/1a2GZPljQAe5yWfk
   oUGtVJbED4enS738eXqf9HljEdaWyLNSoWFIwrWCzqRqcWPC1tq7YdBVr
   vvqG7/wVPutRhhAVOABjps4U9sVahO+T88bHQYz196zopljfpIuykITFC
   xzoJOb2SGeFnBOHYdvKAWHNdY1UbDGlQDz4fA0ADBthpjWyMdiOl2BjqU
   NJfmxBaWXqyu7Pb7gH5kuifVfahZ+nB1Sw82P9UoY3aVVwIvxpmY0vVIO
   w==;
X-CSE-ConnectionGUID: 1KzoURhaSga8qDikP4MYug==
X-CSE-MsgGUID: hWIjiOYvTeq1UVLgVgumRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="61437281"
X-IronPort-AV: E=Sophos;i="6.13,251,1732608000"; 
   d="scan'208";a="61437281"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 03:29:59 -0800
X-CSE-ConnectionGUID: N+4gxF1PQ3+93gnTdnHIug==
X-CSE-MsgGUID: a35w19wDTFGkQR61kR1irQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133107529"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 Feb 2025 03:29:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1teBhE-000o61-0g;
	Sat, 01 Feb 2025 11:29:56 +0000
Date: Sat, 01 Feb 2025 19:28:59 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.14] BUILD SUCCESS
 c8ed6cb5d37bc09c7e25e49a670e9fd1a3bd1dfa
Message-ID: <202502011951.mlvfk6Mw-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250201_033000_880468_C2FC320D 
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.14
branch HEAD: c8ed6cb5d37bc09c7e25e49a670e9fd1a3bd1dfa  nvme-fc: use ctrl state getter

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arm-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arm-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arm-randconfig-004-20250201
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- arm64-allmodconfig
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
|-- i386-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- i386-buildonly-randconfig-004-20250201
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- loongarch-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- m68k-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- m68k-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- microblaze-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- microblaze-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- openrisc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- parisc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc-allyesconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- powerpc64-randconfig-001-20250201
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- riscv-allmodconfig
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
|-- riscv-allyesconfig
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
|-- um-randconfig-002-20250201
|   |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
|   `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead
`-- x86_64-allyesconfig
    |-- drivers-nvme-host-tcp.c:warning:Function-parameter-or-struct-member-queue-not-described-in-nvme_tcp_set_queue_io_cpu
    `-- drivers-nvme-host-tcp.c:warning:expecting-prototype-for-Track-the-number-of-queues-assigned-to-each-cpu-using-a-global-per().-Prototype-was-for-nvme_tcp_set_queue_io_cpu()-instead

elapsed time: 964m

configs tested: 203
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    clang-21
arc                   randconfig-001-20250201    gcc-13.2.0
arc                   randconfig-002-20250201    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-21
arm                           h3600_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-21
arm                          moxart_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250201    gcc-14.2.0
arm                   randconfig-002-20250201    clang-18
arm                   randconfig-003-20250201    gcc-14.2.0
arm                   randconfig-004-20250201    gcc-14.2.0
arm                           sama7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250201    gcc-14.2.0
arm64                 randconfig-002-20250201    clang-16
arm64                 randconfig-003-20250201    gcc-14.2.0
arm64                 randconfig-004-20250201    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250201    gcc-14.2.0
csky                  randconfig-002-20250201    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250201    clang-21
hexagon               randconfig-001-20250201    gcc-14.2.0
hexagon               randconfig-002-20250201    clang-21
hexagon               randconfig-002-20250201    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250201    clang-19
i386        buildonly-randconfig-002-20250201    gcc-12
i386        buildonly-randconfig-003-20250201    gcc-12
i386        buildonly-randconfig-004-20250201    gcc-12
i386        buildonly-randconfig-005-20250201    gcc-12
i386        buildonly-randconfig-006-20250201    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250201    clang-19
i386                  randconfig-002-20250201    clang-19
i386                  randconfig-003-20250201    clang-19
i386                  randconfig-004-20250201    clang-19
i386                  randconfig-005-20250201    clang-19
i386                  randconfig-006-20250201    clang-19
i386                  randconfig-007-20250201    clang-19
i386                  randconfig-011-20250201    clang-19
i386                  randconfig-012-20250201    clang-19
i386                  randconfig-013-20250201    clang-19
i386                  randconfig-014-20250201    clang-19
i386                  randconfig-015-20250201    clang-19
i386                  randconfig-016-20250201    clang-19
i386                  randconfig-017-20250201    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250201    gcc-14.2.0
loongarch             randconfig-002-20250201    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-21
mips                     loongson1b_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250201    gcc-14.2.0
nios2                 randconfig-002-20250201    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250201    gcc-14.2.0
parisc                randconfig-002-20250201    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      bamboo_defconfig    clang-21
powerpc                   currituck_defconfig    clang-21
powerpc                       holly_defconfig    clang-21
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250201    clang-21
powerpc               randconfig-001-20250201    gcc-14.2.0
powerpc               randconfig-002-20250201    clang-18
powerpc               randconfig-002-20250201    gcc-14.2.0
powerpc               randconfig-003-20250201    gcc-14.2.0
powerpc                     sequoia_defconfig    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250201    gcc-14.2.0
powerpc64             randconfig-002-20250201    gcc-14.2.0
powerpc64             randconfig-003-20250201    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250201    clang-21
riscv                 randconfig-001-20250201    gcc-14.2.0
riscv                 randconfig-002-20250201    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250201    gcc-14.2.0
s390                  randconfig-002-20250201    clang-21
s390                  randconfig-002-20250201    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250201    gcc-14.2.0
sh                    randconfig-002-20250201    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250201    gcc-14.2.0
sparc                 randconfig-002-20250201    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250201    gcc-14.2.0
sparc64               randconfig-002-20250201    gcc-14.2.0
um                               alldefconfig    clang-21
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250201    clang-18
um                    randconfig-001-20250201    gcc-14.2.0
um                    randconfig-002-20250201    clang-21
um                    randconfig-002-20250201    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250201    clang-19
x86_64      buildonly-randconfig-002-20250201    gcc-12
x86_64      buildonly-randconfig-003-20250201    gcc-12
x86_64      buildonly-randconfig-004-20250201    gcc-12
x86_64      buildonly-randconfig-005-20250201    clang-19
x86_64      buildonly-randconfig-006-20250201    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250201    clang-19
x86_64                randconfig-002-20250201    clang-19
x86_64                randconfig-003-20250201    clang-19
x86_64                randconfig-004-20250201    clang-19
x86_64                randconfig-005-20250201    clang-19
x86_64                randconfig-006-20250201    clang-19
x86_64                randconfig-007-20250201    clang-19
x86_64                randconfig-008-20250201    clang-19
x86_64                randconfig-071-20250201    clang-19
x86_64                randconfig-072-20250201    clang-19
x86_64                randconfig-073-20250201    clang-19
x86_64                randconfig-074-20250201    clang-19
x86_64                randconfig-075-20250201    clang-19
x86_64                randconfig-076-20250201    clang-19
x86_64                randconfig-077-20250201    clang-19
x86_64                randconfig-078-20250201    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250201    gcc-14.2.0
xtensa                randconfig-002-20250201    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

