Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9125EC64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 07:40:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15642221E9
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 07:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15642221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HA0nAADPZUS85+kVJtHQgtqv0oxqe4Q/XYKSS1f8E2A=; b=sWzIHQ5M5HQrV+/EUlFnJqlpC8
	Ug0x4XY+1iHmiItG3AHNk4KNmAfVLn4gNubmbuhjtiSXfES4zIA1SthiSDjkOMkui5J1OJ7RVmGNZ
	Hsydw8x7r8RiMdb9i8uAZo/sSEMcEzJK4ciGFjNbZ4DbfFIViLCro5LLi+N9cRtnhPdKLzputJQ/1
	sp2Sl/f48dn6R0p6k+k76NrHDc2ujcsiBV9GXVh1ta0QEsoUD2R7GcfJjzKUkJCWRzz7WupR3Ftg9
	eEN88xP6qzFNLKe3Av0wtTc8ChdfonWGk6k3TXwhmdJjh3TORly+GaAF+Mlu1ZWe1Jvl0T0K/sKbM
	4O0wIJdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkMk8-0007s2-FN; Wed, 02 Dec 2020 07:40:04 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkMk2-0007pt-2n
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 07:39:59 +0000
IronPort-SDR: E8WaZUenD2zPBJVOI3bTmu7zZuclNLipgeZpFzCwsEZ0xLKx+AZobsF+pTfdPxd5a4zqwcHt14
 a4jlYiLZgPWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="234574063"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; d="scan'208";a="234574063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2020 23:39:50 -0800
IronPort-SDR: EJ/TaqKZp4fP/SrO9tFOWtON0cpGoFZreiD7Gn4ahkYvf77x/Dl6hV6d7uKJOmDhQaB2y5Gdyd
 LKOUov9zXX3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; d="scan'208";a="481439990"
Received: from lkp-server01.sh.intel.com (HELO 54133fc185c3) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 01 Dec 2020 23:39:48 -0800
Received: from kbuild by 54133fc185c3 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kkMjr-00000b-Bv; Wed, 02 Dec 2020 07:39:47 +0000
Date: Wed, 02 Dec 2020 15:38:51 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 2f4c9ba23b887e7a69a474e9d53f38b5833a2119
Message-ID: <5fc7448b.TDWv6kct4cMP2OuY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_023958_261554_9E6027AE 
X-CRM114-Status: GOOD (  11.43  )
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
branch HEAD: 2f4c9ba23b887e7a69a474e9d53f38b5833a2119  nvme: export zoned namespaces without Zone Append support read-only

elapsed time: 720m

configs tested: 143
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        clps711x_defconfig
sh                        edosk7760_defconfig
powerpc                        cell_defconfig
mips                          ath79_defconfig
openrisc                         alldefconfig
sh                               j2_defconfig
mips                       capcella_defconfig
arm                           viper_defconfig
c6x                        evmc6474_defconfig
riscv                    nommu_k210_defconfig
arm                          pxa3xx_defconfig
c6x                        evmc6457_defconfig
m68k                            q40_defconfig
arc                        nsim_700_defconfig
arc                         haps_hs_defconfig
riscv                    nommu_virt_defconfig
mips                         tb0226_defconfig
arm                            dove_defconfig
m68k                        m5272c3_defconfig
sh                           se7705_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        realview_defconfig
microblaze                          defconfig
s390                       zfcpdump_defconfig
xtensa                generic_kc705_defconfig
ia64                                defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arc                        nsimosci_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm5200_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                         ap325rxa_defconfig
m68k                       m5475evb_defconfig
c6x                                 defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
mips                           ip22_defconfig
sparc                               defconfig
ia64                        generic_defconfig
sh                        dreamcast_defconfig
arm                            mps2_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc40x_defconfig
h8300                               defconfig
powerpc                      ppc44x_defconfig
arm                              alldefconfig
arm                          moxart_defconfig
powerpc                    amigaone_defconfig
mips                        maltaup_defconfig
arc                              alldefconfig
microblaze                      mmu_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    mvme5100_defconfig
sh                        apsh4ad0a_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          imote2_defconfig
mips                      fuloong2e_defconfig
sparc                       sparc64_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
powerpc                      pasemi_defconfig
powerpc                  storcenter_defconfig
parisc                generic-32bit_defconfig
mips                    maltaup_xpa_defconfig
mips                            e55_defconfig
mips                           xway_defconfig
xtensa                  audio_kc705_defconfig
powerpc                 canyonlands_defconfig
sh                            hp6xx_defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201201
i386                 randconfig-a005-20201201
i386                 randconfig-a001-20201201
i386                 randconfig-a002-20201201
i386                 randconfig-a006-20201201
i386                 randconfig-a003-20201201
x86_64               randconfig-a016-20201201
x86_64               randconfig-a012-20201201
x86_64               randconfig-a014-20201201
x86_64               randconfig-a013-20201201
x86_64               randconfig-a015-20201201
x86_64               randconfig-a011-20201201
i386                 randconfig-a014-20201201
i386                 randconfig-a013-20201201
i386                 randconfig-a011-20201201
i386                 randconfig-a015-20201201
i386                 randconfig-a012-20201201
i386                 randconfig-a016-20201201
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
x86_64               randconfig-a004-20201201
x86_64               randconfig-a006-20201201
x86_64               randconfig-a001-20201201
x86_64               randconfig-a002-20201201
x86_64               randconfig-a005-20201201
x86_64               randconfig-a003-20201201

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
