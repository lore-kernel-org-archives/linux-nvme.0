Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E46DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 05:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y1PulyMzox5z0FD9HqCh1aKG9SJy+oNk9MBgUdupkU4=; b=0pkkzn0aQzdSmCEOQCGfoNdq2O
	HZ75LQG2FBIQ13O2hunxECjJuAnXrLAJY8URur5yWprLRFeV5AmC81XqnfMBLAdJ9uL3Dh3FgeeCo
	tePHeJwAyFrhrE2dSFHvXkFyaf6SIHWPOcsKjsinEljEKEdwkLhij3rSwWrr26ngNWz4+/iwcE4tD
	YuCc8ooWv8mJaj0NFLCGy7N3uTat7Gv9WGM1ZBvfYNnAbglSXNXYNBrPDEkHTwBQGrktpXTEV9eFz
	aguTg3p95ch3/Vp+ksDuUZKVldYlbtSEqeznRJLiGpzRsuOI8PZynzAzfQl4HbvSxDPDCW6gMbqI4
	GZ6inA8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMkPE-00CscH-3Z; Wed, 23 Feb 2022 05:41:40 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMkPA-00Csbs-Mh
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 05:41:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645594896; x=1677130896;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=fu/V031Af11GOwWGn+R7/1fDFOUkkY2aHPqixLzjgWY=;
 b=ITIL+P6qm1IFUSv4fz0ezE+0mTK9DJbExJU6mhts0bQIxawkBiDm8w/0
 71murmI0YLhttOIm7gHnXyVX0Fmskwo3Fibd2EjWdJKZnPp8aHShFfEOm
 oFOZVTB64R4ozbt9JNi+bqESC/GLZhj6fNUZvLa2tO4tF8dOonuRH/D1T
 47OTkh0b0Pd6o+8KErpHvZZGV7XxazCnG+UV1n4eExAzz95T160HVoZvV
 3OUuD6kBq1Y+yPB542nDJSTz1KDwvCGQF1iwKJIQY05DuIugLAvMyk6BN
 sCcQnd8zjIZYPni7kfvafZJ7DVjNNlB+aSaJOJSZp2STri/as/G7vNluu A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="276506166"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; d="scan'208";a="276506166"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 21:41:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; d="scan'208";a="706903976"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 22 Feb 2022 21:41:18 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nMkOq-00011o-Hh; Wed, 23 Feb 2022 05:41:16 +0000
Date: Wed, 23 Feb 2022 13:40:50 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.17] BUILD SUCCESS
 d25c39a5c06006e69134187c8ea53bc4c7d66259
Message-ID: <6215c8e2.I4w3JFHNWTu2gzHt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_214136_810985_F4F06540 
X-CRM114-Status: UNSURE (   7.89  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.17
branch HEAD: d25c39a5c06006e69134187c8ea53bc4c7d66259  nvme-tcp: send H2CData PDUs based on MAXH2CDATA

elapsed time: 729m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220221
arc                      axs103_smp_defconfig
arm                            lart_defconfig
ia64                            zx1_defconfig
arm                         nhk8815_defconfig
powerpc                     sequoia_defconfig
powerpc                         ps3_defconfig
m68k                        m5307c3_defconfig
mips                         db1xxx_defconfig
sparc                               defconfig
arm                          pxa910_defconfig
m68k                       m5475evb_defconfig
m68k                       m5275evb_defconfig
arm                         assabet_defconfig
m68k                             allyesconfig
arc                     haps_hs_smp_defconfig
arm                           stm32_defconfig
mips                           ip32_defconfig
m68k                       m5249evb_defconfig
sparc                            alldefconfig
um                                  defconfig
arm                           sunxi_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     redwood_defconfig
alpha                               defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
powerpc                      ppc6xx_defconfig
mips                            gpr_defconfig
sh                          rsk7203_defconfig
mips                         bigsur_defconfig
arm                          badge4_defconfig
arm                       multi_v4t_defconfig
arm                  randconfig-c002-20220221
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20220221
x86_64               randconfig-a002-20220221
x86_64               randconfig-a005-20220221
x86_64               randconfig-a006-20220221
x86_64               randconfig-a001-20220221
x86_64               randconfig-a004-20220221
i386                 randconfig-a002-20220221
i386                 randconfig-a001-20220221
i386                 randconfig-a005-20220221
i386                 randconfig-a003-20220221
i386                 randconfig-a006-20220221
i386                 randconfig-a004-20220221
arc                  randconfig-r043-20220221
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
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func

clang tested configs:
arm                          imote2_defconfig
mips                          ath79_defconfig
mips                       lemote2f_defconfig
mips                malta_qemu_32r6_defconfig
arm                           omap1_defconfig
arm                      pxa255-idp_defconfig
arm                          pcm027_defconfig
arm                            dove_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220221
x86_64               randconfig-a015-20220221
x86_64               randconfig-a014-20220221
x86_64               randconfig-a016-20220221
x86_64               randconfig-a013-20220221
x86_64               randconfig-a012-20220221
i386                 randconfig-a016-20220221
i386                 randconfig-a012-20220221
i386                 randconfig-a015-20220221
i386                 randconfig-a011-20220221
i386                 randconfig-a014-20220221
i386                 randconfig-a013-20220221
hexagon              randconfig-r045-20220221
hexagon              randconfig-r041-20220221
riscv                randconfig-r042-20220221
s390                 randconfig-r044-20220221

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

