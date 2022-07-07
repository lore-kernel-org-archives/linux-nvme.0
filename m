Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C709C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jul 2022 06:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jUGeIXd5UnaLkSGX+wTseinsquiHdNfuHfhv4pLXmbA=; b=qWaiqI7yaGNR1AsEMPnW5e1+N6
	W5Gb7T9IzyKz41VlkufJRxGUEGqRRIwfO6aLJwlFRPgqvvtdyleDgiWJQQxGegYcO7eJyH1ijSh4j
	Fy6RytTB82PHZ8NMQOho2JdJWSgKMwplRLMzkXJkBptfxHn465zktjK3CCb68R4gRm911M6trBu1N
	PbzctDrg1oQmg7NNB2aImLThS5ItoB+3hTCuMGQcIxYL0BrrbuBCfeU1eFbYcatScqDvO2zLPIgYF
	derLzmT/bC0R8X1Eh3sYN/GuL6nRZmVZcLoTKppzqEIL6y/6otC0YiIXTSBGa6h9/NXVL4e8+mDpU
	rjRYVEsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Khi-00DsqI-9e; Thu, 07 Jul 2022 06:09:34 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Khe-00DsnB-SF
	for linux-nvme@lists.infradead.org; Thu, 07 Jul 2022 06:09:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657174170; x=1688710170;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bZCJf5GY79egFac6HxWRpfalX5iYXDxG5QJYtBHajH8=;
  b=VFfss1e7HPM7yRdRjMeDVECl7+NdZv3n1CWcUXuUQXjs7M0rFwVMZubb
   YryjZ4O1VBvfoQt+RmoBAUxFXjSzA5M6I6tR0Q19HH9yzlrLCmMJEAFS6
   Hk0Gtdo5YcKJ+y9LdLXo2sNqGqkEUyVS8TTcJz0B/jdQrVaWiET5P0nJv
   6UTtGQwxY47WwoOx6QOyOr7gc3gAx0A+eHzUKTUAf0TXcTnfHyGsdYYbI
   NEheJFXQGtLsGLpI2MVZ161Szi6b3mdV3wkM8NeayOzEDAA/fAj+fi6y8
   ukk1eFw9xDoSPKteY+vB6+ePQYtiE2gGOWf6ggTVenE3s0ocK2gauUDPq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="370257858"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="370257858"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 23:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="720400392"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2022 23:09:26 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o9Kha-000Le3-2U;
	Thu, 07 Jul 2022 06:09:26 +0000
Date: Thu, 07 Jul 2022 14:08:29 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 5c629dc9609dc43492a7bc8060cc6120875bf096
Message-ID: <62c6785d.PjBBnvuJnBqgO/ox%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_230930_989115_E369973F 
X-CRM114-Status: UNSURE (   6.37  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.19
branch HEAD: 5c629dc9609dc43492a7bc8060cc6120875bf096  nvme: use struct group for generic command dwords

elapsed time: 755m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                         wii_defconfig
m68k                       m5249evb_defconfig
sh                        apsh4ad0a_defconfig
arm                          lpd270_defconfig
arm                           viper_defconfig
arc                     nsimosci_hs_defconfig
arc                        nsimosci_defconfig
arm                          exynos_defconfig
s390                          debug_defconfig
powerpc                      cm5200_defconfig
arm                          simpad_defconfig
xtensa                           allyesconfig
sh                           se7721_defconfig
mips                           ip32_defconfig
sh                          lboxre2_defconfig
xtensa                  audio_kc705_defconfig
sh                            titan_defconfig
mips                  decstation_64_defconfig
powerpc                     mpc83xx_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         microdev_defconfig
nios2                         3c120_defconfig
powerpc                      pasemi_defconfig
arm                      jornada720_defconfig
arm                        mini2440_defconfig
arm                             rpc_defconfig
sh                           se7705_defconfig
sparc64                             defconfig
um                               alldefconfig
powerpc                       eiger_defconfig
mips                       capcella_defconfig
sh                           se7722_defconfig
alpha                               defconfig
nios2                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220706
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220706
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                      walnut_defconfig
arm                            dove_defconfig
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
riscv                randconfig-r042-20220706
hexagon              randconfig-r045-20220706
hexagon              randconfig-r041-20220706
s390                 randconfig-r044-20220706

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

