Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E5C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 21:24:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56577207E8
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 21:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lovvpGXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56577207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xFZNzVH5RJyxGgkbJv/dvvHwp1+2o2lerp+zQTijcJw=; b=lovvpGXYgmIlyw6Iz1ixpuciQ2
	0fdeyO+LIFwoksJo7rDEKTFSEVMppORPhS1LHsRkHhrJOWx9ho0/ubb2pBCMkUia8C/hm7IbzY7c7
	qUM2v9lyAtLrV6+t/oomWuUkO8ir7Xfx8RWWF07IFfKeryXEHFD5iSwhqfxygn0ZxE+Bthx74Cit6
	JxvsEav8DZbnqLlZqxcXhC+TbjpA2at6DVC68vxUpD1Rrf1ueKJR3tnaWgnF1p6PLvdAPQKB7GwJz
	NHKEd46nOLCvnyXoyK7oIQYgIa9dXOBiLYota//v4AZApo0cN19zo0wIEQ4I056l076iKGx3odBxP
	BDRLGJTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXWS3-0007qi-Uj; Tue, 27 Oct 2020 21:24:19 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXWS0-0007po-Ts
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 21:24:18 +0000
IronPort-SDR: N92ojZ/kgN756F1OArPLAy6rfNi2VP00XCcYhw+98btK36aRxHOFwdwgWQFeSwaxhprSwhKEwA
 G+/Ls5fe6tdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="148019951"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; d="scan'208";a="148019951"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 14:24:13 -0700
IronPort-SDR: J2uWLC/GM/yKRoAGmsjp1EoWmfgHKDoe3oMAOWghrYQlzXVH1+GzpdnCx/71/ildjPVd0GwDFo
 atTmLzNZPyrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; d="scan'208";a="303893137"
Received: from lkp-server02.sh.intel.com (HELO 74b0a1e0e619) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2020 14:24:11 -0700
Received: from kbuild by 74b0a1e0e619 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kXWRv-00006S-8v; Tue, 27 Oct 2020 21:24:11 +0000
Date: Wed, 28 Oct 2020 05:23:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 3c3751f2daf6675f6b5bee83b792354c272f5bd2
Message-ID: <5f988fd0.OvVX7NIMDc9kXRuL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_172417_111469_26C8559C 
X-CRM114-Status: GOOD (  11.90  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.10
branch HEAD: 3c3751f2daf6675f6b5bee83b792354c272f5bd2  nvmet: fix a NULL pointer dereference when tracing the flush command

elapsed time: 721m

configs tested: 216
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
c6x                        evmc6457_defconfig
sh                            titan_defconfig
powerpc                     tqm8548_defconfig
arm                          pxa168_defconfig
mips                           ip22_defconfig
arm                     davinci_all_defconfig
powerpc                       maple_defconfig
arm                           omap1_defconfig
powerpc                       holly_defconfig
m68k                        mvme147_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8560_defconfig
sh                             sh03_defconfig
powerpc                     sequoia_defconfig
ia64                             alldefconfig
arm                           sunxi_defconfig
powerpc                        icon_defconfig
sh                     magicpanelr2_defconfig
arm                  colibri_pxa300_defconfig
arm                          pxa3xx_defconfig
powerpc                    mvme5100_defconfig
riscv                    nommu_virt_defconfig
arm                            mps2_defconfig
mips                         tb0219_defconfig
sh                          landisk_defconfig
arm                             mxs_defconfig
ia64                             allyesconfig
arm                          pxa910_defconfig
powerpc                     tqm8541_defconfig
parisc                           alldefconfig
arm                        spear6xx_defconfig
powerpc                   motionpro_defconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_rdb_defconfig
xtensa                generic_kc705_defconfig
arm                            qcom_defconfig
arm                           h3600_defconfig
arm                           sama5_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
mips                           rs90_defconfig
m68k                       m5275evb_defconfig
powerpc                  iss476-smp_defconfig
arc                     haps_hs_smp_defconfig
arm                      pxa255-idp_defconfig
arm                        neponset_defconfig
xtensa                  nommu_kc705_defconfig
sh                      rts7751r2d1_defconfig
mips                      malta_kvm_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
sh                           se7343_defconfig
powerpc                    adder875_defconfig
m68k                       m5208evb_defconfig
arm                     am200epdkit_defconfig
arm                          lpd270_defconfig
xtensa                         virt_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
parisc                generic-32bit_defconfig
arm                      integrator_defconfig
arm                          simpad_defconfig
sh                               allmodconfig
powerpc                      bamboo_defconfig
powerpc                     kmeter1_defconfig
c6x                        evmc6474_defconfig
arc                          axs103_defconfig
h8300                            allyesconfig
mips                     cu1000-neo_defconfig
mips                     loongson1c_defconfig
powerpc                         wii_defconfig
arm                           h5000_defconfig
arc                          axs101_defconfig
c6x                                 defconfig
sh                               j2_defconfig
mips                            gpr_defconfig
sh                            migor_defconfig
powerpc                      walnut_defconfig
c6x                        evmc6472_defconfig
mips                        nlm_xlp_defconfig
arc                        nsimosci_defconfig
sh                           se7780_defconfig
arm                          moxart_defconfig
arm                      footbridge_defconfig
arm                  colibri_pxa270_defconfig
s390                       zfcpdump_defconfig
sh                           se7705_defconfig
mips                        qi_lb60_defconfig
h8300                       h8s-sim_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
xtensa                    smp_lx200_defconfig
arm                          exynos_defconfig
sh                          rsk7264_defconfig
nds32                             allnoconfig
arm                         vf610m4_defconfig
mips                      fuloong2e_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
arc                      axs103_smp_defconfig
ia64                                defconfig
m68k                        mvme16x_defconfig
powerpc                      acadia_defconfig
powerpc                         ps3_defconfig
c6x                        evmc6678_defconfig
powerpc                       ppc64_defconfig
arm                       versatile_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      chrp32_defconfig
mips                        maltaup_defconfig
mips                         mpc30x_defconfig
sh                          lboxre2_defconfig
mips                           ip28_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
arm                           spitz_defconfig
mips                          rb532_defconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
i386                 randconfig-a002-20201027
i386                 randconfig-a003-20201027
i386                 randconfig-a005-20201027
i386                 randconfig-a001-20201027
i386                 randconfig-a006-20201027
i386                 randconfig-a004-20201027
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
i386                 randconfig-a016-20201027
i386                 randconfig-a015-20201027
i386                 randconfig-a014-20201027
i386                 randconfig-a012-20201027
i386                 randconfig-a013-20201027
i386                 randconfig-a011-20201027
x86_64               randconfig-a001-20201027
x86_64               randconfig-a003-20201027
x86_64               randconfig-a002-20201027
x86_64               randconfig-a006-20201027
x86_64               randconfig-a004-20201027
x86_64               randconfig-a005-20201027
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026
x86_64               randconfig-a011-20201027
x86_64               randconfig-a013-20201027
x86_64               randconfig-a016-20201027
x86_64               randconfig-a015-20201027
x86_64               randconfig-a012-20201027
x86_64               randconfig-a014-20201027

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
