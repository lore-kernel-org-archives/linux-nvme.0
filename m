Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE811C4363A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 02:01:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5CF223BF
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 02:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NY6n12jC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5CF223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uHXgVHfYRZrl33UGrfPI42xO80+TXEFb2bwG7QSNCow=; b=NY6n12jCUQ1MlyC9UhIwAXd8Ui
	FaesZFfnBSMxDgvX5aj1oUhZvhTNCS8srWcV2UpMfkRDYOddr2SDQ/ZH34ImBn0Et8VUcONIB8ohf
	4E+Guin+NOu1nsMJXP/m2xS+tDUwCJVzz8Ez1W/5KiUW135+6Z9MvgE/eWuUMFvpoJ2R0Btd5zRTX
	4KsEHVfqiorSfb/Kg9Fky3Tgpn60npUXrGphHFg1yRIcmf66+JV9QcSE5n7ax8vmX4fkC9O07g5A3
	CHT2holqMErPkSegReBrzgUjjkImRKqpq70V1G/M+Ez1Hla+yWEqY1CSCEC9Or5wzLGyYJVRvOXlX
	F+k33OPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVmOA-0005PS-Bb; Fri, 23 Oct 2020 02:01:06 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVmO4-0005Ox-85
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 02:01:01 +0000
IronPort-SDR: CML4gEM6NhCZHGNoClvWvQ54DTIfL3YV1iTI7GFS6MCVgzZEeM0diuCHCQYbDhEWwl7kGBXO6X
 epdrk1eKOt1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="165026197"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; d="scan'208";a="165026197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2020 19:00:52 -0700
IronPort-SDR: bqvBoDl2mRjx0Q+xJr2Be+Rpz3k5mx0jBROHFZ7J91xgQlQIe3TlwKqVAIvldq2aaPtU/IqG63
 hxQCN+nBKBqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; d="scan'208";a="302617367"
Received: from lkp-server01.sh.intel.com (HELO 56e21eaf2661) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2020 19:00:51 -0700
Received: from kbuild by 56e21eaf2661 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kVmNu-0000Bc-Ly; Fri, 23 Oct 2020 02:00:50 +0000
Date: Fri, 23 Oct 2020 10:00:30 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 157b2dc28599df312d71e1ac93b3306bc5b440b5
Message-ID: <5f92393e.5Y8vQRbDP0gTbYaQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_220100_474763_09FEDC63 
X-CRM114-Status: GOOD (  10.96  )
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
branch HEAD: 157b2dc28599df312d71e1ac93b3306bc5b440b5  nvme-fc: shorten reconnect delay if possible for FC

elapsed time: 725m

configs tested: 168
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
m68k                       m5208evb_defconfig
m68k                          amiga_defconfig
arm                            dove_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc837x_mds_defconfig
mips                          ath79_defconfig
um                            kunit_defconfig
powerpc                     ppa8548_defconfig
sh                           se7206_defconfig
powerpc                     tqm5200_defconfig
arm                           spitz_defconfig
h8300                    h8300h-sim_defconfig
c6x                        evmc6474_defconfig
powerpc                        icon_defconfig
arm                         bcm2835_defconfig
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
arm                       spear13xx_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      obs600_defconfig
arm                        cerfcube_defconfig
powerpc                      ppc40x_defconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
arm                       aspeed_g5_defconfig
arm                       netwinder_defconfig
arm                        oxnas_v6_defconfig
xtensa                  cadence_csp_defconfig
arc                                 defconfig
sh                               allmodconfig
mips                          rb532_defconfig
m68k                             alldefconfig
um                           x86_64_defconfig
parisc                              defconfig
arm                      footbridge_defconfig
sh                             shx3_defconfig
sh                           se7705_defconfig
sh                          polaris_defconfig
arm                           stm32_defconfig
powerpc                         wii_defconfig
nds32                             allnoconfig
arm                          prima2_defconfig
ia64                      gensparse_defconfig
mips                        nlm_xlp_defconfig
arm                        spear3xx_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     redwood_defconfig
sh                             sh03_defconfig
mips                      bmips_stb_defconfig
sparc64                          alldefconfig
sh                     magicpanelr2_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     asp8347_defconfig
m68k                          sun3x_defconfig
powerpc                       eiger_defconfig
arm                         s3c6400_defconfig
arm                       imx_v6_v7_defconfig
arm                        mvebu_v5_defconfig
c6x                         dsk6455_defconfig
arm                      pxa255-idp_defconfig
arm                         s5pv210_defconfig
m68k                          hp300_defconfig
arc                         haps_hs_defconfig
mips                        qi_lb60_defconfig
arm                            hisi_defconfig
arm                        multi_v5_defconfig
xtensa                              defconfig
mips                            ar7_defconfig
powerpc                      acadia_defconfig
sh                              ul2_defconfig
mips                         cobalt_defconfig
mips                  cavium_octeon_defconfig
m68k                        m5407c3_defconfig
sh                             espt_defconfig
arm                        realview_defconfig
arc                              allyesconfig
sh                          sdk7780_defconfig
powerpc                     rainier_defconfig
mips                           ip22_defconfig
arm                        trizeps4_defconfig
powerpc                     mpc5200_defconfig
arm                         cm_x300_defconfig
sparc                            allyesconfig
powerpc                    socrates_defconfig
c6x                        evmc6678_defconfig
mips                        omega2p_defconfig
arm                         ebsa110_defconfig
arm                        spear6xx_defconfig
powerpc                    mvme5100_defconfig
arm                             rpc_defconfig
powerpc                      ppc64e_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201022
i386                 randconfig-a005-20201022
i386                 randconfig-a003-20201022
i386                 randconfig-a001-20201022
i386                 randconfig-a006-20201022
i386                 randconfig-a004-20201022
i386                 randconfig-a002-20201023
i386                 randconfig-a005-20201023
i386                 randconfig-a003-20201023
i386                 randconfig-a001-20201023
i386                 randconfig-a006-20201023
i386                 randconfig-a004-20201023
x86_64               randconfig-a011-20201022
x86_64               randconfig-a013-20201022
x86_64               randconfig-a016-20201022
x86_64               randconfig-a015-20201022
x86_64               randconfig-a012-20201022
x86_64               randconfig-a014-20201022
i386                 randconfig-a016-20201022
i386                 randconfig-a014-20201022
i386                 randconfig-a015-20201022
i386                 randconfig-a012-20201022
i386                 randconfig-a013-20201022
i386                 randconfig-a011-20201022
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a001-20201022
x86_64               randconfig-a002-20201022
x86_64               randconfig-a003-20201022
x86_64               randconfig-a006-20201022
x86_64               randconfig-a004-20201022
x86_64               randconfig-a005-20201022

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
