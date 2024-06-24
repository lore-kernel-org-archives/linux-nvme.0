Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1C7C2BD05
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O9st62J94fZrDTLrEzix15uZbMCdCAr4LDSqGMQAhaI=; b=H7grf+rL479RXKO5g/IUDlx8mN
	kyAwoAPgTwui4Hb8AvoH1bMkATnwNNE2jCYSWYuqSaiQivhCkNHerAV8oVC7/5LyjJ+FgsyINC97H
	nI6mLSpSllORN7XdYr5SY3KB13CFn06g1ac3PsFey8NAx57FWQS9Oj44Ux1by44Zb5xU6xNBJY27I
	NTU4JDXoipXr3TEmHhdgUAX0zKX/KNPDfCgluIhUqVb3YM6f5UNdYtSR8KHF77YeJGAcc6y8KlZWo
	xo5YUHmuuV196kBdWZ+iZkT57ENMpbvwu9UnEPhmkB1TE0got/gRguxvrBB2RXhvDt157VcrZNqCm
	g6l6DWgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLgd4-0000000GNH5-26Gu;
	Mon, 24 Jun 2024 10:08:54 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLgd1-0000000GNGW-2nSb
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 10:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719223732; x=1750759732;
  h=date:from:to:cc:subject:message-id;
  bh=h/GRI3jjbEuOVp+nN65W5k0YgFd62fSqMuL+V4gXuJo=;
  b=JJ4MWk/M0rSTcLGjm/V3MmjdE5/qDFFolf/fZQ5QhFiJ47ERM8VuioA9
   uazbPh0Za+Z2IdcwtMf6SGrnLGExsNRIHz4QfLu30MWFoImkqG8L7avcj
   bBM0LhjUM9rxPTpbQBAOcy8kBpZpVw/aPAnlsuNGUl/4RrzCv8hcH0rxg
   liVYKdssBJPWVeY5dGDZ+lf/9wBux9V5yln1jKbJjGF8Ra+qhb7H3IWIs
   Seqg0ZTSGUtK5UwnRBA9c4HokCNHLXFJWDAo+49M1wwYr7SaOSWoTK9Dk
   nWu6iHHhtv1yKB/vpA+CAUNKggf3pmhhTsEroYRV13QT11Tg0ctOlKLKz
   g==;
X-CSE-ConnectionGUID: 3gTjjyDhQ8mIVzWvOK00AA==
X-CSE-MsgGUID: pQYEvVRqSLSFr8GEZuqKeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="38695506"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="38695506"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 03:08:51 -0700
X-CSE-ConnectionGUID: +obcowYCSb+5DUKprNfFbw==
X-CSE-MsgGUID: s1TdYJcWQxG0k+Mz+arrIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="47620341"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jun 2024 03:08:50 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLgcx-000Caj-23;
	Mon, 24 Jun 2024 10:08:47 +0000
Date: Mon, 24 Jun 2024 18:07:56 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.10] BUILD SUCCESS
 0f1f5803920d2a6b88bee950914fd37421e17170
Message-ID: <202406241854.1ZjOUCzp-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_030851_777091_908F9A80 
X-CRM114-Status: UNSURE (   4.75  )
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
branch HEAD: 0f1f5803920d2a6b88bee950914fd37421e17170  nvmet: make 'tsas' attribute idempotent for RDMA

elapsed time: 1545m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240623   gcc-13.2.0
arc                   randconfig-002-20240623   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240623   gcc-13.2.0
arm                   randconfig-002-20240623   gcc-13.2.0
arm                   randconfig-003-20240623   gcc-13.2.0
arm                   randconfig-004-20240623   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240623   clang-15
arm64                 randconfig-002-20240623   clang-19
arm64                 randconfig-003-20240623   clang-19
arm64                 randconfig-004-20240623   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240623   gcc-13.2.0
csky                  randconfig-002-20240623   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240623   clang-19
hexagon               randconfig-002-20240623   clang-19
i386         buildonly-randconfig-001-20240623   clang-18
i386         buildonly-randconfig-002-20240623   clang-18
i386         buildonly-randconfig-003-20240623   clang-18
i386         buildonly-randconfig-004-20240623   gcc-13
i386         buildonly-randconfig-005-20240623   clang-18
i386         buildonly-randconfig-006-20240623   clang-18
i386                  randconfig-001-20240623   gcc-9
i386                  randconfig-002-20240623   clang-18
i386                  randconfig-003-20240623   gcc-13
i386                  randconfig-004-20240623   clang-18
i386                  randconfig-005-20240623   gcc-7
i386                  randconfig-006-20240623   clang-18
i386                  randconfig-011-20240623   clang-18
i386                  randconfig-012-20240623   gcc-8
i386                  randconfig-013-20240623   clang-18
i386                  randconfig-014-20240623   clang-18
i386                  randconfig-015-20240623   gcc-8
i386                  randconfig-016-20240623   clang-18
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240623   gcc-13.2.0
loongarch             randconfig-002-20240623   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240623   gcc-13.2.0
nios2                 randconfig-002-20240623   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240623   gcc-13.2.0
parisc                randconfig-002-20240623   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240623   gcc-13.2.0
powerpc               randconfig-002-20240623   clang-15
powerpc               randconfig-003-20240623   clang-19
powerpc64             randconfig-001-20240623   gcc-13.2.0
powerpc64             randconfig-002-20240623   clang-19
powerpc64             randconfig-003-20240623   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240623   clang-19
riscv                 randconfig-002-20240623   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240623   gcc-13.2.0
s390                  randconfig-002-20240623   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240623   gcc-13.2.0
sh                    randconfig-002-20240623   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240623   gcc-13.2.0
sparc64               randconfig-002-20240623   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240623   gcc-7
um                    randconfig-002-20240623   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240623   clang-18
x86_64       buildonly-randconfig-002-20240623   clang-18
x86_64       buildonly-randconfig-003-20240623   clang-18
x86_64       buildonly-randconfig-004-20240623   clang-18
x86_64       buildonly-randconfig-005-20240623   clang-18
x86_64       buildonly-randconfig-006-20240623   clang-18
x86_64                randconfig-001-20240623   gcc-13
x86_64                randconfig-002-20240623   gcc-13
x86_64                randconfig-003-20240623   clang-18
x86_64                randconfig-004-20240623   gcc-13
x86_64                randconfig-005-20240623   gcc-8
x86_64                randconfig-006-20240623   clang-18
x86_64                randconfig-011-20240623   clang-18
x86_64                randconfig-012-20240623   gcc-13
x86_64                randconfig-013-20240623   clang-18
x86_64                randconfig-014-20240623   clang-18
x86_64                randconfig-015-20240623   gcc-13
x86_64                randconfig-016-20240623   clang-18
x86_64                randconfig-071-20240623   gcc-13
x86_64                randconfig-072-20240623   gcc-13
x86_64                randconfig-073-20240623   clang-18
x86_64                randconfig-074-20240623   clang-18
x86_64                randconfig-075-20240623   gcc-13
x86_64                randconfig-076-20240623   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240623   gcc-13.2.0
xtensa                randconfig-002-20240623   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

