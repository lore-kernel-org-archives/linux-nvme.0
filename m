Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3270C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 22:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XuIxMQit+Zb3WZJNj97d/gLPC2sRV7giOlo3agUcd90=; b=MNuRxXPNmbTedTdnnzGWKdPFBw
	skfEc2I8hazd2+kqFdV0Tg+d7P6PbU/q0dpSNF5jY4v/HXiE9qWyiAlZGhwr/Bu4UDzX+ufFn+0j0
	xFsf0Q0qHe26/KikoBDDow2LybSqwkNS9K7NQ+Iiejh9sqPdlrSx1bsg6g5D9GFTVxLuN+Znt6Z+M
	DOr74T5qvf37QIiEtTs3lraj+5NRXAlaYUnI67K6wkFNagxqEbZAGOdODKkq3aImZanmUKlcJtesd
	JpnWzEocBztQdBh5sZ5aSlB7kHqsg165wr2IRUNH/Fblng4/Up5wgygIplMtJO57bpzOIXsPoWTPX
	eueb4Yxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o495W-00CRzC-Q5; Wed, 22 Jun 2022 22:44:42 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o495T-00CRyM-QS
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 22:44:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655937879; x=1687473879;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xg/QKVZjqBe+4JPUm8JYns6sStD7No5zuOS2V2Jy9os=;
  b=g6eJl7O7VqMh+bdQsHBwLpx5Y81LVGOOwMMVkMGGvBkBVWejL5b/vt+9
   hWVIgRg+NlnepOpt89d69OH5WthikPczfXPkjvSToOPrP8sA+rA+Jz/7g
   S2lm8FH8rg9kIuv6eyB9ss6NMLemMW6t8mJe90WgGzWMejtFJPzIl5wSH
   Ys5FPy5LZDutpgK/nhA25Sw89E02y7Kf9TVan8Z0QA5pMpomiAgGDm+cM
   Oy7B2QbkcF4Tnyd7bt7se9d0qpLWK+39dBpS1bty1e0a7rPxdm7ia16tm
   nj9owcCupJUs/hGAlvu4IQV5kLIuVx9pQJRvVVU4UzQ+UOyD6Zth/E2N4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="306022620"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="306022620"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:44:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644427740"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2022 15:44:37 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o495Q-0001m5-FA;
	Wed, 22 Jun 2022 22:44:36 +0000
Date: Thu, 23 Jun 2022 06:44:12 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 7cb27d4b43168531c51e86e99ab990beb5315f96
Message-ID: <62b39b3c.AQmgFU9dRiJwpBCr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_154439_925284_718ED7D1 
X-CRM114-Status: UNSURE (   8.10  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.19
branch HEAD: 7cb27d4b43168531c51e86e99ab990beb5315f96  nvme: move the Samsung X5 quirk entry to the core quirks

elapsed time: 724m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                           se7780_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     mpc83xx_defconfig
sh                          urquell_defconfig
sparc                       sparc64_defconfig
m68k                          multi_defconfig
alpha                            alldefconfig
mips                       bmips_be_defconfig
csky                             alldefconfig
mips                          rb532_defconfig
arc                      axs103_smp_defconfig
arc                              alldefconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
s390                          debug_defconfig
arm                        oxnas_v6_defconfig
um                               alldefconfig
sh                           se7724_defconfig
arm                        realview_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                         wii_defconfig
sh                          sdk7786_defconfig
arm                         axm55xx_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
sh                             sh03_defconfig
openrisc                         alldefconfig
arm                      integrator_defconfig
xtensa                  nommu_kc705_defconfig
um                             i386_defconfig
arm                         vf610m4_defconfig
powerpc                      pasemi_defconfig
m68k                            q40_defconfig
arm                           stm32_defconfig
sh                          kfr2r09_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
x86_64                        randconfig-c001
arm                  randconfig-c002-20220622
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                 mpc8315_rdb_defconfig
arm                          ixp4xx_defconfig
riscv                    nommu_virt_defconfig
mips                           ip28_defconfig
riscv                             allnoconfig
powerpc                 xes_mpc85xx_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622
hexagon              randconfig-r041-20220623
hexagon              randconfig-r045-20220623

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

