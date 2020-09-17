Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E3DC43463
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 21:06:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31327208E4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 21:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jdQcCVhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31327208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WbCHE4b8kDITfzxDvymu8Gp4HhRgn3dHsGHhL5ZzYTI=; b=jdQcCVhOSl/tKE80BRn5mmA78T
	M/I1P2APHHFgX7DD4TKe8yIQFZvItxQvpuCFpNVanZ+/PyI6gC8IRP7MX4lXgW6zKjWbgt5r9tZzf
	xNUVX2ze+wmoFdN3q4DRXCr1suZlGOHr1nxrbajHMej6HUCZcEbOylPJ4R9Bat3SciO6uob92AAOO
	nHHePXTy7VD9rbKS/Mzycnt10UaL8IiSWUyIVNPM42WIFUhiOKFsFfEGHkgwmY0q3kr7o71wIXOcS
	O/Oas6lZ9y5i9OMgcflpbdaRAn4EwD5SwPYwHXZRKXSrhYkno0U7vIRa64740M2X10B4YcsJotxHT
	RmET22xA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ16R-00073K-5r; Thu, 17 Sep 2020 21:06:03 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ16O-00072r-Lt
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 21:06:02 +0000
IronPort-SDR: 1AeeX0k/Pg+LnmjzXYURFzwvTlmtqvnzpqRCj/zJd0b8B/M1WX/zKAjT2kCe58PhP5WrI5Fqbw
 VkG48SPf0HCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147481272"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; d="scan'208";a="147481272"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 14:05:53 -0700
IronPort-SDR: ozE8P1kx2nM84YmRCDVZSbWOgCbdIhgqNtc+sGBvvVvptaLJRBDRDuR09NYlMZHGlXVlL6IoHg
 GeAhE46OgfEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; d="scan'208";a="344495359"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2020 14:05:52 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kJ16F-00008p-Lc; Thu, 17 Sep 2020 21:05:51 +0000
Date: Fri, 18 Sep 2020 05:05:36 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 d7113a600e39a10c295b12abf6f3dbb8c2dbd451
Message-ID: <5f63cfa0.0yYe7cvvI8X3uXsr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_170600_848885_96143523 
X-CRM114-Status: GOOD (  13.17  )
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
branch HEAD: d7113a600e39a10c295b12abf6f3dbb8c2dbd451  nvmet: handle keep-alive timer when kato is modified by a set features cmd

elapsed time: 725m

configs tested: 163
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        omega2p_defconfig
arm                         lubbock_defconfig
arm                           spitz_defconfig
powerpc                        warp_defconfig
sh                        dreamcast_defconfig
m68k                          hp300_defconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            u300_defconfig
m68k                             allyesconfig
powerpc                      pcm030_defconfig
arm                            lart_defconfig
powerpc                    mvme5100_defconfig
powerpc                     sbc8548_defconfig
sparc                       sparc64_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     akebono_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     rainier_defconfig
mips                       capcella_defconfig
powerpc                     kilauea_defconfig
arm                        mvebu_v7_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8548_defconfig
sh                         ecovec24_defconfig
powerpc                       maple_defconfig
m68k                          amiga_defconfig
riscv                            alldefconfig
mips                     loongson1c_defconfig
arc                     nsimosci_hs_defconfig
riscv                          rv32_defconfig
arm                       imx_v4_v5_defconfig
m68k                             alldefconfig
mips                    maltaup_xpa_defconfig
arm                         vf610m4_defconfig
arm                          collie_defconfig
nios2                         3c120_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                               alldefconfig
sh                               j2_defconfig
powerpc                      acadia_defconfig
sh                             shx3_defconfig
sh                   sh7724_generic_defconfig
mips                          malta_defconfig
m68k                          sun3x_defconfig
powerpc                  storcenter_defconfig
sh                        edosk7705_defconfig
powerpc                    gamecube_defconfig
xtensa                          iss_defconfig
mips                      loongson3_defconfig
powerpc                        cell_defconfig
mips                         cobalt_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
sh                             sh03_defconfig
mips                      malta_kvm_defconfig
powerpc                      ep88xc_defconfig
sparc                            alldefconfig
ia64                          tiger_defconfig
arc                           tb10x_defconfig
arc                            hsdk_defconfig
arm                       omap2plus_defconfig
sh                           se7712_defconfig
powerpc                      katmai_defconfig
mips                  cavium_octeon_defconfig
nios2                         10m50_defconfig
powerpc                        fsp2_defconfig
mips                       lemote2f_defconfig
arm                         lpc18xx_defconfig
s390                             allyesconfig
mips                           rs90_defconfig
arm                        vexpress_defconfig
mips                         rt305x_defconfig
mips                           ip28_defconfig
sh                          urquell_defconfig
arm                         s3c6400_defconfig
mips                      maltasmvp_defconfig
parisc                generic-32bit_defconfig
riscv                             allnoconfig
sh                      rts7751r2d1_defconfig
powerpc                     pq2fads_defconfig
sh                              ul2_defconfig
ia64                      gensparse_defconfig
arm                       imx_v6_v7_defconfig
arm                             ezx_defconfig
arm                        multi_v5_defconfig
arm                       spear13xx_defconfig
arc                        vdk_hs38_defconfig
sh                     sh7710voipgw_defconfig
arc                                 defconfig
i386                                defconfig
ia64                             allmodconfig
sh                          r7780mp_defconfig
mips                         tb0226_defconfig
h8300                               defconfig
mips                           ci20_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
