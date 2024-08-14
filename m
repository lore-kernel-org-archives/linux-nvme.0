Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4168FC3DA4A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Aug 2024 21:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4kwvK3Y1XhBA0+IFiaNcff4GO8/UdTwC6AiCQL1fe1E=; b=lCJlaVVNCiDDGKNaJg8erF2yFV
	+WxRQNNTgxHxoaoqe62eUhZXeA5N6iko2xytqdrNATwZ7XpJJondRha/GOYPCaEX8vgEE92zWd2t0
	IiPVRpmyBz32LalPqnaLGnaLGtNy6SDTjTSSm9cuCx4XNoKPNNgkbi07cmurRSniR9cxi38a6aEkP
	O8n6cuwcQhQTvRnguSL9kMCzegpFTwkpV6TD8n3OoJFg5lB/N4GiOmiz7oQsN4HkmKSjAkli3nteQ
	/oZyZ3NK6CrZEnH01ECVNRqNQPlqdy48Ayo/ZqPNnIAXJza9bAjK6OHA+9N1iFq2dZ9NRY8K/RLE4
	DbDPqTig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seL7r-00000008HPx-2eTC;
	Wed, 14 Aug 2024 21:01:47 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seL7m-00000008HOc-2wng
	for linux-nvme@lists.infradead.org;
	Wed, 14 Aug 2024 21:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723669303; x=1755205303;
  h=date:from:to:cc:subject:message-id;
  bh=G6qdto+TJhiWnfF7EYSqV95B3Z1uxgMYYQyVlEg9idU=;
  b=MFXfLqyrbUxQ/b/B+/AScmbFDRFu7YBEfho2Ea9cJu/NBaZzD++1z0jS
   g4knhCfETWm7VKOolWYb95Bj8tWiFymLH4caEvgrc2MUe2bUgBMsuFOoc
   gDLE2BeIml14iqup0DfHRJSUlMfbjnHwvLfRUq/OkpuHVRQGIbmp83ThZ
   pHgULMkxieRunJADQ1Ey4nzEvXOnFpuCTJo0Kp9V9lKhJtRsXwTl+pgiR
   xsc7mGb+Rachx91x4NrJG7FiIkYfsxQ6hqAFW16j3N0/wfnJ0wANWwNL7
   LBsjU4gSDGC6BgmwVsuDGL0vj2r6UfVjvY08OQ9Jb8G0mMCKMRUEKeyIp
   g==;
X-CSE-ConnectionGUID: RfMqg+myQOWxb7BGYvat8g==
X-CSE-MsgGUID: 95qJhTLCTcKDh7cdpcZvEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32542436"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="32542436"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 14:01:41 -0700
X-CSE-ConnectionGUID: aMvoP3/lSBuVUsfp561BWA==
X-CSE-MsgGUID: 2NSjsEh2THSMo01cvGoNhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="63567498"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Aug 2024 14:01:40 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seL7i-0002sg-0u;
	Wed, 14 Aug 2024 21:01:38 +0000
Date: Thu, 15 Aug 2024 05:01:03 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.11] BUILD SUCCESS
 e219e08d3a1f14dd34d6a9903de744173faadd53
Message-ID: <202408150501.850Mnh1k-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240814_140142_826279_3D67422F 
X-CRM114-Status: UNSURE (   4.71  )
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
branch HEAD: e219e08d3a1f14dd34d6a9903de744173faadd53  nvme: move stopping keep-alive into nvme_uninit_ctrl()

elapsed time: 1198m

configs tested: 217
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240814   gcc-13.2.0
arc                   randconfig-002-20240814   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-12.4.0
arm                            hisi_defconfig   gcc-12.4.0
arm                          moxart_defconfig   gcc-12.4.0
arm                         mv78xx0_defconfig   gcc-12.4.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240814   gcc-13.2.0
arm                   randconfig-002-20240814   gcc-13.2.0
arm                   randconfig-003-20240814   gcc-13.2.0
arm                   randconfig-004-20240814   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-12.4.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240814   gcc-13.2.0
arm64                 randconfig-002-20240814   gcc-13.2.0
arm64                 randconfig-003-20240814   gcc-13.2.0
arm64                 randconfig-004-20240814   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240814   gcc-13.2.0
csky                  randconfig-002-20240814   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             alldefconfig   gcc-12.4.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240814   clang-18
i386         buildonly-randconfig-002-20240814   clang-18
i386         buildonly-randconfig-003-20240814   clang-18
i386         buildonly-randconfig-004-20240814   clang-18
i386         buildonly-randconfig-005-20240814   clang-18
i386         buildonly-randconfig-005-20240814   gcc-12
i386         buildonly-randconfig-006-20240814   clang-18
i386         buildonly-randconfig-006-20240814   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240814   clang-18
i386                  randconfig-002-20240814   clang-18
i386                  randconfig-002-20240814   gcc-12
i386                  randconfig-003-20240814   clang-18
i386                  randconfig-003-20240814   gcc-12
i386                  randconfig-004-20240814   clang-18
i386                  randconfig-005-20240814   clang-18
i386                  randconfig-006-20240814   clang-18
i386                  randconfig-011-20240814   clang-18
i386                  randconfig-011-20240814   gcc-12
i386                  randconfig-012-20240814   clang-18
i386                  randconfig-012-20240814   gcc-12
i386                  randconfig-013-20240814   clang-18
i386                  randconfig-014-20240814   clang-18
i386                  randconfig-014-20240814   gcc-11
i386                  randconfig-015-20240814   clang-18
i386                  randconfig-015-20240814   gcc-12
i386                  randconfig-016-20240814   clang-18
i386                  randconfig-016-20240814   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240814   gcc-13.2.0
loongarch             randconfig-002-20240814   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-12.4.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-12.4.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240814   gcc-13.2.0
nios2                 randconfig-002-20240814   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                  or1klitex_defconfig   gcc-12.4.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240814   gcc-13.2.0
parisc                randconfig-002-20240814   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      katmai_defconfig   gcc-12.4.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   gcc-12.4.0
powerpc               randconfig-002-20240814   gcc-13.2.0
powerpc               randconfig-003-20240814   gcc-13.2.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240814   gcc-13.2.0
powerpc64             randconfig-002-20240814   gcc-13.2.0
powerpc64             randconfig-003-20240814   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240814   gcc-13.2.0
riscv                 randconfig-002-20240814   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-13.2.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240814   gcc-13.2.0
s390                  randconfig-002-20240814   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-12.4.0
sh                          polaris_defconfig   gcc-12.4.0
sh                    randconfig-001-20240814   gcc-13.2.0
sh                    randconfig-002-20240814   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-12.4.0
sh                          sdk7780_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-12.4.0
sh                     sh7710voipgw_defconfig   gcc-12.4.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-12.4.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240814   gcc-13.2.0
sparc64               randconfig-002-20240814   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240814   gcc-13.2.0
um                    randconfig-002-20240814   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240814   clang-18
x86_64       buildonly-randconfig-002-20240814   clang-18
x86_64       buildonly-randconfig-003-20240814   clang-18
x86_64       buildonly-randconfig-004-20240814   clang-18
x86_64       buildonly-randconfig-005-20240814   clang-18
x86_64       buildonly-randconfig-006-20240814   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240814   clang-18
x86_64                randconfig-002-20240814   clang-18
x86_64                randconfig-003-20240814   clang-18
x86_64                randconfig-004-20240814   clang-18
x86_64                randconfig-005-20240814   clang-18
x86_64                randconfig-006-20240814   clang-18
x86_64                randconfig-011-20240814   clang-18
x86_64                randconfig-012-20240814   clang-18
x86_64                randconfig-013-20240814   clang-18
x86_64                randconfig-014-20240814   clang-18
x86_64                randconfig-015-20240814   clang-18
x86_64                randconfig-016-20240814   clang-18
x86_64                randconfig-071-20240814   clang-18
x86_64                randconfig-072-20240814   clang-18
x86_64                randconfig-073-20240814   clang-18
x86_64                randconfig-074-20240814   clang-18
x86_64                randconfig-075-20240814   clang-18
x86_64                randconfig-076-20240814   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240814   gcc-13.2.0
xtensa                randconfig-002-20240814   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

