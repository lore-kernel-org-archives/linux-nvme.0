Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40B0C77B73
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=REbCmEEgWRnkjZKV9HEWfIp3pVENfvFxycZJGgCQx+4=; b=u1HMzmu2i0HsTtR7pXj+g7jesG
	w24sRad3m+zDnxqfvEFgwt4HC3PBJFgXLkOuMyXmNS3oUMQnjOVfNCMPiTFoAyHdH4zMPMyNf5I6Z
	sshwIGmxwSo2MKALNrVIC+9HiEqJWdAfpUW3ydr8XVncNYsD60JLiuZdMPJJy81fY2v+5heEXyeOt
	kLIbluihQylvRWz4MtrNgsn3ixPLVYpxzPWAWDuV3IPVI44OEoVPAPaXEylDP2zTWqF7HPwnAJIu7
	Mnw4tzSbUQFXLgESfEMfRjRrTb8hk9wzlmHltgbbWbCHFHmN/Y9lpPthXbre10vHO+7sgCxBwJoPl
	uU/eSLzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3xpb-00Di0n-2I;
	Tue, 30 May 2023 11:48:03 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3xpW-00Dhz8-2X
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 11:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685447278; x=1716983278;
  h=date:from:to:cc:subject:message-id;
  bh=9s+f+gnJ49ZQ/4qNqg+eK+Nk7CZOBCHUTL8VwCT73dg=;
  b=HE7rtWsqf8kteaNyP3+x2YPdFnreHj0HAw+JN/+N8Ei+71ns73ABXzIj
   1BDt3e3qEfG1feCY2RpznucwTDHcErkpimmleouxcafXy9XtwMLfWa+V4
   gFWW54DXn9puj73H0xvowDjcPrQwGatxSaR/vD05eRBsgm5Ys/PAlht7Y
   mxpwOzrmFTAz5Je7chlazsWHbbPQejRfHbHFQ21fSfPxjW+5FvMBAPa71
   au5sAWBjftTbCxm3Ai41s2Bcq7reC8E0TZjCCBSq9VymxWb3dxE0ZT9Ig
   NxNKAA7glbujDJuEk3MSFK6vCwxbYv5x0ptmFBtRCPnlKqw94+ogviUOy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420650608"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="420650608"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="830724576"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="830724576"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 04:47:55 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q3xpT-0000DZ-0t;
	Tue, 30 May 2023 11:47:55 +0000
Date: Tue, 30 May 2023 19:47:38 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.4] BUILD SUCCESS
 dce8c22b9355d681c07be72c52c5dcc8d94a5d89
Message-ID: <20230530114738.uDUQy%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_044758_931117_49B1F095 
X-CRM114-Status: UNSURE (   5.41  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.4
branch HEAD: dce8c22b9355d681c07be72c52c5dcc8d94a5d89  NVMe: Add MAXIO 1602 to bogus nid list.

elapsed time: 6959m

configs tested: 716
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230529   gcc  
alpha        buildonly-randconfig-r004-20230525   gcc  
alpha        buildonly-randconfig-r005-20230529   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230526   gcc  
alpha                randconfig-r026-20230530   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc          buildonly-randconfig-r003-20230529   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r003-20230529   gcc  
arc                  randconfig-r005-20230529   gcc  
arc                  randconfig-r006-20230526   gcc  
arc                  randconfig-r024-20230529   gcc  
arc                  randconfig-r025-20230526   gcc  
arc                  randconfig-r031-20230530   gcc  
arc                  randconfig-r035-20230525   gcc  
arc                  randconfig-r043-20230525   gcc  
arc                  randconfig-r043-20230530   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                            hisi_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                          moxart_defconfig   clang
arm                        multi_v5_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                  randconfig-r011-20230525   clang
arm                  randconfig-r013-20230526   gcc  
arm                  randconfig-r021-20230525   clang
arm                  randconfig-r025-20230526   gcc  
arm                  randconfig-r046-20230529   clang
arm                             rpc_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r026-20230526   clang
arm64                randconfig-r033-20230526   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230526   gcc  
csky                 randconfig-r002-20230526   gcc  
csky                 randconfig-r003-20230525   gcc  
csky                 randconfig-r005-20230526   gcc  
csky                 randconfig-r006-20230526   gcc  
csky                 randconfig-r023-20230525   gcc  
csky                 randconfig-r023-20230526   gcc  
csky                 randconfig-r024-20230526   gcc  
csky                 randconfig-r025-20230526   gcc  
csky                 randconfig-r032-20230526   gcc  
csky                 randconfig-r032-20230530   gcc  
hexagon      buildonly-randconfig-r006-20230530   clang
hexagon              randconfig-r015-20230528   clang
hexagon              randconfig-r022-20230525   clang
hexagon              randconfig-r025-20230526   clang
hexagon              randconfig-r041-20230526   clang
hexagon              randconfig-r041-20230529   clang
hexagon              randconfig-r045-20230526   clang
hexagon              randconfig-r045-20230529   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230526   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230525   clang
i386                 randconfig-i001-20230526   gcc  
i386                 randconfig-i001-20230528   gcc  
i386                 randconfig-i001-20230529   clang
i386                 randconfig-i001-20230530   clang
i386                 randconfig-i002-20230525   clang
i386                 randconfig-i002-20230526   gcc  
i386                 randconfig-i002-20230528   gcc  
i386                 randconfig-i002-20230529   clang
i386                 randconfig-i002-20230530   clang
i386                 randconfig-i003-20230525   clang
i386                 randconfig-i003-20230526   gcc  
i386                 randconfig-i003-20230528   gcc  
i386                 randconfig-i003-20230529   clang
i386                 randconfig-i003-20230530   clang
i386                 randconfig-i004-20230525   clang
i386                 randconfig-i004-20230526   gcc  
i386                 randconfig-i004-20230528   gcc  
i386                 randconfig-i004-20230529   clang
i386                 randconfig-i004-20230530   clang
i386                 randconfig-i005-20230525   clang
i386                 randconfig-i005-20230526   gcc  
i386                 randconfig-i005-20230528   gcc  
i386                 randconfig-i005-20230529   clang
i386                 randconfig-i005-20230530   clang
i386                 randconfig-i006-20230525   clang
i386                 randconfig-i006-20230526   gcc  
i386                 randconfig-i006-20230528   gcc  
i386                 randconfig-i006-20230529   clang
i386                 randconfig-i006-20230530   clang
i386                 randconfig-i011-20230525   gcc  
i386                 randconfig-i011-20230526   clang
i386                 randconfig-i011-20230529   gcc  
i386                 randconfig-i011-20230530   gcc  
i386                 randconfig-i012-20230525   gcc  
i386                 randconfig-i012-20230526   clang
i386                 randconfig-i012-20230529   gcc  
i386                 randconfig-i012-20230530   gcc  
i386                 randconfig-i013-20230525   gcc  
i386                 randconfig-i013-20230526   clang
i386                 randconfig-i013-20230529   gcc  
i386                 randconfig-i013-20230530   gcc  
i386                 randconfig-i014-20230525   gcc  
i386                 randconfig-i014-20230526   clang
i386                 randconfig-i014-20230529   gcc  
i386                 randconfig-i014-20230530   gcc  
i386                 randconfig-i015-20230525   gcc  
i386                 randconfig-i015-20230526   clang
i386                 randconfig-i015-20230529   gcc  
i386                 randconfig-i015-20230530   gcc  
i386                 randconfig-i016-20230525   gcc  
i386                 randconfig-i016-20230526   clang
i386                 randconfig-i016-20230529   gcc  
i386                 randconfig-i016-20230530   gcc  
i386                 randconfig-i051-20230525   clang
i386                 randconfig-i051-20230526   gcc  
i386                 randconfig-i051-20230528   gcc  
i386                 randconfig-i051-20230529   clang
i386                 randconfig-i051-20230530   clang
i386                 randconfig-i052-20230525   clang
i386                 randconfig-i052-20230526   gcc  
i386                 randconfig-i052-20230528   gcc  
i386                 randconfig-i052-20230529   clang
i386                 randconfig-i052-20230530   clang
i386                 randconfig-i053-20230525   clang
i386                 randconfig-i053-20230526   gcc  
i386                 randconfig-i053-20230528   gcc  
i386                 randconfig-i053-20230529   clang
i386                 randconfig-i053-20230530   clang
i386                 randconfig-i054-20230525   clang
i386                 randconfig-i054-20230526   gcc  
i386                 randconfig-i054-20230528   gcc  
i386                 randconfig-i054-20230529   clang
i386                 randconfig-i054-20230530   clang
i386                 randconfig-i055-20230525   clang
i386                 randconfig-i055-20230526   gcc  
i386                 randconfig-i055-20230528   gcc  
i386                 randconfig-i055-20230529   clang
i386                 randconfig-i055-20230530   clang
i386                 randconfig-i056-20230525   clang
i386                 randconfig-i056-20230526   gcc  
i386                 randconfig-i056-20230528   gcc  
i386                 randconfig-i056-20230529   clang
i386                 randconfig-i056-20230530   clang
i386                 randconfig-i061-20230525   clang
i386                 randconfig-i061-20230526   gcc  
i386                 randconfig-i061-20230528   gcc  
i386                 randconfig-i061-20230529   clang
i386                 randconfig-i061-20230530   clang
i386                 randconfig-i062-20230525   clang
i386                 randconfig-i062-20230526   gcc  
i386                 randconfig-i062-20230528   gcc  
i386                 randconfig-i062-20230529   clang
i386                 randconfig-i062-20230530   clang
i386                 randconfig-i063-20230525   clang
i386                 randconfig-i063-20230526   gcc  
i386                 randconfig-i063-20230528   gcc  
i386                 randconfig-i063-20230529   clang
i386                 randconfig-i063-20230530   clang
i386                 randconfig-i064-20230525   clang
i386                 randconfig-i064-20230526   gcc  
i386                 randconfig-i064-20230528   gcc  
i386                 randconfig-i064-20230529   clang
i386                 randconfig-i064-20230530   clang
i386                 randconfig-i065-20230525   clang
i386                 randconfig-i065-20230526   gcc  
i386                 randconfig-i065-20230528   gcc  
i386                 randconfig-i065-20230529   clang
i386                 randconfig-i065-20230530   clang
i386                 randconfig-i066-20230525   clang
i386                 randconfig-i066-20230526   gcc  
i386                 randconfig-i066-20230528   gcc  
i386                 randconfig-i066-20230529   clang
i386                 randconfig-i066-20230530   clang
i386                 randconfig-i071-20230525   gcc  
i386                 randconfig-i071-20230526   clang
i386                 randconfig-i071-20230528   clang
i386                 randconfig-i071-20230529   gcc  
i386                 randconfig-i072-20230525   gcc  
i386                 randconfig-i072-20230526   clang
i386                 randconfig-i072-20230528   clang
i386                 randconfig-i072-20230529   gcc  
i386                 randconfig-i072-20230530   gcc  
i386                 randconfig-i073-20230525   gcc  
i386                 randconfig-i073-20230526   clang
i386                 randconfig-i073-20230528   clang
i386                 randconfig-i073-20230529   gcc  
i386                 randconfig-i074-20230525   gcc  
i386                 randconfig-i074-20230526   clang
i386                 randconfig-i074-20230528   clang
i386                 randconfig-i074-20230529   gcc  
i386                 randconfig-i074-20230530   gcc  
i386                 randconfig-i075-20230525   gcc  
i386                 randconfig-i075-20230526   clang
i386                 randconfig-i075-20230528   clang
i386                 randconfig-i075-20230529   gcc  
i386                 randconfig-i075-20230530   gcc  
i386                 randconfig-i076-20230525   gcc  
i386                 randconfig-i076-20230526   clang
i386                 randconfig-i076-20230528   clang
i386                 randconfig-i076-20230529   gcc  
i386                 randconfig-i076-20230530   gcc  
i386                 randconfig-i081-20230525   gcc  
i386                 randconfig-i081-20230526   clang
i386                 randconfig-i081-20230527   gcc  
i386                 randconfig-i081-20230528   clang
i386                 randconfig-i081-20230529   gcc  
i386                 randconfig-i082-20230525   gcc  
i386                 randconfig-i082-20230526   clang
i386                 randconfig-i082-20230527   gcc  
i386                 randconfig-i082-20230528   clang
i386                 randconfig-i082-20230529   gcc  
i386                 randconfig-i082-20230530   gcc  
i386                 randconfig-i083-20230525   gcc  
i386                 randconfig-i083-20230526   clang
i386                 randconfig-i083-20230527   gcc  
i386                 randconfig-i083-20230528   clang
i386                 randconfig-i083-20230529   gcc  
i386                 randconfig-i083-20230530   gcc  
i386                 randconfig-i084-20230525   gcc  
i386                 randconfig-i084-20230526   clang
i386                 randconfig-i084-20230527   gcc  
i386                 randconfig-i084-20230528   clang
i386                 randconfig-i084-20230529   gcc  
i386                 randconfig-i084-20230530   gcc  
i386                 randconfig-i085-20230525   gcc  
i386                 randconfig-i085-20230526   clang
i386                 randconfig-i085-20230527   gcc  
i386                 randconfig-i085-20230528   clang
i386                 randconfig-i085-20230529   gcc  
i386                 randconfig-i085-20230530   gcc  
i386                 randconfig-i086-20230525   gcc  
i386                 randconfig-i086-20230526   clang
i386                 randconfig-i086-20230527   gcc  
i386                 randconfig-i086-20230528   clang
i386                 randconfig-i086-20230529   gcc  
i386                 randconfig-i091-20230525   clang
i386                 randconfig-i091-20230526   gcc  
i386                 randconfig-i091-20230528   gcc  
i386                 randconfig-i091-20230529   clang
i386                 randconfig-i091-20230530   clang
i386                 randconfig-i092-20230525   clang
i386                 randconfig-i092-20230526   gcc  
i386                 randconfig-i092-20230528   gcc  
i386                 randconfig-i092-20230529   clang
i386                 randconfig-i092-20230530   clang
i386                 randconfig-i093-20230525   clang
i386                 randconfig-i093-20230526   gcc  
i386                 randconfig-i093-20230528   gcc  
i386                 randconfig-i093-20230529   clang
i386                 randconfig-i093-20230530   clang
i386                 randconfig-i094-20230525   clang
i386                 randconfig-i094-20230526   gcc  
i386                 randconfig-i094-20230528   gcc  
i386                 randconfig-i094-20230529   clang
i386                 randconfig-i094-20230530   clang
i386                 randconfig-i095-20230525   clang
i386                 randconfig-i095-20230526   gcc  
i386                 randconfig-i095-20230528   gcc  
i386                 randconfig-i095-20230529   clang
i386                 randconfig-i095-20230530   clang
i386                 randconfig-i096-20230525   clang
i386                 randconfig-i096-20230526   gcc  
i386                 randconfig-i096-20230528   gcc  
i386                 randconfig-i096-20230529   clang
i386                 randconfig-i096-20230530   clang
i386                 randconfig-r004-20230526   gcc  
i386                 randconfig-r024-20230530   gcc  
ia64                         bigsur_defconfig   gcc  
ia64                      gensparse_defconfig   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230526   gcc  
loongarch            randconfig-r021-20230526   gcc  
loongarch            randconfig-r036-20230526   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r002-20230529   gcc  
m68k                 randconfig-r004-20230525   gcc  
m68k                 randconfig-r005-20230526   gcc  
m68k                 randconfig-r013-20230529   gcc  
m68k                 randconfig-r014-20230526   gcc  
m68k                 randconfig-r026-20230525   gcc  
m68k                 randconfig-r032-20230525   gcc  
m68k                 randconfig-r035-20230530   gcc  
m68k                           virt_defconfig   gcc  
microblaze   buildonly-randconfig-r004-20230529   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r002-20230526   gcc  
microblaze           randconfig-r011-20230526   gcc  
microblaze           randconfig-r012-20230530   gcc  
microblaze           randconfig-r021-20230526   gcc  
microblaze           randconfig-r022-20230526   gcc  
microblaze           randconfig-r023-20230530   gcc  
microblaze           randconfig-r033-20230526   gcc  
microblaze           randconfig-r033-20230530   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                        bcm47xx_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                     loongson2k_defconfig   clang
mips                          malta_defconfig   clang
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r001-20230529   gcc  
mips                 randconfig-r015-20230525   clang
mips                          rb532_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2        buildonly-randconfig-r002-20230525   gcc  
nios2        buildonly-randconfig-r003-20230525   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230525   gcc  
nios2                randconfig-r005-20230526   gcc  
nios2                randconfig-r011-20230530   gcc  
nios2                randconfig-r012-20230529   gcc  
nios2                randconfig-r016-20230529   gcc  
nios2                randconfig-r022-20230526   gcc  
nios2                randconfig-r026-20230526   gcc  
nios2                randconfig-r031-20230526   gcc  
nios2                randconfig-r035-20230526   gcc  
openrisc             randconfig-r012-20230526   gcc  
openrisc             randconfig-r015-20230526   gcc  
openrisc             randconfig-r021-20230529   gcc  
openrisc             randconfig-r024-20230525   gcc  
openrisc             randconfig-r031-20230525   gcc  
openrisc             randconfig-r036-20230530   gcc  
openrisc                 simple_smp_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r003-20230526   gcc  
parisc               randconfig-r004-20230529   gcc  
parisc               randconfig-r005-20230525   gcc  
parisc               randconfig-r015-20230529   gcc  
parisc               randconfig-r032-20230526   gcc  
parisc               randconfig-r034-20230525   gcc  
parisc               randconfig-r036-20230526   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc      buildonly-randconfig-r004-20230526   clang
powerpc      buildonly-randconfig-r005-20230525   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                       eiger_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                      ppc64e_defconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r002-20230526   gcc  
powerpc              randconfig-r003-20230526   gcc  
powerpc              randconfig-r022-20230529   gcc  
powerpc              randconfig-r033-20230525   clang
powerpc                     sequoia_defconfig   gcc  
powerpc                    socrates_defconfig   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230525   gcc  
riscv                randconfig-r036-20230526   gcc  
riscv                randconfig-r042-20230525   gcc  
riscv                randconfig-r042-20230526   clang
riscv                randconfig-r042-20230530   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230526   clang
s390         buildonly-randconfig-r004-20230526   clang
s390                                defconfig   gcc  
s390                 randconfig-r003-20230526   gcc  
s390                 randconfig-r004-20230526   gcc  
s390                 randconfig-r013-20230530   gcc  
s390                 randconfig-r014-20230530   gcc  
s390                 randconfig-r023-20230529   gcc  
s390                 randconfig-r034-20230526   gcc  
s390                 randconfig-r044-20230525   gcc  
s390                 randconfig-r044-20230526   clang
s390                 randconfig-r044-20230530   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230526   gcc  
sh                        dreamcast_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r004-20230526   gcc  
sh                   randconfig-r012-20230526   gcc  
sh                   randconfig-r013-20230526   gcc  
sh                   randconfig-r014-20230526   gcc  
sh                   randconfig-r022-20230530   gcc  
sh                   randconfig-r026-20230526   gcc  
sh                   randconfig-r031-20230525   gcc  
sh                   randconfig-r034-20230526   gcc  
sh                   randconfig-r035-20230530   gcc  
sh                          rsk7264_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r001-20230526   gcc  
sparc        buildonly-randconfig-r003-20230526   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230526   gcc  
sparc                randconfig-r003-20230526   gcc  
sparc                randconfig-r013-20230526   gcc  
sparc                randconfig-r016-20230530   gcc  
sparc                randconfig-r024-20230526   gcc  
sparc                randconfig-r025-20230529   gcc  
sparc                randconfig-r026-20230529   gcc  
sparc                randconfig-r031-20230526   gcc  
sparc64              randconfig-r006-20230526   gcc  
sparc64              randconfig-r006-20230529   gcc  
sparc64              randconfig-r012-20230526   gcc  
sparc64              randconfig-r014-20230529   gcc  
sparc64              randconfig-r015-20230526   gcc  
sparc64              randconfig-r016-20230526   gcc  
sparc64              randconfig-r023-20230526   gcc  
sparc64              randconfig-r026-20230526   gcc  
sparc64              randconfig-r032-20230525   gcc  
sparc64              randconfig-r032-20230530   gcc  
sparc64              randconfig-r033-20230526   gcc  
sparc64              randconfig-r035-20230526   gcc  
sparc64              randconfig-r036-20230525   gcc  
um                               alldefconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230530   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230525   clang
x86_64               randconfig-a001-20230526   gcc  
x86_64               randconfig-a001-20230529   clang
x86_64               randconfig-a001-20230530   clang
x86_64               randconfig-a002-20230525   clang
x86_64               randconfig-a002-20230526   gcc  
x86_64               randconfig-a002-20230529   clang
x86_64               randconfig-a002-20230530   clang
x86_64               randconfig-a003-20230525   clang
x86_64               randconfig-a003-20230526   gcc  
x86_64               randconfig-a003-20230529   clang
x86_64               randconfig-a003-20230530   clang
x86_64               randconfig-a004-20230525   clang
x86_64               randconfig-a004-20230526   gcc  
x86_64               randconfig-a004-20230529   clang
x86_64               randconfig-a004-20230530   clang
x86_64               randconfig-a005-20230525   clang
x86_64               randconfig-a005-20230526   gcc  
x86_64               randconfig-a005-20230529   clang
x86_64               randconfig-a005-20230530   clang
x86_64               randconfig-a006-20230525   clang
x86_64               randconfig-a006-20230526   gcc  
x86_64               randconfig-a006-20230529   clang
x86_64               randconfig-a006-20230530   clang
x86_64               randconfig-a011-20230525   gcc  
x86_64               randconfig-a011-20230526   clang
x86_64               randconfig-a011-20230528   clang
x86_64               randconfig-a011-20230529   gcc  
x86_64               randconfig-a011-20230530   gcc  
x86_64               randconfig-a012-20230525   gcc  
x86_64               randconfig-a012-20230526   clang
x86_64               randconfig-a012-20230528   clang
x86_64               randconfig-a012-20230529   gcc  
x86_64               randconfig-a012-20230530   gcc  
x86_64               randconfig-a013-20230525   gcc  
x86_64               randconfig-a013-20230526   clang
x86_64               randconfig-a013-20230528   clang
x86_64               randconfig-a013-20230529   gcc  
x86_64               randconfig-a013-20230530   gcc  
x86_64               randconfig-a014-20230525   gcc  
x86_64               randconfig-a014-20230526   clang
x86_64               randconfig-a014-20230528   clang
x86_64               randconfig-a014-20230529   gcc  
x86_64               randconfig-a014-20230530   gcc  
x86_64               randconfig-a015-20230525   gcc  
x86_64               randconfig-a015-20230526   clang
x86_64               randconfig-a015-20230528   clang
x86_64               randconfig-a015-20230529   gcc  
x86_64               randconfig-a015-20230530   gcc  
x86_64               randconfig-a016-20230525   gcc  
x86_64               randconfig-a016-20230526   clang
x86_64               randconfig-a016-20230528   clang
x86_64               randconfig-a016-20230529   gcc  
x86_64               randconfig-a016-20230530   gcc  
x86_64               randconfig-k001-20230526   clang
x86_64               randconfig-k001-20230528   clang
x86_64               randconfig-r001-20230526   gcc  
x86_64               randconfig-r034-20230525   clang
x86_64               randconfig-x051-20230525   gcc  
x86_64               randconfig-x051-20230526   clang
x86_64               randconfig-x051-20230528   clang
x86_64               randconfig-x051-20230529   gcc  
x86_64               randconfig-x051-20230530   gcc  
x86_64               randconfig-x052-20230525   gcc  
x86_64               randconfig-x052-20230526   clang
x86_64               randconfig-x052-20230528   clang
x86_64               randconfig-x052-20230529   gcc  
x86_64               randconfig-x052-20230530   gcc  
x86_64               randconfig-x053-20230525   gcc  
x86_64               randconfig-x053-20230526   clang
x86_64               randconfig-x053-20230528   clang
x86_64               randconfig-x053-20230529   gcc  
x86_64               randconfig-x053-20230530   gcc  
x86_64               randconfig-x054-20230525   gcc  
x86_64               randconfig-x054-20230526   clang
x86_64               randconfig-x054-20230528   clang
x86_64               randconfig-x054-20230529   gcc  
x86_64               randconfig-x054-20230530   gcc  
x86_64               randconfig-x055-20230525   gcc  
x86_64               randconfig-x055-20230526   clang
x86_64               randconfig-x055-20230528   clang
x86_64               randconfig-x055-20230529   gcc  
x86_64               randconfig-x055-20230530   gcc  
x86_64               randconfig-x056-20230525   gcc  
x86_64               randconfig-x056-20230526   clang
x86_64               randconfig-x056-20230528   clang
x86_64               randconfig-x056-20230529   gcc  
x86_64               randconfig-x056-20230530   gcc  
x86_64               randconfig-x061-20230525   gcc  
x86_64               randconfig-x061-20230526   clang
x86_64               randconfig-x061-20230528   clang
x86_64               randconfig-x061-20230529   gcc  
x86_64               randconfig-x061-20230530   gcc  
x86_64               randconfig-x062-20230525   gcc  
x86_64               randconfig-x062-20230526   clang
x86_64               randconfig-x062-20230528   clang
x86_64               randconfig-x062-20230529   gcc  
x86_64               randconfig-x062-20230530   gcc  
x86_64               randconfig-x063-20230525   gcc  
x86_64               randconfig-x063-20230526   clang
x86_64               randconfig-x063-20230528   clang
x86_64               randconfig-x063-20230529   gcc  
x86_64               randconfig-x063-20230530   gcc  
x86_64               randconfig-x064-20230525   gcc  
x86_64               randconfig-x064-20230526   clang
x86_64               randconfig-x064-20230528   clang
x86_64               randconfig-x064-20230529   gcc  
x86_64               randconfig-x064-20230530   gcc  
x86_64               randconfig-x065-20230525   gcc  
x86_64               randconfig-x065-20230526   clang
x86_64               randconfig-x065-20230528   clang
x86_64               randconfig-x065-20230529   gcc  
x86_64               randconfig-x065-20230530   gcc  
x86_64               randconfig-x066-20230525   gcc  
x86_64               randconfig-x066-20230526   clang
x86_64               randconfig-x066-20230528   clang
x86_64               randconfig-x066-20230529   gcc  
x86_64               randconfig-x066-20230530   gcc  
x86_64               randconfig-x071-20230525   clang
x86_64               randconfig-x071-20230526   gcc  
x86_64               randconfig-x071-20230528   gcc  
x86_64               randconfig-x071-20230529   clang
x86_64               randconfig-x071-20230530   clang
x86_64               randconfig-x072-20230525   clang
x86_64               randconfig-x072-20230526   gcc  
x86_64               randconfig-x072-20230528   gcc  
x86_64               randconfig-x072-20230529   clang
x86_64               randconfig-x072-20230530   clang
x86_64               randconfig-x073-20230525   clang
x86_64               randconfig-x073-20230526   gcc  
x86_64               randconfig-x073-20230528   gcc  
x86_64               randconfig-x073-20230529   clang
x86_64               randconfig-x073-20230530   clang
x86_64               randconfig-x074-20230525   clang
x86_64               randconfig-x074-20230526   gcc  
x86_64               randconfig-x074-20230528   gcc  
x86_64               randconfig-x074-20230529   clang
x86_64               randconfig-x074-20230530   clang
x86_64               randconfig-x075-20230525   clang
x86_64               randconfig-x075-20230526   gcc  
x86_64               randconfig-x075-20230528   gcc  
x86_64               randconfig-x075-20230529   clang
x86_64               randconfig-x075-20230530   clang
x86_64               randconfig-x076-20230525   clang
x86_64               randconfig-x076-20230526   gcc  
x86_64               randconfig-x076-20230528   gcc  
x86_64               randconfig-x076-20230529   clang
x86_64               randconfig-x076-20230530   clang
x86_64               randconfig-x081-20230525   clang
x86_64               randconfig-x081-20230526   gcc  
x86_64               randconfig-x081-20230528   gcc  
x86_64               randconfig-x081-20230529   clang
x86_64               randconfig-x081-20230530   clang
x86_64               randconfig-x082-20230525   clang
x86_64               randconfig-x082-20230526   gcc  
x86_64               randconfig-x082-20230528   gcc  
x86_64               randconfig-x082-20230529   clang
x86_64               randconfig-x082-20230530   clang
x86_64               randconfig-x083-20230525   clang
x86_64               randconfig-x083-20230526   gcc  
x86_64               randconfig-x083-20230528   gcc  
x86_64               randconfig-x083-20230529   clang
x86_64               randconfig-x083-20230530   clang
x86_64               randconfig-x084-20230525   clang
x86_64               randconfig-x084-20230526   gcc  
x86_64               randconfig-x084-20230528   gcc  
x86_64               randconfig-x084-20230529   clang
x86_64               randconfig-x084-20230530   clang
x86_64               randconfig-x085-20230525   clang
x86_64               randconfig-x085-20230526   gcc  
x86_64               randconfig-x085-20230528   gcc  
x86_64               randconfig-x085-20230529   clang
x86_64               randconfig-x085-20230530   clang
x86_64               randconfig-x086-20230525   clang
x86_64               randconfig-x086-20230526   gcc  
x86_64               randconfig-x086-20230528   gcc  
x86_64               randconfig-x086-20230529   clang
x86_64               randconfig-x086-20230530   clang
x86_64               randconfig-x091-20230525   gcc  
x86_64               randconfig-x091-20230526   clang
x86_64               randconfig-x091-20230528   clang
x86_64               randconfig-x091-20230529   gcc  
x86_64               randconfig-x091-20230530   gcc  
x86_64               randconfig-x092-20230525   gcc  
x86_64               randconfig-x092-20230526   clang
x86_64               randconfig-x092-20230528   clang
x86_64               randconfig-x092-20230529   gcc  
x86_64               randconfig-x092-20230530   gcc  
x86_64               randconfig-x093-20230525   gcc  
x86_64               randconfig-x093-20230526   clang
x86_64               randconfig-x093-20230528   clang
x86_64               randconfig-x093-20230529   gcc  
x86_64               randconfig-x093-20230530   gcc  
x86_64               randconfig-x094-20230525   gcc  
x86_64               randconfig-x094-20230526   clang
x86_64               randconfig-x094-20230528   clang
x86_64               randconfig-x094-20230529   gcc  
x86_64               randconfig-x094-20230530   gcc  
x86_64               randconfig-x095-20230525   gcc  
x86_64               randconfig-x095-20230526   clang
x86_64               randconfig-x095-20230528   clang
x86_64               randconfig-x095-20230529   gcc  
x86_64               randconfig-x095-20230530   gcc  
x86_64               randconfig-x096-20230525   gcc  
x86_64               randconfig-x096-20230526   clang
x86_64               randconfig-x096-20230528   clang
x86_64               randconfig-x096-20230529   gcc  
x86_64               randconfig-x096-20230530   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r006-20230529   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa               randconfig-r006-20230526   gcc  
xtensa               randconfig-r011-20230526   gcc  
xtensa               randconfig-r011-20230529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

