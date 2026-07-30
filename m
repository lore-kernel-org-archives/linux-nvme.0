Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CD2C55165
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PD0g4EyW2TDCCCZyfOObpYYEJdDQ6kb/H8F3FK9Sq84=; b=MAGVDthTUIbN2jG2wUIq8nN6l6
	6+v1nRf8MC3Nf7bzqYP0SOh1FngXvxtAIrgTjjRKc6whXQgCbpE8trFXs86CC/dZ6U1OrdRkRlU2d
	1OawYP24kUUB6jB21YicVbW3KXudVOXoqmz8iNaXYydoPr5SUEhHa2V7lIXMkYIDLYJ6rj5h4geoT
	CR7v6LC4jmR2WohFdENFdB/fXF9F/IfZpegXXIqC2zxksjmCe/KBC4Jz08Nt9MQdJnqhrBE2FB00r
	vFoKQ/rODFgahqIhjl7xih2uUUd8cLG8cHGEvRnwJKDjLBlT9ZmV5EmY5yrpvKa1KaLeCsxHfLSUd
	skS1gZ2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQ9r-0000000AV8v-2AJF;
	Thu, 30 Jul 2026 12:46:43 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQ9n-0000000AV8J-19o9
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 12:46:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785415600; x=1816951600;
  h=date:from:to:cc:subject:message-id;
  bh=m2+p3NveMIyc4WspiHRB/fqyf7kGRKS+4eWa6Ao55Vo=;
  b=a2Hj724KgiA0Uuql9+WXCHBwGXMmjkxWzSnRbt7He346AsQa0G/5SO2q
   JCEwCAtcGrY5Q2JfzrKiPnTcAhXX1ziJyrpQhyUQtKVv5fJMUd8yMKpMx
   Vax9keS4VssDRbFHaX9MMKSCQUhV0h9cIelsg1bsATCaIROg778Q8gbrX
   AP0r8F+zP1gjYKadgCIqoWJJeZyHF2GDOe2SDU5m+1nvacbsgFW/GKr82
   uhXwS2oOpW/JfTFEZMZb0VOzbDWba2+FkxjGsolc+Vqwspa/sRRb0wWo0
   L0qStqlPs4lGDdZBz1oNoQcJtxLKzF46eUIRomQ3VfSK6fiGc5ldDhq4n
   A==;
X-CSE-ConnectionGUID: mxElho4ET8aX9zA9MA44Ng==
X-CSE-MsgGUID: qwvDPJjBTW6ihM6GZ2/1Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103438950"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="103438950"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 05:46:39 -0700
X-CSE-ConnectionGUID: eWuDYdt0Qtaxrgwx7rS6fQ==
X-CSE-MsgGUID: /cFcrQTXTVaHw/6wAElO0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="262237247"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jul 2026 05:46:37 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpQ9c-00000000gYw-3HFQ;
	Thu, 30 Jul 2026 12:46:30 +0000
Date: Thu, 30 Jul 2026 20:45:41 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS WITH UNVERIFIED WARNING
 bf881dd20062db5e951a0d0703cb476df8c9fdee
Message-ID: <202607302022.QKzgPdYi-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_054640_665604_FAB8BE88 
X-CRM114-Status: UNSURE (   4.08  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.3
branch HEAD: bf881dd20062db5e951a0d0703cb476df8c9fdee  nvmet: reject out-of-range mdts values in configfs store

Unverified Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202607291634.E5clnaLh-lkp@intel.com

    drivers/nvme/host/multipath.c:249:38: warning: reading variable 'current_path' requires holding __ctx_lock_RCU 'RCU' [-Wthread-safety-analysis]

Warning ids grouped by kconfigs:

recent_errors
`-- loongarch-defconfig
    `-- drivers-nvme-host-multipath.c:warning:reading-variable-current_path-requires-holding-__ctx_lock_RCU-RCU

elapsed time: 844m

configs tested: 136
configs skipped: 1

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260730    gcc-8.5.0
arc                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-001-20260730    gcc-8.5.0
arm                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-003-20260730    gcc-8.5.0
arm                  randconfig-004-20260730    gcc-8.5.0
arm                          stm32_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260730    gcc-15.2.0
arm64                randconfig-002-20260730    clang-21
arm64                randconfig-002-20260730    gcc-15.2.0
arm64                randconfig-003-20260730    gcc-15.2.0
arm64                randconfig-003-20260730    gcc-8.5.0
arm64                randconfig-004-20260730    gcc-13.4.0
arm64                randconfig-004-20260730    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260730    gcc-13.4.0
csky                 randconfig-001-20260730    gcc-15.2.0
csky                 randconfig-002-20260730    gcc-15.2.0
csky                 randconfig-002-20260730    gcc-16.1.0
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260730    gcc-14
i386       buildonly-randconfig-002-20260730    gcc-14
i386       buildonly-randconfig-003-20260730    gcc-14
i386       buildonly-randconfig-004-20260730    gcc-14
i386       buildonly-randconfig-005-20260730    gcc-14
i386       buildonly-randconfig-006-20260730    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260730    gcc-14
i386                 randconfig-002-20260730    clang-22
i386                 randconfig-002-20260730    gcc-14
i386                 randconfig-003-20260730    gcc-14
i386                 randconfig-004-20260730    clang-22
i386                 randconfig-004-20260730    gcc-14
i386                 randconfig-005-20260730    clang-22
i386                 randconfig-005-20260730    gcc-14
i386                 randconfig-006-20260730    gcc-14
i386                 randconfig-007-20260730    gcc-14
i386                 randconfig-011-20260730    clang-22
i386                 randconfig-012-20260730    clang-22
i386                 randconfig-013-20260730    clang-22
i386                 randconfig-014-20260730    clang-22
i386                 randconfig-014-20260730    gcc-14
i386                 randconfig-015-20260730    clang-22
i386                 randconfig-016-20260730    clang-22
i386                 randconfig-016-20260730    gcc-13
i386                 randconfig-017-20260730    clang-22
i386                 randconfig-017-20260730    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260730    clang-24
loongarch            randconfig-002-20260730    clang-24
m68k                      m5249evb_defconfig    gcc-16.1.0
mips                         ath25_defconfig    clang-24
mips                decstation_r4k_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260730    clang-24
nios2                randconfig-002-20260730    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260730    gcc-14.3.0
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260730    gcc-14.3.0
riscv                         randconfig-001    gcc-15.2.0
riscv                randconfig-001-20260730    gcc-15.2.0
riscv                randconfig-002-20260730    gcc-15.2.0
s390                 randconfig-001-20260730    gcc-15.2.0
s390                 randconfig-002-20260730    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260730    gcc-15.2.0
sh                   randconfig-002-20260730    gcc-15.2.0
sh                          se7705_defconfig    gcc-16.1.0
sparc                         randconfig-001    clang-24
sparc                randconfig-001-20260730    clang-24
sparc                randconfig-001-20260730    gcc-16.1.0
sparc                randconfig-002-20260730    clang-24
sparc                randconfig-002-20260730    gcc-16.1.0
sparc64              randconfig-001-20260730    clang-20
sparc64              randconfig-001-20260730    clang-24
sparc64              randconfig-002-20260730    clang-24
sparc64              randconfig-002-20260730    gcc-14.3.0
um                   randconfig-001-20260730    clang-17
um                   randconfig-001-20260730    clang-24
um                   randconfig-002-20260730    clang-24
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260730    gcc-14
x86_64     buildonly-randconfig-002-20260730    gcc-14
x86_64     buildonly-randconfig-003-20260730    gcc-14
x86_64     buildonly-randconfig-004-20260730    gcc-14
x86_64     buildonly-randconfig-005-20260730    gcc-14
x86_64     buildonly-randconfig-006-20260730    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260730    clang-22
x86_64               randconfig-002-20260730    clang-22
x86_64               randconfig-002-20260730    gcc-14
x86_64               randconfig-003-20260730    clang-22
x86_64               randconfig-004-20260730    clang-22
x86_64               randconfig-004-20260730    gcc-14
x86_64               randconfig-005-20260730    clang-22
x86_64               randconfig-006-20260730    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260730    clang-22
x86_64               randconfig-012-20260730    clang-22
x86_64               randconfig-013-20260730    clang-22
x86_64               randconfig-014-20260730    clang-22
x86_64               randconfig-015-20260730    clang-22
x86_64               randconfig-016-20260730    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260730    gcc-12
x86_64               randconfig-071-20260730    gcc-14
x86_64               randconfig-072-20260730    gcc-12
x86_64               randconfig-073-20260730    clang-22
x86_64               randconfig-073-20260730    gcc-12
x86_64               randconfig-074-20260730    gcc-12
x86_64               randconfig-075-20260730    clang-22
x86_64               randconfig-075-20260730    gcc-12
x86_64               randconfig-076-20260730    clang-22
x86_64               randconfig-076-20260730    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260730    clang-24
xtensa               randconfig-001-20260730    gcc-16.1.0
xtensa               randconfig-002-20260730    clang-24
xtensa               randconfig-002-20260730    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

