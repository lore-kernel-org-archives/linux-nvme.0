Return-Path: <SRS0=DVYa=NY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3619C432BE
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 03:39:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A3B610C9
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 03:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0A3B610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6i0bfPv3XtOzMYw1tv7mLmGGROERSEFcgknP5doPvnI=; b=V8c9KdhfP4gsR2
	VzIxY8HyjyQRsJVJbp/TnjsakaANONNCmjslchETabSme05fRMYHQ1f+jikz/884GTTFO/nIEyaMH
	NdVyKsQzvgCELffCDqLJ/IpVo0vLQgUqXDOrGhN+q4p6my2BjHmpjK7oCV72Cn+b2apr3zxuDchCm
	YNvnSO5JMeD44fZARpKpmD1oaFMN0rRDn4HzgEM8nGyd2K9Y1eTaV+S5iZBVl6DyV5vXgKwgDTDrG
	wqSjleBN21UnAC6uS2MsJPubu5uvAhB80KUCkEh+4Ec/8Cn3bri+TzWzD8oQ575OVnSx0ngrARNIx
	q7SEmkwgiWx2ustb7IUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLdZW-008MHn-Rl; Thu, 02 Sep 2021 03:39:26 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLdZP-008MH4-Cg
 for linux-nvme@lists.infradead.org; Thu, 02 Sep 2021 03:39:23 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="304522535"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; d="scan'208";a="304522535"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2021 20:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; d="scan'208";a="542323701"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2021 20:39:14 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mLdZJ-0008Z6-Je; Thu, 02 Sep 2021 03:39:13 +0000
Date: Thu, 02 Sep 2021 11:38:46 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 21526635405ffe709c05260faae6744273f4c3b0
Message-ID: <61304746.Ukxgonykyi7Yhf3Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_203919_505796_9604455B 
X-CRM114-Status: UNSURE (   8.42  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-5.15
branch HEAD: 21526635405ffe709c05260faae6744273f4c3b0  nvme-tcp: Do not reset transport on data digest errors

elapsed time: 724m

configs tested: 175
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210831
i386                 randconfig-c001-20210901
powerpc                 mpc8540_ads_defconfig
sh                          sdk7786_defconfig
arm                            xcep_defconfig
arm                          ep93xx_defconfig
xtensa                         virt_defconfig
riscv                            alldefconfig
m68k                          sun3x_defconfig
sh                            hp6xx_defconfig
s390                                defconfig
powerpc                    socrates_defconfig
powerpc64                           defconfig
sh                             shx3_defconfig
arm                           sunxi_defconfig
nds32                               defconfig
sh                          r7785rp_defconfig
xtensa                    smp_lx200_defconfig
mips                        vocore2_defconfig
powerpc                 linkstation_defconfig
sparc64                             defconfig
powerpc                     sequoia_defconfig
arm                         lpc18xx_defconfig
x86_64                           alldefconfig
arm                      integrator_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
sh                   sh7724_generic_defconfig
mips                           jazz_defconfig
arc                        nsimosci_defconfig
sh                          lboxre2_defconfig
arm                          moxart_defconfig
sh                        edosk7760_defconfig
arm                          pxa168_defconfig
sh                        edosk7705_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     kmeter1_defconfig
sh                        sh7785lcr_defconfig
mips                         cobalt_defconfig
arm                        trizeps4_defconfig
sh                          rsk7269_defconfig
mips                     decstation_defconfig
arm                           spitz_defconfig
powerpc                     tqm8540_defconfig
mips                            e55_defconfig
arm                            mps2_defconfig
sh                           se7750_defconfig
arm                       aspeed_g5_defconfig
sparc64                          alldefconfig
sh                           sh2007_defconfig
arm                     davinci_all_defconfig
powerpc                     tqm5200_defconfig
riscv                    nommu_virt_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
sh                              ul2_defconfig
powerpc                  mpc866_ads_defconfig
arm                           h3600_defconfig
arm                         s5pv210_defconfig
sh                           se7712_defconfig
powerpc                      bamboo_defconfig
alpha                               defconfig
ia64                             alldefconfig
powerpc                 mpc837x_rdb_defconfig
mips                           ip28_defconfig
mips                        omega2p_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210831
x86_64               randconfig-a001-20210831
x86_64               randconfig-a003-20210831
x86_64               randconfig-a002-20210831
x86_64               randconfig-a004-20210831
x86_64               randconfig-a006-20210831
i386                 randconfig-a005-20210831
i386                 randconfig-a002-20210831
i386                 randconfig-a003-20210831
i386                 randconfig-a006-20210831
i386                 randconfig-a004-20210831
i386                 randconfig-a001-20210831
x86_64               randconfig-a016-20210901
x86_64               randconfig-a011-20210901
x86_64               randconfig-a012-20210901
x86_64               randconfig-a015-20210901
x86_64               randconfig-a014-20210901
x86_64               randconfig-a013-20210901
riscv                randconfig-r042-20210901
s390                 randconfig-r044-20210901
arc                  randconfig-r043-20210901
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210901
mips                 randconfig-c004-20210901
x86_64               randconfig-c007-20210901
powerpc              randconfig-c003-20210901
i386                 randconfig-c001-20210901
arm                  randconfig-c002-20210901
riscv                randconfig-c006-20210901
i386                 randconfig-c001-20210831
s390                 randconfig-c005-20210831
riscv                randconfig-c006-20210831
powerpc              randconfig-c003-20210831
mips                 randconfig-c004-20210831
arm                  randconfig-c002-20210831
x86_64               randconfig-c007-20210831
x86_64               randconfig-a014-20210831
x86_64               randconfig-a015-20210831
x86_64               randconfig-a013-20210831
x86_64               randconfig-a016-20210831
x86_64               randconfig-a012-20210831
x86_64               randconfig-a011-20210831
x86_64               randconfig-a004-20210901
x86_64               randconfig-a006-20210901
x86_64               randconfig-a003-20210901
x86_64               randconfig-a005-20210901
x86_64               randconfig-a001-20210901
x86_64               randconfig-a002-20210901
i386                 randconfig-a016-20210831
i386                 randconfig-a011-20210831
i386                 randconfig-a015-20210831
i386                 randconfig-a014-20210831
i386                 randconfig-a012-20210831
i386                 randconfig-a013-20210831
hexagon              randconfig-r045-20210901
hexagon              randconfig-r041-20210901
s390                 randconfig-r044-20210831
hexagon              randconfig-r041-20210831
hexagon              randconfig-r045-20210831
riscv                randconfig-r042-20210831

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
