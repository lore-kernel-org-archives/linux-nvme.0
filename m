Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D4EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 22:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w9Rv3SsRHg4w8VPCd834jdA2Xveuk2NEFdDR+4NCslc=; b=4Zb9t0sVkcCBJ0gQJwhr8fXvWg
	riqs0IUB+a3/iPr7ve+GfMeIoEUc2qfmPq6ZNKEKNjkg7l6PeydrwnORoEQzS6NWXJ4Q/k06j4ANV
	1EsNAMMrYvOw9PDuwfAHyJtcMofTEzZE/l4cFuzy5myba5nPAIMXJ8HzJ7FnmG0c4eKo/pEX1FCZd
	WA3DyUH9anyJsgAa+t/Z+YRaF5MxvxREOMehpbMkmvAh4FlyXUqh85r8gqOOH2Rw85tS5h9EUBR6H
	ApWJx4MpgBY1WAfC85+ZwVp1tEGPufGenvTGvtPth/NvVuMIOfXLlqaMCmNWqRWgURYFaGJL0hLnV
	KmcLP/4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxzCp-007oZG-AJ; Thu, 16 Dec 2021 22:26:31 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxzCm-007oYF-KI
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 22:26:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639693588; x=1671229588;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=77K9qZpzi4504xQ+M+RzhCS0bsLEkh/qAg95FhLfHw4=;
 b=MAfMPFiJoGFlotUmrf2m35i6CqmWMsRleAi+j5qucNThL2bkBAV1JGjJ
 wF/+DH+s2bWBHXvuR7gM3AjFVzMrvjGT/qaEqydAfqIDHgENamYBxsVBa
 FRk7NL7kgAGDN6j7uonRw4wHQldaI3uqJGUpigE/zMwELRbE38reIb7gj
 pQnAw0K+7wJBQ42TrIWkX/ddZ7k8gUglj5cBoFj91793dY6Onus95g1IN
 cr0JQZ5yKE3Mp79xMLhp6YijJklFGIv+JRfkYrVPH597Dqnjs1w3+H/EM
 b3qraHQLNB5TDPP06Y7t5q1TWHJg0WdeBilQedevsaX0vqkRcLT2JT6q7 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239567340"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; d="scan'208";a="239567340"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 14:26:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; d="scan'208";a="482998573"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 16 Dec 2021 14:26:25 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mxzCj-0003tX-2w; Thu, 16 Dec 2021 22:26:25 +0000
Date: Fri, 17 Dec 2021 06:25:50 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.17] BUILD SUCCESS
 c20882a70c0e09e0c4fd037c268965ad503c28db
Message-ID: <61bbbcee.cNItRJt4FouYttcG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_142628_766406_E8983256 
X-CRM114-Status: UNSURE (   7.44  )
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
branch HEAD: c20882a70c0e09e0c4fd037c268965ad503c28db  nvme-fabrics: print out valid arguments when reading from /dev/nvme-fabrics

elapsed time: 726m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211216
arm                        clps711x_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     tqm8540_defconfig
m68k                          hp300_defconfig
m68k                       m5475evb_defconfig
sh                           se7712_defconfig
arm                         lubbock_defconfig
arm                        magician_defconfig
arm                         s3c2410_defconfig
ia64                            zx1_defconfig
mips                        workpad_defconfig
arm                        keystone_defconfig
arm                         lpc32xx_defconfig
xtensa                              defconfig
microblaze                          defconfig
powerpc                  iss476-smp_defconfig
sh                          landisk_defconfig
arm                          pcm027_defconfig
sh                   secureedge5410_defconfig
arm                             rpc_defconfig
powerpc                      makalu_defconfig
arm                       cns3420vb_defconfig
arm                            dove_defconfig
arm                        trizeps4_defconfig
arc                          axs103_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            pleb_defconfig
mips                         mpc30x_defconfig
powerpc                   currituck_defconfig
mips                     loongson1b_defconfig
m68k                          atari_defconfig
h8300                    h8300h-sim_defconfig
sh                        dreamcast_defconfig
arm                           sunxi_defconfig
powerpc                     redwood_defconfig
sh                          rsk7269_defconfig
sh                               j2_defconfig
powerpc                     tqm8560_defconfig
powerpc                        cell_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
powerpc                      walnut_defconfig
powerpc                     rainier_defconfig
sh                            hp6xx_defconfig
powerpc                      pmac32_defconfig
nds32                             allnoconfig
sh                         microdev_defconfig
i386                                defconfig
arm                         nhk8815_defconfig
arm                       omap2plus_defconfig
sh                          rsk7203_defconfig
arc                            hsdk_defconfig
powerpc                     pseries_defconfig
sh                           se7722_defconfig
mips                           mtx1_defconfig
csky                                defconfig
arm                        mvebu_v7_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         shannon_defconfig
powerpc                    adder875_defconfig
mips                      pic32mzda_defconfig
arm                            mmp2_defconfig
nds32                               defconfig
arm                         at91_dt_defconfig
sh                        sh7763rdp_defconfig
powerpc                      bamboo_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        vexpress_defconfig
arm                     davinci_all_defconfig
sh                           se7724_defconfig
powerpc                       ebony_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        edosk7705_defconfig
arm                             mxs_defconfig
mips                       capcella_defconfig
powerpc                     taishan_defconfig
sh                   rts7751r2dplus_defconfig
arm                          imote2_defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
arc                      axs103_smp_defconfig
arm                         orion5x_defconfig
nios2                               defconfig
sh                                  defconfig
m68k                       m5275evb_defconfig
arm                  randconfig-c002-20211216
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
i386                 randconfig-a001-20211216
i386                 randconfig-a002-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a004-20211216
arc                  randconfig-r043-20211216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20211216
x86_64               randconfig-a014-20211216
x86_64               randconfig-a012-20211216
x86_64               randconfig-a013-20211216
x86_64               randconfig-a016-20211216
x86_64               randconfig-a015-20211216
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

