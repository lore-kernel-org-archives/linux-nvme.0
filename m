Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90522C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 02:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2Onbgl16yPsw3SSzRsVHtanrJi/RK5KWHkRmwegPU+U=; b=d3ebrZwXOHOeqbo8rY8ZZMfeyG
	5BAFg41BPjwOHglTdRrRc8uK8e+/rr0LGAsTG70PmEHK23P2E442/7+VSnN5nq3/6e6wyjG6c3XcE
	OWtKGUpbNuZxhzOOIyFgpt83Wg5v5FGvtgffP04sVGu/rMvaBX3RX+vLQvHwiA++cby3E9qvjKDpj
	K9QtJtvHzwE6CrfDdX5cVhQZm4eHZb5KmvGXZhG5WpwZO4Ui5RRDAkOLhdKVoUQC43GnmhA1j1LDb
	O9DXI70uhfYG+vOnecDrFJfEUh/n5T4e9kBWNwUBKaH3bJvgPCYnMU19nOp8nnnx2+JjOi6Y4NW96
	T1vl+XbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUJ6Z-00BA8I-Qs; Wed, 16 Mar 2022 02:09:39 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUJ6W-00BA7b-Mq
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 02:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647396576; x=1678932576;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=bBJinwmEIVemOBMfixh83ll2pjraw3E2GERNL6IwKTg=;
 b=Q4RcHtCB9RPZR+Kge1SUt3oKHex3xuDsQYdGgTryMUmFUdTkKMipJWuC
 INWpgNSD9yjICfe9TKyYbS7c2CghmPOg0RjjxeXI3K2mUC25c714a36GM
 218Y7IHZEQeWszRJTKE6ss6pqSAaqcqg8hL2bS6rTGranHh+154oNO1Y3
 llDLtFGaj/cFZCvKaZ+jbZDI0/V6jxcw5beSnUOGpOSBQbdT1spbWY0B0
 K4/wdlnI/Yl/wnOGVsCYMX1dotjRwm/jLcb7tTpRP91JBGGyriQWHtTNU
 AF4b2mAEu2xQPWxXDEHLMtwEI3nQGwuZpizQdwP+DV5RO3eBX92EPy1F/ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255299907"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="255299907"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 19:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="690414105"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2022 19:09:34 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nUJ6U-000BnU-Aa; Wed, 16 Mar 2022 02:09:34 +0000
Date: Wed, 16 Mar 2022 10:08:57 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 da7837339641601f202f27515771dc0646083938
Message-ID: <623146b9.T+FKr9K/heTUQXE2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_190936_832530_20ACB4A7 
X-CRM114-Status: UNSURE (   7.98  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.18
branch HEAD: da7837339641601f202f27515771dc0646083938  nvmet: move the call to nvmet_ns_changed out of nvmet_ns_revalidate

elapsed time: 828m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220313
powerpc64                           defconfig
mips                  decstation_64_defconfig
h8300                    h8300h-sim_defconfig
arm                             pxa_defconfig
arc                         haps_hs_defconfig
arm                         axm55xx_defconfig
arm                        shmobile_defconfig
arm                          pxa910_defconfig
powerpc                      pcm030_defconfig
arm                           h5000_defconfig
arc                          axs103_defconfig
sh                          rsk7201_defconfig
nios2                            allyesconfig
powerpc                     tqm8548_defconfig
arm                  randconfig-c002-20220314
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a002-20220314
x86_64               randconfig-a001-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a005-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a003-20220314
i386                 randconfig-a005-20220314
i386                 randconfig-a006-20220314
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
arc                  randconfig-r043-20220314
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                   milbeaut_m10v_defconfig
mips                      maltaaprp_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8313_rdb_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a011-20220314
x86_64               randconfig-a014-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a015-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220313
hexagon              randconfig-r045-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314
riscv                randconfig-r042-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

