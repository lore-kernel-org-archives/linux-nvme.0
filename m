Return-Path: <SRS0=7cDU=PR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C057C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 01:49:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70566115B
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 01:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B70566115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s0ZMVhCzOsALXZjyveJiH9pTJ9UAuyrCkEw2rBOQHJ4=; b=kAAfto93dv0YvGErbJmsoMEITG
	4UXHf1Y3ee8GR/ST4OcLHGciNxEdSKH5NZZqELRzLW2iCBJWdNDSJsGpA2wllOHSIIpus1YXDgSZd
	wl1D06DXKZXXd9ZYB9eJJq1eX14BusOq/Fo2VJNkRBwLdlc4XEiPq+7BGxaMq+QhRI7dYoNmnoqo+
	smjliyjl1vAUfJgX7nycRZJYnPiEb3Ba0nt02WlqrS0rNO78+EUeRQkovi6CLIHA7RLdFr4JbqLOz
	B9Lipeu/ULwyq/ykM6QTI5vU1r6pDwLeeRh08I50tO9yFsQ8MBw7w0Hm5FVX4d+0HS6AkoAFIkvow
	KDLmoAFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgH1E-009UMH-FR; Fri, 29 Oct 2021 01:49:20 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgH16-009UKw-Uk
 for linux-nvme@lists.infradead.org; Fri, 29 Oct 2021 01:49:14 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230830073"
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; d="scan'208";a="230830073"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2021 18:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; d="scan'208";a="636551933"
Received: from lkp-server01.sh.intel.com (HELO 3b851179dbd8) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2021 18:49:08 -0700
Received: from kbuild by 3b851179dbd8 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mgH12-0002qV-1U; Fri, 29 Oct 2021 01:49:08 +0000
Date: Fri, 29 Oct 2021 09:48:27 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 86aeda32b887cdaeb0f4b7bfc9971e36377181c7
Message-ID: <617b52eb.zjPTKI4BjM1z43hW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211028_184913_053547_1B88E13A 
X-CRM114-Status: UNSURE (   7.94  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.15
branch HEAD: 86aeda32b887cdaeb0f4b7bfc9971e36377181c7  nvmet-tcp: fix header digest verification

elapsed time: 2525m

configs tested: 232
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
mips                 randconfig-c004-20211027
i386                 randconfig-c001-20211027
i386                 randconfig-c001-20211028
powerpc              randconfig-c003-20211028
mips                        workpad_defconfig
mips                malta_qemu_32r6_defconfig
mips                         tb0226_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         db1xxx_defconfig
mips                          rm200_defconfig
parisc                generic-32bit_defconfig
powerpc                   microwatt_defconfig
mips                         rt305x_defconfig
arm                   milbeaut_m10v_defconfig
arm                          exynos_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
m68k                            q40_defconfig
powerpc                          g5_defconfig
m68k                         amcore_defconfig
sh                            hp6xx_defconfig
mips                 decstation_r4k_defconfig
powerpc                      mgcoge_defconfig
sh                          r7780mp_defconfig
powerpc                     asp8347_defconfig
arc                        nsimosci_defconfig
sh                      rts7751r2d1_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
nios2                         3c120_defconfig
arc                         haps_hs_defconfig
m68k                       m5249evb_defconfig
arc                     nsimosci_hs_defconfig
sh                     magicpanelr2_defconfig
sh                          lboxre2_defconfig
sh                          r7785rp_defconfig
arm                           stm32_defconfig
arm                          pxa168_defconfig
mips                         cobalt_defconfig
powerpc                      pasemi_defconfig
arm                      footbridge_defconfig
arm                        vexpress_defconfig
arm                        trizeps4_defconfig
s390                       zfcpdump_defconfig
arm                       netwinder_defconfig
h8300                               defconfig
arm                           sunxi_defconfig
sh                         apsh4a3a_defconfig
mips                           rs90_defconfig
powerpc                     mpc83xx_defconfig
mips                            gpr_defconfig
arm                          collie_defconfig
arm                              alldefconfig
mips                     loongson2k_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                       sparc64_defconfig
arm                        cerfcube_defconfig
powerpc                   currituck_defconfig
arm                         nhk8815_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
arm                            pleb_defconfig
openrisc                    or1ksim_defconfig
powerpc                       ebony_defconfig
arm                          pcm027_defconfig
arm                         lpc32xx_defconfig
arm                          badge4_defconfig
sh                          rsk7203_defconfig
powerpc                      ppc44x_defconfig
powerpc                    sam440ep_defconfig
sh                           se7751_defconfig
powerpc                     mpc512x_defconfig
arm                         s3c6400_defconfig
powerpc                      ppc40x_defconfig
sh                           se7705_defconfig
mips                           xway_defconfig
mips                      bmips_stb_defconfig
arm                           u8500_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7722_defconfig
powerpc64                           defconfig
powerpc                      cm5200_defconfig
arm                             ezx_defconfig
microblaze                      mmu_defconfig
powerpc                    amigaone_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     decstation_defconfig
arc                           tb10x_defconfig
arm                        clps711x_defconfig
sh                           se7721_defconfig
arm                             mxs_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
mips                      loongson3_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     tqm5200_defconfig
arm                           tegra_defconfig
m68k                        stmark2_defconfig
powerpc                     akebono_defconfig
powerpc                      tqm8xx_defconfig
openrisc                            defconfig
arc                            hsdk_defconfig
powerpc                     skiroot_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc832x_mds_defconfig
xtensa                          iss_defconfig
arm                          imote2_defconfig
mips                         tb0219_defconfig
arm                          ep93xx_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                     cu1830-neo_defconfig
m68k                       m5208evb_defconfig
mips                    maltaup_xpa_defconfig
arm                  randconfig-c002-20211028
arm                  randconfig-c002-20211027
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20211028
i386                 randconfig-a003-20211028
i386                 randconfig-a002-20211028
i386                 randconfig-a006-20211028
i386                 randconfig-a001-20211028
i386                 randconfig-a005-20211028
x86_64               randconfig-a013-20211027
x86_64               randconfig-a015-20211027
x86_64               randconfig-a011-20211027
x86_64               randconfig-a014-20211027
x86_64               randconfig-a016-20211027
x86_64               randconfig-a012-20211027
i386                 randconfig-a012-20211027
i386                 randconfig-a013-20211027
i386                 randconfig-a011-20211027
i386                 randconfig-a016-20211027
i386                 randconfig-a015-20211027
i386                 randconfig-a014-20211027
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20211027
powerpc              randconfig-c003-20211027
arm                  randconfig-c002-20211027
mips                 randconfig-c004-20211027
x86_64               randconfig-c007-20211027
i386                 randconfig-c001-20211027
s390                 randconfig-c005-20211027
arm                  randconfig-c002-20211028
powerpc              randconfig-c003-20211028
riscv                randconfig-c006-20211028
x86_64               randconfig-c007-20211028
mips                 randconfig-c004-20211028
s390                 randconfig-c005-20211028
i386                 randconfig-c001-20211028
x86_64               randconfig-a002-20211027
x86_64               randconfig-a004-20211027
x86_64               randconfig-a005-20211027
x86_64               randconfig-a006-20211027
x86_64               randconfig-a001-20211027
x86_64               randconfig-a003-20211027
i386                 randconfig-a003-20211027
i386                 randconfig-a004-20211027
i386                 randconfig-a002-20211027
i386                 randconfig-a005-20211027
i386                 randconfig-a001-20211027
i386                 randconfig-a006-20211027
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
i386                 randconfig-a012-20211028
i386                 randconfig-a013-20211028
i386                 randconfig-a011-20211028
i386                 randconfig-a015-20211028
i386                 randconfig-a016-20211028
i386                 randconfig-a014-20211028
hexagon              randconfig-r045-20211028
riscv                randconfig-r042-20211028
s390                 randconfig-r044-20211028
hexagon              randconfig-r041-20211028
hexagon              randconfig-r045-20211027
hexagon              randconfig-r041-20211027

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

