Return-Path: <SRS0=gxeb=PJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59352C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 11:18:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011E560EFE
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 11:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 011E560EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sgcEU/85LcX9OFd4amqiUWRZX7MUic9STS1tfp3nZ00=; b=DBqlMOpOLDNH3WiAgeWWfiS+a5
	IyuoHy92V0N77+38vydQF72cugORB64yU67WP8ujdThl8Jtqmj7px4HFTXU7hQA/y4LjHBCs+xavV
	l23UKRu4U9a99RPHnjKahAjPGoO2GQcS4eyn+7FV9LVAJCXXMkMvfL5aMYBQl28w/MEZHFZ3JscVD
	jwEINYVyQRPSEDzxhNf9+/GmEDafVljrUHtr5IfI/AHsZeBIWr66XFZwMD+Ju61Q5aV1FPcgfMJ2E
	/9Ol3YMlZqgiogFLR26O+Ex0jWzVSOMP08EB8WK2d6Y7cPDbFXaCxbApPBEMbCi0OK5oNWrN7wIt3
	nkbOc6fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdW5m-007K9A-TY; Thu, 21 Oct 2021 11:18:38 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdW5j-007K8t-5g
 for linux-nvme@lists.infradead.org; Thu, 21 Oct 2021 11:18:36 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="229279859"
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="229279859"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2021 04:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="662669579"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 21 Oct 2021 04:18:29 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mdW5c-000EJR-GB; Thu, 21 Oct 2021 11:18:28 +0000
Date: Thu, 21 Oct 2021 19:17:38 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.16] BUILD SUCCESS
 117d5b6d00ee02f73d7065fe906e2ef1af74bb68
Message-ID: <61714c52.w4RNlVx8txu19qY8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211021_041835_264606_C76EF2FC 
X-CRM114-Status: UNSURE (   6.86  )
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
branch HEAD: 117d5b6d00ee02f73d7065fe906e2ef1af74bb68  nvmet: use struct_size over open coded arithmetic

elapsed time: 1068m

configs tested: 175
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20211019
i386                 randconfig-c001-20211021
sh                         microdev_defconfig
arm                        mvebu_v5_defconfig
powerpc                       eiger_defconfig
ia64                      gensparse_defconfig
arm                         shannon_defconfig
arm                             pxa_defconfig
m68k                        mvme16x_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     asp8347_defconfig
x86_64                           allyesconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
sh                            hp6xx_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          rm200_defconfig
ia64                         bigsur_defconfig
arm                            dove_defconfig
powerpc                     ksi8560_defconfig
arm                         axm55xx_defconfig
sh                           se7722_defconfig
mips                         tb0219_defconfig
powerpc64                           defconfig
xtensa                       common_defconfig
xtensa                  nommu_kc705_defconfig
sh                 kfr2r09-romimage_defconfig
csky                             alldefconfig
powerpc                      ppc40x_defconfig
sh                             shx3_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                    adder875_defconfig
mips                malta_qemu_32r6_defconfig
arc                            hsdk_defconfig
arm                            mmp2_defconfig
powerpc                     tqm8548_defconfig
openrisc                 simple_smp_defconfig
arm                          gemini_defconfig
arm                        spear6xx_defconfig
powerpc                      ppc6xx_defconfig
arm                        trizeps4_defconfig
sh                          kfr2r09_defconfig
powerpc                     sequoia_defconfig
arm                          exynos_defconfig
arm                         orion5x_defconfig
arm                       aspeed_g4_defconfig
sh                             espt_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8540_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            lart_defconfig
powerpc                 mpc8560_ads_defconfig
sh                        edosk7760_defconfig
m68k                       bvme6000_defconfig
sh                          rsk7201_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                          g5_defconfig
ia64                             alldefconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20211019
x86_64               randconfig-c001-20211019
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20211020
i386                 randconfig-a003-20211020
i386                 randconfig-a002-20211020
i386                 randconfig-a005-20211020
i386                 randconfig-a006-20211020
i386                 randconfig-a001-20211020
x86_64               randconfig-a013-20211021
x86_64               randconfig-a015-20211021
x86_64               randconfig-a011-20211021
x86_64               randconfig-a014-20211021
x86_64               randconfig-a016-20211021
x86_64               randconfig-a012-20211021
x86_64               randconfig-a015-20211019
x86_64               randconfig-a012-20211019
x86_64               randconfig-a016-20211019
x86_64               randconfig-a014-20211019
x86_64               randconfig-a013-20211019
x86_64               randconfig-a011-20211019
i386                 randconfig-a012-20211021
i386                 randconfig-a013-20211021
i386                 randconfig-a011-20211021
i386                 randconfig-a016-20211021
i386                 randconfig-a015-20211021
i386                 randconfig-a014-20211021
i386                 randconfig-a014-20211019
i386                 randconfig-a016-20211019
i386                 randconfig-a011-20211019
i386                 randconfig-a015-20211019
i386                 randconfig-a012-20211019
i386                 randconfig-a013-20211019
arc                  randconfig-r043-20211019
s390                 randconfig-r044-20211019
riscv                randconfig-r042-20211019
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20211021
riscv                randconfig-c006-20211021
arm                  randconfig-c002-20211021
x86_64               randconfig-c007-20211021
mips                 randconfig-c004-20211021
s390                 randconfig-c005-20211021
i386                 randconfig-c001-20211021
x86_64               randconfig-a002-20211021
x86_64               randconfig-a004-20211021
x86_64               randconfig-a005-20211021
x86_64               randconfig-a001-20211021
x86_64               randconfig-a006-20211021
x86_64               randconfig-a003-20211021
i386                 randconfig-a004-20211021
i386                 randconfig-a003-20211021
i386                 randconfig-a002-20211021
i386                 randconfig-a005-20211021
i386                 randconfig-a001-20211021
i386                 randconfig-a006-20211021
hexagon              randconfig-r045-20211021
hexagon              randconfig-r041-20211021
hexagon              randconfig-r041-20211019
hexagon              randconfig-r045-20211019
x86_64               randconfig-a004-20211019
x86_64               randconfig-a006-20211019
x86_64               randconfig-a005-20211019
x86_64               randconfig-a001-20211019
x86_64               randconfig-a002-20211019
x86_64               randconfig-a003-20211019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

