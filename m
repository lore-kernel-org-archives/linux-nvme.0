Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27889C2BD09
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jun 2024 22:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VGdxo2oSoGRRhJNbxMDmh8F+lCrJk3O5SHPnSvVbxe8=; b=kjJnMoF25T3w4eoSJv8pn2mkTj
	8xckx158airXn7h3dPnqk92U+tZ8PPwtWDqfINNvaERAQCdmMV7HHwHBMBUcYEK4W8hFYwruMMHca
	ZRDFHpWgLFPP1Jvz3rt4SvtbrneiHl2LmERdrogYe42FChIWUq8c+IE0Aiy/FrBI+e7uZkMGZ9Suc
	nroxEedexwxbiQdGUgv2hCr5zIVSU0bcXIvffudubClah9CKO17mCHSoQOa+O3jBppXrL2qDmR5Wj
	U4ZCunzH8jLHihCT/JGBnmDd9YbnvgUnA5ABm+Z0V2YZJt4SV7RiZVXBuzUF1i2N2ue8S7d3gC32o
	n16eB6fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNKNX-0000000FDQ4-3wwW;
	Fri, 28 Jun 2024 22:47:39 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNKNV-0000000FDPg-0anJ
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jun 2024 22:47:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719614857; x=1751150857;
  h=date:from:to:cc:subject:message-id;
  bh=ZAR0COZwZoNHLOiqPAOC93hMSMJ2GcPADYi+Cr7G65Q=;
  b=mHnbskY79PpVFqEQZn03BtkfhYiirRNfHO0AONZataU9WK8hZB9mWGz2
   BoizRGqH4Rej3tW0EpcJyVQXLQ1VX4KME3fjtms7xYISZI44Pl3yrjuRK
   YonrYnlVBXdiVPXVEFESywpfguQP2IkSyjpj4GiJFiGGodPZ1SJWhkV7t
   04/vUu2Hsx338bCw9kB0XAUYIF8TA1hKw/p9oG2UAQkkgSnyGOqFb7dwO
   VzBzqThnbVN3tbSLhkuZTlAH6C1IWVgJGEjS2QsAShdROxjdA3I+2RxNG
   EvWwJxWfXd2YXxLz17DdEX3iql2b1eX3HSUZ4MXbrs2V3tF+tWTR7Fdvf
   g==;
X-CSE-ConnectionGUID: 6aGi4BWoTmSQfzlHiIU/Wg==
X-CSE-MsgGUID: nItHTtuhR+mfm3MB1jjtsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16691971"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16691971"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 15:47:34 -0700
X-CSE-ConnectionGUID: +oJeC/N8Sr6e9A5UhpH+AQ==
X-CSE-MsgGUID: QKOWzd/xRwmMHBEZTQxG8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49345193"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jun 2024 15:47:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNKNO-000Icp-2t;
	Fri, 28 Jun 2024 22:47:30 +0000
Date: Sat, 29 Jun 2024 06:47:24 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.10] BUILD SUCCESS
 440e2051c577896275c0e0513ec26964e04c7810
Message-ID: <202406290622.qqA1sNWo-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240628_154737_243709_0BAD66B2 
X-CRM114-Status: UNSURE (   5.40  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.10
branch HEAD: 440e2051c577896275c0e0513ec26964e04c7810  nvmet-fc: Remove __counted_by from nvmet_fc_tgt_queue.fod[]

elapsed time: 3167m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   clang-19
arm                   randconfig-004-20240628   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   clang-19
arm64                 randconfig-003-20240628   gcc-13.2.0
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240628   clang-19
hexagon               randconfig-002-20240628   clang-19
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   clang-19
powerpc64             randconfig-003-20240628   gcc-13.2.0
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                  randconfig-001-20240628   clang-19
s390                  randconfig-001-20240628   gcc-13.2.0
s390                  randconfig-002-20240628   clang-19
s390                  randconfig-002-20240628   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                    randconfig-001-20240628   gcc-13
um                    randconfig-001-20240628   gcc-13.2.0
um                    randconfig-002-20240628   clang-19
um                    randconfig-002-20240628   gcc-13.2.0
x86_64       buildonly-randconfig-001-20240628   gcc-13
x86_64       buildonly-randconfig-002-20240628   clang-18
x86_64       buildonly-randconfig-003-20240628   gcc-13
x86_64       buildonly-randconfig-004-20240628   gcc-13
x86_64       buildonly-randconfig-005-20240628   gcc-13
x86_64       buildonly-randconfig-006-20240628   clang-18
x86_64                randconfig-001-20240628   clang-18
x86_64                randconfig-002-20240628   clang-18
x86_64                randconfig-003-20240628   gcc-11
x86_64                randconfig-004-20240628   gcc-7
x86_64                randconfig-005-20240628   clang-18
x86_64                randconfig-006-20240628   clang-18
x86_64                randconfig-011-20240628   clang-18
x86_64                randconfig-012-20240628   gcc-10
x86_64                randconfig-013-20240628   gcc-13
x86_64                randconfig-014-20240628   clang-18
x86_64                randconfig-015-20240628   clang-18
x86_64                randconfig-016-20240628   gcc-12
x86_64                randconfig-071-20240628   clang-18
x86_64                randconfig-072-20240628   gcc-13
x86_64                randconfig-073-20240628   clang-18
x86_64                randconfig-074-20240628   gcc-13
x86_64                randconfig-075-20240628   gcc-13
x86_64                randconfig-076-20240628   gcc-13
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

