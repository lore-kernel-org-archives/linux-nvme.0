Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD71CC4363A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 01:03:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1565A2076B
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 01:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1imK13Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1565A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m+dYCKTChDrmvwAj7+ELsu/bM202loAuRlkZTZcCExY=; b=1imK13Ru92eYQ8JOCb8zYMJxLn
	b7WewF2+iZUje3p9E1z9NH877v5dVBrZlXKeaWpCT4J8vaMr1uOpmxzm0hLmUhryzg3blLwvVwydD
	cl9ocbicgceUGiD7wq6qMR46cZMHlN51l6AKQb52r7pca0Bx8+aLfierDcjYhJJcoKj2h3Bir+0T+
	vpNOR9dIIgf1/Y5X6Av+Wm0fKT1b89Aoiei4Vhjl6511M8rYxc7P24YxjZbsg8PwsItjkmusj6A1P
	PjuNl5vkHTG5IUlZXiLTCWMMQsNRlTlaTAC9+tC8633V5MucMREQHEC7onsbAu3aPLfmNc0d9aWO5
	AZTL4HWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPbO3-0002A2-R9; Tue, 06 Oct 2020 01:03:27 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPbNy-000293-6b
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 01:03:23 +0000
IronPort-SDR: n6xz6SzmbVRGSEGhi7vDLeT81gnc82zHEuTCKj6Q400MPJJro6GuCQlAfGsNNoAWKt2E2hnAkB
 UxaitlsPvmdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="164442535"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; d="scan'208";a="164442535"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2020 18:03:13 -0700
IronPort-SDR: LdcpcpTR5vUV6CYFfDN/nNriCe8kIlUTVqwl1UO48c+jP2bbXGuOD5o3DC+pElr6SxP4dry9jf
 YfOkQ2/u8bxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; d="scan'208";a="310514444"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
 by orsmga003.jf.intel.com with ESMTP; 05 Oct 2020 18:03:10 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kPbNm-00011M-AD; Tue, 06 Oct 2020 01:03:10 +0000
Date: Tue, 06 Oct 2020 09:03:06 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 9ac37305a2e29615e695496feb73b4d7f935bcfc
Message-ID: <5f7bc24a.ls1qYLd6Ovik3ShA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_210322_404234_D07D8694 
X-CRM114-Status: GOOD (  12.49  )
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
branch HEAD: 9ac37305a2e29615e695496feb73b4d7f935bcfc  nvme-core: remove extra condition for vwc

elapsed time: 725m

configs tested: 187
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  maltasmvp_eva_defconfig
m68k                        mvme16x_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
powerpc                      acadia_defconfig
mips                       bmips_be_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      katmai_defconfig
mips                          ath79_defconfig
powerpc                     skiroot_defconfig
powerpc                     ksi8560_defconfig
mips                           ip28_defconfig
sh                   sh7724_generic_defconfig
m68k                          atari_defconfig
arc                            hsdk_defconfig
mips                        qi_lb60_defconfig
mips                      maltaaprp_defconfig
arm                        shmobile_defconfig
powerpc                    socrates_defconfig
mips                        jmr3927_defconfig
arm                         vf610m4_defconfig
arm                        neponset_defconfig
mips                           ip22_defconfig
arm                         cm_x300_defconfig
powerpc                      pasemi_defconfig
mips                      bmips_stb_defconfig
powerpc                      cm5200_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
arm                         axm55xx_defconfig
arm                          moxart_defconfig
mips                           xway_defconfig
sh                              ul2_defconfig
riscv                          rv32_defconfig
mips                         bigsur_defconfig
arm                           stm32_defconfig
arm                          iop32x_defconfig
arm                          tango4_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        nlm_xlp_defconfig
m68k                       m5475evb_defconfig
sh                         apsh4a3a_defconfig
mips                            ar7_defconfig
powerpc                        warp_defconfig
arm                        multi_v7_defconfig
sh                        edosk7705_defconfig
arm                        clps711x_defconfig
arm                            hisi_defconfig
i386                             alldefconfig
microblaze                          defconfig
powerpc                        icon_defconfig
m68k                          amiga_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     tqm8555_defconfig
ia64                         bigsur_defconfig
nds32                               defconfig
ia64                             allyesconfig
m68k                         apollo_defconfig
arm                        spear6xx_defconfig
sparc                               defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
sh                            titan_defconfig
arc                             nps_defconfig
sh                             shx3_defconfig
powerpc                      ppc44x_defconfig
arm                            zeus_defconfig
mips                         tb0219_defconfig
arm                        multi_v5_defconfig
xtensa                           alldefconfig
powerpc                         ps3_defconfig
powerpc                  mpc885_ads_defconfig
sh                          rsk7269_defconfig
m68k                            mac_defconfig
powerpc                     tqm8540_defconfig
h8300                            alldefconfig
arm                           corgi_defconfig
powerpc                      ep88xc_defconfig
arm                            pleb_defconfig
c6x                              alldefconfig
powerpc                      chrp32_defconfig
arm                         palmz72_defconfig
arm                          ixp4xx_defconfig
sh                           se7722_defconfig
sh                   secureedge5410_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      pcm030_defconfig
arm                        keystone_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
mips                       lemote2f_defconfig
arm                       mainstone_defconfig
arm                         bcm2835_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                        sh7763rdp_defconfig
sh                   rts7751r2dplus_defconfig
sh                          urquell_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
mips                         mpc30x_defconfig
arm                        spear3xx_defconfig
mips                          ath25_defconfig
powerpc                 canyonlands_defconfig
arm                             pxa_defconfig
sh                         ap325rxa_defconfig
powerpc                     powernv_defconfig
parisc                              defconfig
sh                               allmodconfig
mips                     loongson1c_defconfig
sh                          rsk7264_defconfig
powerpc                          allmodconfig
arm                           viper_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
i386                 randconfig-a014-20201004
i386                 randconfig-a015-20201004
i386                 randconfig-a013-20201004
i386                 randconfig-a016-20201004
i386                 randconfig-a011-20201004
i386                 randconfig-a012-20201004
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
