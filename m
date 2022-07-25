Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3FCC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BK6i5UFyCxfI8n5kuq9Rbxky5TZuAyT5UCr07oG7SWw=; b=2ll2D/NMKN8ewry5dI/tgN+MHf
	QbUXuvhF3T4gOZEgJetbSJNhhv7el/ohk7+/IDRVbONptqWPo+JnTji6kiA0E13ZGjIOYqYNMUhxI
	QZ1F2bDrgt0VDb9khqETf04q7PCfeHA7al/thuR5TTlpuOYqWMFHbM344CJ4NcEMLCOM3NMSQS/q7
	7ONqyuLuanVV/Lyy24Qn3If4Y3ZOoc6p3OejfWObeNgO5e50BpNoIcI8cl4PtnmTAGKXx650pmgix
	ighm1dLtnA8LpcfPOtka4+t01vWmB2fZv5z21i033+/6XtP0KIFf1jNuTEj+Zke2qnIFN7H6kunr+
	uXwoizPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG29R-00G8H6-1J; Mon, 25 Jul 2022 17:45:53 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG29O-00G7vt-HX
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 17:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658771150; x=1690307150;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Wt535wiHSg7wcxaYhlg8L2NoJlwfqPfBFbFk9MUg9O4=;
  b=UIKNGgxddI3MSnuJg8LudqLt+lzy9n0AZsvoaAXkAhQwQEfpbmnUgAEy
   WCYmbIhSR+uMqVJ/I5HAYcpJloqKO/6K+EsIv0on9H0AJPbRErfu2KiRt
   y30F9JA5thxAg2OhxaJYYsj6bJwEzXxiKyJcDHwnn2d3g9LMnmoDpS+Tf
   wOYZWY5R9BzROabBTsuiz7rT8v3c1Ns8og91jtepZeTBk+WdIs/O5Xu0m
   lh0/b+5xSBBXao4VJdqKoCke/Houz999oFniS4dzn+zq0/cH/QMN+r2S6
   0c4pCqa36z/y5KYzr1bOS7OdJ6zFndMF/3eXmUGrDJZVV5D++Mz3x94Lr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="313511810"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="313511810"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 10:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="550074057"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2022 10:45:46 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oG29J-0005NA-1o;
	Mon, 25 Jul 2022 17:45:45 +0000
Date: Tue, 26 Jul 2022 01:45:10 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 d6c52fa3e955b97f8eb3ac824d2a3e0af147b3ce
Message-ID: <62ded6a6.Xt4jqp2p+epkVHYY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_104550_636187_BE9745F3 
X-CRM114-Status: UNSURE (   8.97  )
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
branch HEAD: d6c52fa3e955b97f8eb3ac824d2a3e0af147b3ce  nvme-pci: Crucial P2 has bogus namespace ids

elapsed time: 725m

configs tested: 128
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220724
i386                          randconfig-c001
powerpc                 mpc85xx_cds_defconfig
parisc64                         alldefconfig
arm                        clps711x_defconfig
arm                           u8500_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
arm                         cm_x300_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          sdk7786_defconfig
arm                         axm55xx_defconfig
sh                               allmodconfig
sh                          lboxre2_defconfig
sh                         ap325rxa_defconfig
loongarch                           defconfig
riscv                            allyesconfig
xtensa                         virt_defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
arm                          badge4_defconfig
arm                       imx_v6_v7_defconfig
arm                       aspeed_g5_defconfig
sh                      rts7751r2d1_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          lpd270_defconfig
s390                             allmodconfig
sh                           se7780_defconfig
sh                          polaris_defconfig
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
arc                          axs101_defconfig
arm                        shmobile_defconfig
m68k                           virt_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
mips                         cobalt_defconfig
arm                        trizeps4_defconfig
powerpc                      ep88xc_defconfig
sparc                       sparc32_defconfig
sh                     sh7710voipgw_defconfig
m68k                        m5407c3_defconfig
nios2                         3c120_defconfig
xtensa                generic_kc705_defconfig
s390                                defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20220724
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220724
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      pxa255-idp_defconfig
arm                          ixp4xx_defconfig
powerpc                     powernv_defconfig
mips                            e55_defconfig
mips                        omega2p_defconfig
mips                          malta_defconfig
mips                     loongson2k_defconfig
mips                      maltaaprp_defconfig
arm                         hackkit_defconfig
mips                         tb0219_defconfig
arm                        mvebu_v5_defconfig
mips                   sb1250_swarm_defconfig
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
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

