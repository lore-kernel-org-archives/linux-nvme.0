Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86853C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 02:07:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D961C20E65
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 02:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D961C20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4bYE0eUi9WF32Oin3UNCtd2Ph+KTiEXo/8keagfoSrc=; b=Pgx8Tpr52VWWf5wihMAO5rHmj+
	QQi5Fp65tz2WaC8H4SHo4dtZgyvm1nd9z5t/4lIx2x8wffftYqsrn9/kmqXYZuR2+UEvFpIq4zNkv
	5bRQAyEW0w7Wi2G5BdiII9Wv5PInQ99JgvbNSoYE6pVoEqNHGPwwlbSppKl1AidIGQyeJOXYiHVIm
	5cJxhhpEdl6Qn4nlVSDtPIGtTOJ+3TEX6Ld31cV9uw7cbY6Z1j9kO1DGI/ufxzw90mgDXqFdhkvP8
	sm9IbL8b3jFzfNt2tK3z1PTqefEdHGGAynHf5gfRnLTVGgUxi4SYikwmoiZ2BoWI0IMwgAy2mpxD4
	PAKpTwSA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krtYN-0006Fg-Ks; Wed, 23 Dec 2020 02:07:03 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krtYK-0006F5-2B
 for linux-nvme@lists.infradead.org; Wed, 23 Dec 2020 02:07:01 +0000
IronPort-SDR: KA47lkr9iHs8vH5hYRp8k7/KhEUGsnbi3tfalM2QQXO5bO4Js9uYDZPhXk/R7NiA1JcLBscRvY
 gs133XXSz3IQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="172438395"
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; d="scan'208";a="172438395"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 18:06:56 -0800
IronPort-SDR: ZXsSnv0qD6Bzzt81e8cGmHOo6VSwuhApvrR/O4nFt/FrbvPN0gT9nrwQ7PZXZAlR6Mkty8aQ8T
 FfS0FridERYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; d="scan'208";a="416973441"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
 by orsmga001.jf.intel.com with ESMTP; 22 Dec 2020 18:06:55 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1krtYE-00002p-Ps; Wed, 23 Dec 2020 02:06:54 +0000
Date: Wed, 23 Dec 2020 10:06:17 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 8eb487d5b280b5a5ee7e8d2865d3a759930ab752
Message-ID: <5fe2a619.0swSWrbSHFwSLdrS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201222_210700_288926_56ABE54D 
X-CRM114-Status: GOOD (  10.86  )
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
branch HEAD: 8eb487d5b280b5a5ee7e8d2865d3a759930ab752  nvme-tcp: Fix possible race of io_work and direct send

elapsed time: 722m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
mips                             allyesconfig
m68k                        mvme147_defconfig
arm                            u300_defconfig
powerpc                     tqm8555_defconfig
arc                           tb10x_defconfig
xtensa                       common_defconfig
c6x                        evmc6474_defconfig
powerpc                        fsp2_defconfig
m68k                           sun3_defconfig
powerpc                     skiroot_defconfig
mips                     cu1000-neo_defconfig
sh                            titan_defconfig
mips                        bcm47xx_defconfig
sh                        dreamcast_defconfig
nios2                         3c120_defconfig
m68k                       m5475evb_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     taishan_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                          g5_defconfig
powerpc                     pseries_defconfig
arm                             ezx_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                            q40_defconfig
m68k                       m5208evb_defconfig
arm                           h5000_defconfig
arm                          pxa168_defconfig
powerpc                        icon_defconfig
powerpc                    ge_imp3a_defconfig
sh                               j2_defconfig
arm                           spitz_defconfig
arm                          badge4_defconfig
powerpc                     tqm8548_defconfig
powerpc                     mpc512x_defconfig
mips                           xway_defconfig
powerpc                      ppc64e_defconfig
arm                      pxa255-idp_defconfig
arm                           tegra_defconfig
arm                      integrator_defconfig
arm                         lpc18xx_defconfig
powerpc                    adder875_defconfig
sh                          r7780mp_defconfig
arc                    vdk_hs38_smp_defconfig
mips                      loongson3_defconfig
sh                            migor_defconfig
mips                      fuloong2e_defconfig
powerpc                       ebony_defconfig
arm                            dove_defconfig
sh                             espt_defconfig
arm                        realview_defconfig
s390                             alldefconfig
powerpc                 canyonlands_defconfig
mips                  cavium_octeon_defconfig
mips                     loongson1c_defconfig
um                             i386_defconfig
powerpc                     tqm8540_defconfig
arm                           viper_defconfig
openrisc                 simple_smp_defconfig
arm                  colibri_pxa300_defconfig
mips                           gcw0_defconfig
arm                         socfpga_defconfig
sh                        edosk7760_defconfig
powerpc                    mvme5100_defconfig
arm                       cns3420vb_defconfig
arm                             rpc_defconfig
arm                         palmz72_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     eseries_pxa_defconfig
mips                           mtx1_defconfig
m68k                       bvme6000_defconfig
sh                           sh2007_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201221
x86_64               randconfig-a006-20201221
x86_64               randconfig-a002-20201221
x86_64               randconfig-a004-20201221
x86_64               randconfig-a003-20201221
x86_64               randconfig-a005-20201221
i386                 randconfig-a005-20201222
i386                 randconfig-a002-20201222
i386                 randconfig-a006-20201222
i386                 randconfig-a004-20201222
i386                 randconfig-a003-20201222
i386                 randconfig-a001-20201222
i386                 randconfig-a002-20201221
i386                 randconfig-a005-20201221
i386                 randconfig-a006-20201221
i386                 randconfig-a004-20201221
i386                 randconfig-a003-20201221
i386                 randconfig-a001-20201221
i386                 randconfig-a011-20201221
i386                 randconfig-a016-20201221
i386                 randconfig-a014-20201221
i386                 randconfig-a012-20201221
i386                 randconfig-a015-20201221
i386                 randconfig-a013-20201221
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201221
x86_64               randconfig-a014-20201221
x86_64               randconfig-a016-20201221
x86_64               randconfig-a012-20201221
x86_64               randconfig-a013-20201221
x86_64               randconfig-a011-20201221
x86_64               randconfig-a001-20201222
x86_64               randconfig-a006-20201222
x86_64               randconfig-a002-20201222
x86_64               randconfig-a004-20201222
x86_64               randconfig-a003-20201222
x86_64               randconfig-a005-20201222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
