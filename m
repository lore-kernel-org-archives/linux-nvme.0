Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD78C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ARdHlkQETEEveU9ZxMED1NgGdtW86W5he/rKV9m4PoQ=; b=Mn/pe0zcg1Nv5l0goulhfBagkg
	KEIqiQ5Q2rHzgKMcUj4KuPAiz9M3Dwe3s8z77hF4fpIzWSMOTqnikRBeLG8KhnCx42N1SR8HfgIkF
	2DhxCRABLqatAc1SaoL6gyqwqGp7VH47vLJWTsEowfSKP5DCjemcXCLSvD6Tbd1ixQFT94pLJVfDg
	awkyFpas4+oSSPci4lZXK4kpAx4pI5TB/iYiSgGRc9aRYDrdzfNxOfMZeULYOVcf7OIxQ2MbSbbPt
	lf35JFXoKW05PeM0RrzNjOKszqDBKeOaR2rN1xWRhpXbJEP8/R88Ls/brIZMWKPx1xoYc3Urx+p+f
	6icRO4Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG2mJ-00GWmw-Gh; Mon, 25 Jul 2022 18:26:03 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG2mG-00GWk3-OD
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 18:26:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658773560; x=1690309560;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RcedpUJBrfRH7WgXN4kbwmHmVZAe8TKxkdNbOWX5tPI=;
  b=j8vPmKAI3ZGomldZ7yT9mZsK632X17CvGGDaIVDjzLPZXYS6O41Gsk5y
   rRRZfYSpp7N5EyP13gVIFZGOoRy3E9lTp4MCwqsAKWEafIcAJ3ODKd58h
   j6m9D/XZdAQV1Go1ePaIVsN47LZDPpSNJD9Up/2lONtdWBSA5jNe+A8Vw
   L0b5auXQGRBouuI8uyWw+N4q7AJ+OfiWTzFsBgm2XKS9PBc4mYUb1NLx1
   WP1yf4YV/vpJ9MyG4sloc8rJZ6x3RavyjkfFo/HnuSaBRb/EowCMb4I9X
   l/aGhpUVEdm9uWobXtmHk/ewNg/jGV/78sc38mQyleZ82B09GWKMqj8PU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="285315083"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="285315083"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 11:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575158440"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2022 11:25:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oG2mB-0005Pu-0L;
	Mon, 25 Jul 2022 18:25:55 +0000
Date: Tue, 26 Jul 2022 02:25:52 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.20] BUILD SUCCESS
 6d8fa0b046235b0af60124a340d1eaa156c97a04
Message-ID: <62dee030.5LRhqMEfe6fPYQ6a%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_112600_833050_9182B71C 
X-CRM114-Status: UNSURE (   8.10  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.20
branch HEAD: 6d8fa0b046235b0af60124a340d1eaa156c97a04  nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown

elapsed time: 724m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
powerpc              randconfig-c003-20220724
i386                          randconfig-c001
powerpc                 mpc85xx_cds_defconfig
parisc64                         alldefconfig
arm                           u8500_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
arm                         cm_x300_defconfig
powerpc                 mpc834x_itx_defconfig
arm                       imx_v6_v7_defconfig
arm                       aspeed_g5_defconfig
sh                      rts7751r2d1_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          lpd270_defconfig
sh                          sdk7786_defconfig
s390                             allmodconfig
sh                           se7780_defconfig
sh                          polaris_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
mips                         cobalt_defconfig
sh                     sh7710voipgw_defconfig
arm                        clps711x_defconfig
powerpc                    amigaone_defconfig
xtensa                generic_kc705_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
s390                 randconfig-r044-20220724
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     powernv_defconfig
mips                            e55_defconfig
arm                         hackkit_defconfig
mips                         tb0219_defconfig
arm                        mvebu_v5_defconfig
mips                   sb1250_swarm_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

