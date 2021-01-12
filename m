Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75052C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:36:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4ED230FC
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4ED230FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FV2TBHXIZLCI+qQVlkzvOyIu0PRVROyW6n4LBAPfg+U=; b=aF/lGBk9rhP31QXfYEV2uMljYd
	5F4HmdfSsf47fPtqUk8ZFcNVkPpn+GsDPSwYd6Ff349PcV2TwK9ma4RpyBJ2M7tagMaGoTCRahGXC
	+MOjQzSm9aup++09oEDKjSO/ybg4arIyuW6ca/3MGqLO+quvaW45xPxqLdprlbfFxlfE5OazUPj8M
	MtpC32oLVqvybbEbRX4kHXSni7x3C7IN+ZDwaezlQyKrwnlYFi1UcqH7221JIqRbYTmXIKEKAGqPZ
	GNJZU+L0UVSxL6yRUGs3Jv9oQznQVoEVUlQkUF07ffCmUc7moLpekVxa4NLMU6sIKvYX3y0xdZI2s
	I+UjZs/Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzRKO-0003t5-B9; Tue, 12 Jan 2021 21:35:48 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzRKJ-0003r0-V6
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 21:35:45 +0000
IronPort-SDR: tivy7ka1/QmDf3sknSwoPfufuA/wuOg8+TRvR9P7EZ1HLKvNY6LqkkjQcc+0MkLmnOvu1a5WQ8
 WOXZorPg+0Tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="177334718"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; d="scan'208";a="177334718"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 13:35:40 -0800
IronPort-SDR: KAykxP5C/yhl0bldAR76vKU4IizYtxDTAKa1N7JdaB8FqU2Thj44kYlc0rBq2gQ/Ptcyox9pcu
 4IebFRXSxbYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; d="scan'208";a="400316762"
Received: from lkp-server01.sh.intel.com (HELO b73930e00c65) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2021 13:35:38 -0800
Received: from kbuild by b73930e00c65 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kzRKE-0000VC-9Z; Tue, 12 Jan 2021 21:35:38 +0000
Date: Wed, 13 Jan 2021 05:35:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 1f22a063446758d58d5ca577101736b16cbb9280
Message-ID: <5ffe1623.jAsyb0zoFEhUIQsV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_163544_192445_2E2226ED 
X-CRM114-Status: GOOD (  10.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git  nvme-5.11
branch HEAD: 1f22a063446758d58d5ca577101736b16cbb9280  nvme: support command retry delay for admin command

elapsed time: 783m

configs tested: 205
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7206_defconfig
sh                               allmodconfig
um                            kunit_defconfig
powerpc                     akebono_defconfig
powerpc                  mpc866_ads_defconfig
mips                         db1xxx_defconfig
mips                           rs90_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                  cadence_csp_defconfig
h8300                       h8s-sim_defconfig
mips                      pic32mzda_defconfig
powerpc                  storcenter_defconfig
arm                        neponset_defconfig
arm                          pxa910_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                   motionpro_defconfig
c6x                        evmc6678_defconfig
m68k                       m5275evb_defconfig
h8300                               defconfig
arm                         shannon_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
arm                            hisi_defconfig
powerpc                     tqm8548_defconfig
mips                           jazz_defconfig
powerpc                      cm5200_defconfig
arm                          iop32x_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     ep8248e_defconfig
mips                    maltaup_xpa_defconfig
arm                          collie_defconfig
arc                     nsimosci_hs_defconfig
arm                         cm_x300_defconfig
m68k                       m5475evb_defconfig
ia64                          tiger_defconfig
mips                      loongson3_defconfig
m68k                          amiga_defconfig
mips                        qi_lb60_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7780_defconfig
sh                          sdk7786_defconfig
arm                         mv78xx0_defconfig
arm                          tango4_defconfig
powerpc                       ebony_defconfig
arm                            lart_defconfig
arm                         lubbock_defconfig
arm                     am200epdkit_defconfig
mips                        bcm47xx_defconfig
ia64                      gensparse_defconfig
arm                          moxart_defconfig
powerpc                      arches_defconfig
arm                             rpc_defconfig
arc                        nsimosci_defconfig
m68k                          multi_defconfig
h8300                     edosk2674_defconfig
arm                           h5000_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        bcm63xx_defconfig
mips                         tb0219_defconfig
sh                           se7712_defconfig
m68k                          sun3x_defconfig
powerpc                      ppc6xx_defconfig
mips                  decstation_64_defconfig
arm                         orion5x_defconfig
sh                      rts7751r2d1_defconfig
openrisc                  or1klitex_defconfig
arm                        magician_defconfig
arm                           corgi_defconfig
sh                          r7785rp_defconfig
powerpc                       eiger_defconfig
m68k                            mac_defconfig
arm                       spear13xx_defconfig
sh                                  defconfig
mips                      malta_kvm_defconfig
sh                ecovec24-romimage_defconfig
mips                        maltaup_defconfig
sh                        dreamcast_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm5200_defconfig
c6x                                 defconfig
c6x                              alldefconfig
openrisc                 simple_smp_defconfig
arm                           h3600_defconfig
m68k                         amcore_defconfig
sh                            shmin_defconfig
c6x                        evmc6472_defconfig
sh                              ul2_defconfig
powerpc                    socrates_defconfig
um                           x86_64_defconfig
arm                         palmz72_defconfig
arm                         assabet_defconfig
powerpc                     stx_gp3_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7722_defconfig
powerpc                 mpc834x_itx_defconfig
csky                             alldefconfig
arm                           omap1_defconfig
mips                         cobalt_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
sh                             shx3_defconfig
m68k                           sun3_defconfig
sparc64                          alldefconfig
powerpc                     kmeter1_defconfig
xtensa                  nommu_kc705_defconfig
arm                          prima2_defconfig
arm                           stm32_defconfig
arc                           tb10x_defconfig
arc                              alldefconfig
mips                 decstation_r4k_defconfig
powerpc                      bamboo_defconfig
arm                          ixp4xx_defconfig
arm                         hackkit_defconfig
m68k                          atari_defconfig
arm                              zx_defconfig
powerpc                          g5_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210112
i386                 randconfig-a005-20210112
i386                 randconfig-a006-20210112
i386                 randconfig-a003-20210112
i386                 randconfig-a001-20210112
i386                 randconfig-a004-20210112
x86_64               randconfig-a015-20210112
x86_64               randconfig-a012-20210112
x86_64               randconfig-a013-20210112
x86_64               randconfig-a016-20210112
x86_64               randconfig-a014-20210112
x86_64               randconfig-a011-20210112
i386                 randconfig-a012-20210112
i386                 randconfig-a011-20210112
i386                 randconfig-a016-20210112
i386                 randconfig-a013-20210112
i386                 randconfig-a015-20210112
i386                 randconfig-a014-20210112
x86_64               randconfig-a004-20210111
x86_64               randconfig-a006-20210111
x86_64               randconfig-a001-20210111
x86_64               randconfig-a003-20210111
x86_64               randconfig-a005-20210111
x86_64               randconfig-a002-20210111
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210112
x86_64               randconfig-a004-20210112
x86_64               randconfig-a001-20210112
x86_64               randconfig-a005-20210112
x86_64               randconfig-a003-20210112
x86_64               randconfig-a002-20210112
x86_64               randconfig-a015-20210111
x86_64               randconfig-a012-20210111
x86_64               randconfig-a013-20210111
x86_64               randconfig-a016-20210111
x86_64               randconfig-a014-20210111
x86_64               randconfig-a011-20210111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
