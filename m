Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15DEC54EBD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 07:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0UM3PR+j4GyX3I6PziCwngbz4v0056vMl1tt5jzIwzM=; b=1gqoavOcjyoSxV/tJoA65jkXLv
	OLZYfLi89MxhhFnKgVc9+6DaWXBpO7eQCLuUwniDh3AIzYDUGSuy9bcrYgGEQbtpZb0A8aVrKdNwi
	8xYMKaCG7x/xW68ve4KdbEMnbDx6fID6mWoY4MV/ISUN/JdlT5DdzKMXn73iLv4DdsEUBAvk91huV
	5vJIa6nyQgerBQkCzn2kMtOlWBP0JtuWQmNtme+bszBvj6XdNGtahoSBVFu4zINltGd7nqhjHIlC+
	5u9SWoaDPNXF3v3Abp1gVSyGEEWv3nKeGIWZe78XDnQLacGyciS0LcelkAMnXOGCb9BsRCCWwJPaH
	gthny8fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmEz-0006jJ-51; Mon, 09 Jan 2023 07:06:41 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmEu-0006hY-Kh
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 07:06:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673247996; x=1704783996;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GBebITw3WhnBUpkeUJ2fYcc/1ka4DlGCyQ36jPaSpIE=;
  b=ZTdqJrrqZHpEWKhXL7sYiM2NdofezlOhBFIfHPeSyp5s23fMw8+nQ/kf
   ZgoHl1VZ1VPUamgI+ClhTnbuRelEyFEBJr1dtbrCg0HyluHQusSjY1qe6
   QsUmKkCUfC99r0a7w1TlGSKggjfspTbZ/jB5qY/7eqLgBYSTk8iDj1Nwo
   PU02aCAQPpx/gytDkeJ0MjBWs8SIfWwwoI6A0VsviYVl8uQgwkPFsekFS
   HIEhuY7VOEVzP4oAeM5RzLSus43V5nYFgrBljasQ7+VUsLHHTPA/6qbkB
   1b6ee0OKKhkLk7LK4svacDgldi27gs3qiib+tFkz52PcPsAh4BZRYp7rs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="322883106"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="322883106"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 23:06:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="780595621"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="780595621"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2023 23:06:16 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pEmEa-0006QQ-0O;
	Mon, 09 Jan 2023 07:06:16 +0000
Date: Mon, 09 Jan 2023 15:05:23 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 749a2766ebda2749ff6759bedac1f103d5e3680c
Message-ID: <63bbbcb3.Px5zUIUCHlZbQDzl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_230637_110590_787346AA 
X-CRM114-Status: UNSURE (   6.58  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.2
branch HEAD: 749a2766ebda2749ff6759bedac1f103d5e3680c  nvme-pci: fix error handling in nvme_pci_enable()

elapsed time: 724m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                               rhel-8.3
arm                                 defconfig
arc                                 defconfig
m68k                             allyesconfig
x86_64                        randconfig-a006
m68k                             allmodconfig
i386                 randconfig-a011-20230109
s390                             allmodconfig
arc                              allyesconfig
x86_64               randconfig-a011-20230109
x86_64                           allyesconfig
x86_64               randconfig-a013-20230109
x86_64               randconfig-a012-20230109
alpha                            allyesconfig
alpha                               defconfig
x86_64                           rhel-8.3-bpf
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
mips                             allyesconfig
ia64                             allmodconfig
i386                 randconfig-a016-20230109
x86_64               randconfig-a014-20230109
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a015-20230109
s390                                defconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20230109
i386                 randconfig-a013-20230109
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a015-20230109
i386                 randconfig-a012-20230109
i386                 randconfig-a014-20230109
riscv                randconfig-r042-20230109
s390                 randconfig-r044-20230109
arm                              allyesconfig
arm                  randconfig-r046-20230108
i386                             allyesconfig
arm64                            allyesconfig
arc                  randconfig-r043-20230108
arc                  randconfig-r043-20230109
powerpc                      makalu_defconfig
powerpc                      mgcoge_defconfig
arm64                            alldefconfig
mips                         cobalt_defconfig
mips                  maltasmvp_eva_defconfig
m68k                           sun3_defconfig
sparc64                          alldefconfig
powerpc                 mpc837x_rdb_defconfig
arm                        oxnas_v6_defconfig
arm                        multi_v7_defconfig
openrisc                       virt_defconfig
xtensa                generic_kc705_defconfig
i386                          randconfig-c001
arm                         axm55xx_defconfig
sparc                            alldefconfig
mips                 decstation_r4k_defconfig
arm                       omap2plus_defconfig
um                                  defconfig
mips                         db1xxx_defconfig
m68k                                defconfig
riscv                    nommu_k210_defconfig
openrisc                         alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                         apsh4a3a_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
sh                          r7780mp_defconfig
arm                        mvebu_v7_defconfig
sh                   sh7770_generic_defconfig
alpha                             allnoconfig
powerpc                     tqm8548_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                     taishan_defconfig
parisc                           allyesconfig
arm                          iop32x_defconfig
m68k                       bvme6000_defconfig
arm                        mini2440_defconfig
powerpc                        warp_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
xtensa                       common_defconfig
arm                           stm32_defconfig
powerpc                 linkstation_defconfig
sh                           se7619_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                 randconfig-a001-20230109
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a006-20230109
i386                 randconfig-a005-20230109
x86_64                        randconfig-a005
hexagon              randconfig-r045-20230109
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20230109
riscv                randconfig-r042-20230108
hexagon              randconfig-r041-20230108
hexagon              randconfig-r041-20230109
hexagon              randconfig-r045-20230108
s390                 randconfig-r044-20230108
x86_64                        randconfig-k001
mips                        qi_lb60_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

