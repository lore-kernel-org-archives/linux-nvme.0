Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC5C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 02:56:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2014A60C4D
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 02:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2014A60C4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=57JWXpKC51j6viIDugt857CZfuFlj1tIRQpPJBrK1ow=; b=2T2jUmCt5b7kDmj8I6SwVTtW2e
	NK2ZMhnszQkvWs3IbNjNAViWGO7FRpP29Wq+0VBPuWMUoVz8GBarEITVsTr5A13lqkaXBQ5XBnWJf
	0LU2amg6FVWwopUJl3z7DzytPS6ipZLm/Y73jbrkZvkNT4jxHYJmQKi+ytxd7jGIZDi6XV/i5hqYx
	z4eMQbxhHaTA6cOcQj/DGdYoeOIc26c+59NS3i5iDNOs0SnGe4is0tPaql6kQ6wzgsFspyGdvx5H6
	plAI+FoyuUMwQuEffNbpwDnHrs/sQYzc2uGi8oK/M/1+LLt+zgHGrK79Tzt5jO0YYRSIx718gPNTQ
	RgC1qY+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbDOJ-005Bzc-Mv; Fri, 15 Oct 2021 02:56:15 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbDOG-005Byd-Cd
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 02:56:14 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="251281426"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; d="scan'208";a="251281426"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2021 19:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; d="scan'208";a="660226114"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 14 Oct 2021 19:56:09 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mbDOD-000762-3v; Fri, 15 Oct 2021 02:56:09 +0000
Date: Fri, 15 Oct 2021 10:55:48 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 be5eb933542629ad6a7d4c92097b1b472b1612d0
Message-ID: <6168edb4.JzLW9Pi/UF4QSqn9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_195612_486441_85707523 
X-CRM114-Status: UNSURE (   7.47  )
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
branch HEAD: be5eb933542629ad6a7d4c92097b1b472b1612d0  nvme: fix per-namespace chardev deletion

elapsed time: 1238m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211014
sh                         microdev_defconfig
powerpc                   lite5200b_defconfig
powerpc                      cm5200_defconfig
powerpc                  iss476-smp_defconfig
mips                     loongson1b_defconfig
arm                            mmp2_defconfig
mips                          rb532_defconfig
arm                          exynos_defconfig
sh                        edosk7705_defconfig
arm                            zeus_defconfig
sh                           se7206_defconfig
sh                         ap325rxa_defconfig
powerpc                      chrp32_defconfig
sh                   sh7724_generic_defconfig
arm                           spitz_defconfig
arm                       multi_v4t_defconfig
xtensa                           alldefconfig
sh                          polaris_defconfig
powerpc                     rainier_defconfig
arm                             ezx_defconfig
s390                             alldefconfig
mips                 decstation_r4k_defconfig
arm                          collie_defconfig
s390                       zfcpdump_defconfig
mips                        qi_lb60_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     tqm8560_defconfig
arm                            qcom_defconfig
arc                      axs103_smp_defconfig
powerpc                   currituck_defconfig
mips                  decstation_64_defconfig
powerpc                     skiroot_defconfig
xtensa                         virt_defconfig
um                           x86_64_defconfig
mips                         bigsur_defconfig
arc                              alldefconfig
xtensa                    xip_kc705_defconfig
mips                      maltaaprp_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
arc                     haps_hs_smp_defconfig
m68k                          atari_defconfig
um                                  defconfig
sh                      rts7751r2d1_defconfig
arc                                 defconfig
riscv                            alldefconfig
powerpc                      ppc40x_defconfig
m68k                           sun3_defconfig
m68k                        stmark2_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
arm                       aspeed_g4_defconfig
arm                     eseries_pxa_defconfig
mips                        omega2p_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                    nommu_k210_defconfig
sh                           se7722_defconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
powerpc                         ps3_defconfig
openrisc                  or1klitex_defconfig
sh                          rsk7269_defconfig
mips                          rm200_defconfig
mips                      malta_kvm_defconfig
powerpc                      arches_defconfig
mips                        bcm47xx_defconfig
xtensa                              defconfig
riscv                            allmodconfig
m68k                             alldefconfig
nds32                               defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     tqm8541_defconfig
nios2                         3c120_defconfig
mips                      fuloong2e_defconfig
powerpc                        warp_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        vexpress_defconfig
powerpc                      pmac32_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     sequoia_defconfig
arm                       aspeed_g5_defconfig
xtensa                       common_defconfig
powerpc                      ppc44x_defconfig
arm                  randconfig-c002-20211014
x86_64               randconfig-c001-20211014
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211014
x86_64               randconfig-a004-20211014
x86_64               randconfig-a001-20211014
x86_64               randconfig-a005-20211014
x86_64               randconfig-a002-20211014
x86_64               randconfig-a003-20211014
i386                 randconfig-a003-20211014
i386                 randconfig-a001-20211014
i386                 randconfig-a005-20211014
i386                 randconfig-a004-20211014
i386                 randconfig-a002-20211014
i386                 randconfig-a006-20211014
arc                  randconfig-r043-20211014
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211014
i386                 randconfig-c001-20211014
s390                 randconfig-c005-20211014
x86_64               randconfig-c007-20211014
powerpc              randconfig-c003-20211014
riscv                randconfig-c006-20211014
x86_64               randconfig-a012-20211014
x86_64               randconfig-a015-20211014
x86_64               randconfig-a016-20211014
x86_64               randconfig-a014-20211014
x86_64               randconfig-a011-20211014
x86_64               randconfig-a013-20211014
i386                 randconfig-a016-20211014
i386                 randconfig-a014-20211014
i386                 randconfig-a011-20211014
i386                 randconfig-a015-20211014
i386                 randconfig-a012-20211014
i386                 randconfig-a013-20211014
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

