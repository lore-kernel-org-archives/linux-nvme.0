Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D42DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 17:29:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67FC61074
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 17:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D67FC61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qAmsQxC7vOiiaHOl0gHcw2CJr0qTdWYw1ed0MjDrRfc=; b=CbpgNbcN6sIk7TyFeQar1mena+
	xkAPMjqYgceZrB6VCXcLxh7vTLpPANnnfrZrshAUzONCsDdik1L7YC1VHwMJAyKun5xq0KiTJyEvR
	DSofcrfHU9/YjdXswfgAFPrFYpzkSeRKG1E3nTZNd7WeCl6Uyu5ScPkVOQDT+Rmsg6gyqPpUgZTOA
	ckLgAlyL/SxoF1UdYuZDsCDtUYCOnJOPn964DMYUBvwmCUlGVqYV/f7IhEebzBbyPCoyMGFXp7Gix
	t8jsv7Puk9MYP+Z8Ny1FgxiC5EDrCFAfNDEtZMCJ3pR4aRyE4lGA+J26kvGo2/q1sxw45NIT7aQH/
	k5J6UvEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcWRz-00Ge6T-TK; Mon, 18 Oct 2021 17:29:27 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcWRt-00Ge5Q-3I
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 17:29:22 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="251769406"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; d="scan'208";a="251769406"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2021 10:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; d="scan'208";a="661453976"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 18 Oct 2021 10:19:28 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mcWIK-000BZf-2a; Mon, 18 Oct 2021 17:19:28 +0000
Date: Tue, 19 Oct 2021 01:19:13 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.16] BUILD SUCCESS
 1b05b7825ef38c7e8969e111360ec13520cb4ea9
Message-ID: <616dac91.rozBbY8/WNEPtbWM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_102921_193616_5D91FF8F 
X-CRM114-Status: UNSURE (   8.46  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.16
branch HEAD: 1b05b7825ef38c7e8969e111360ec13520cb4ea9  nvme-rdma: fix error code in nvme_rdma_setup_ctrl

elapsed time: 722m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
mips                         tb0219_defconfig
sh                               j2_defconfig
mips                     loongson1c_defconfig
powerpc                      chrp32_defconfig
arm                          moxart_defconfig
m68k                        m5307c3_defconfig
um                             i386_defconfig
m68k                          sun3x_defconfig
powerpc                     sequoia_defconfig
m68k                          atari_defconfig
mips                       capcella_defconfig
powerpc                         ps3_defconfig
arm                    vt8500_v6_v7_defconfig
sh                         apsh4a3a_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      pcm030_defconfig
powerpc                          allyesconfig
powerpc                   microwatt_defconfig
alpha                               defconfig
sh                            shmin_defconfig
xtensa                  nommu_kc705_defconfig
arm                         hackkit_defconfig
powerpc                          g5_defconfig
powerpc                        fsp2_defconfig
sparc                       sparc64_defconfig
mips                         tb0226_defconfig
sh                        dreamcast_defconfig
mips                     cu1000-neo_defconfig
mips                       rbtx49xx_defconfig
powerpc                 mpc837x_mds_defconfig
sh                         microdev_defconfig
powerpc                     taishan_defconfig
powerpc                     mpc512x_defconfig
powerpc                 mpc834x_mds_defconfig
sh                        sh7757lcr_defconfig
powerpc                      tqm8xx_defconfig
arm                       mainstone_defconfig
sh                          r7785rp_defconfig
m68k                         amcore_defconfig
powerpc                     kmeter1_defconfig
arm                  randconfig-c002-20211018
i386                 randconfig-c001-20211018
x86_64               randconfig-c001-20211018
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20211018
x86_64               randconfig-a006-20211018
x86_64               randconfig-a005-20211018
x86_64               randconfig-a001-20211018
x86_64               randconfig-a002-20211018
x86_64               randconfig-a003-20211018
i386                 randconfig-a001-20211018
i386                 randconfig-a003-20211018
i386                 randconfig-a004-20211018
i386                 randconfig-a005-20211018
i386                 randconfig-a002-20211018
i386                 randconfig-a006-20211018
arc                  randconfig-r043-20211018
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
i386                 randconfig-a003-20211017
i386                 randconfig-a001-20211017
i386                 randconfig-a005-20211017
i386                 randconfig-a004-20211017
i386                 randconfig-a002-20211017
i386                 randconfig-a006-20211017
x86_64               randconfig-a015-20211018
x86_64               randconfig-a012-20211018
x86_64               randconfig-a016-20211018
x86_64               randconfig-a014-20211018
x86_64               randconfig-a013-20211018
x86_64               randconfig-a011-20211018
i386                 randconfig-a014-20211018
i386                 randconfig-a016-20211018
i386                 randconfig-a011-20211018
i386                 randconfig-a015-20211018
i386                 randconfig-a012-20211018
i386                 randconfig-a013-20211018
hexagon              randconfig-r041-20211018
s390                 randconfig-r044-20211018
riscv                randconfig-r042-20211018
hexagon              randconfig-r045-20211018

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

