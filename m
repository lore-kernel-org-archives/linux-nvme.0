Return-Path: <SRS0=iyK+=NW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A2FC432BE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 00:46:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5251B60F6B
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 00:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5251B60F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=R6Mx7HEdlVHpkFbh3fuwVjKB3+/OtYLN+wdfjaLukW0=; b=nUOKnhUMIMqNVD
	+k40l87JdYiXprNiqlD4wMyyp/QBPg6H8NNf2Mb4V3qPQT2a9t7x95zfHbdiU6hmLbCKFmPgRfmfo
	wMVrRC6kbIEmqC2Hj2DFXydpJzWYNoTDrf/yuveDPECflxlJNJ7J2EELGQ3hqzJ+INdHTy7NhrehQ
	tVlJHcnAOzaRbrcbCaI1ML1lTfwHf2ZfP6oHfGW5cpkGtCoZK54S9eTBeJEawSGjIUCi8QHlSKcCG
	iUeu1BFyaMzGEu2vlfuyJDDS+gVwlXJOtc4Kn2UyxpIPY+lsEGO9uVurnYrTrzG0hGcbycIuvFQe0
	8mA9HVNUHYk3WXSxSVJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKrug-000uY5-VN; Tue, 31 Aug 2021 00:46:06 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKrua-000uXG-Bu
 for linux-nvme@lists.infradead.org; Tue, 31 Aug 2021 00:46:04 +0000
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218385573"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; d="scan'208";a="218385573"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2021 17:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; d="scan'208";a="689477638"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2021 17:45:52 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mKruS-0005eR-5G; Tue, 31 Aug 2021 00:45:52 +0000
Date: Tue, 31 Aug 2021 08:45:48 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.15] BUILD SUCCESS
 146686c928168d3cbcf7d237362e3776a316c000
Message-ID: <612d7bbc.wxwM5KN7uRV2WfUG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_174600_516256_9EF33E04 
X-CRM114-Status: UNSURE (   7.16  )
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
branch HEAD: 146686c928168d3cbcf7d237362e3776a316c000  nvmet: return bool from nvmet_passthru_ctrl and nvmet_is_passthru_req

elapsed time: 727m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210830
arm                          gemini_defconfig
powerpc64                           defconfig
powerpc                      arches_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                       m5275evb_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                      pmac32_defconfig
um                                  defconfig
arm                          collie_defconfig
powerpc                     tqm8541_defconfig
mips                          ath25_defconfig
arc                     nsimosci_hs_defconfig
arm                         nhk8815_defconfig
xtensa                         virt_defconfig
powerpc                     powernv_defconfig
sh                          sdk7786_defconfig
csky                                defconfig
arm                        neponset_defconfig
mips                         tb0219_defconfig
mips                           xway_defconfig
arm                          badge4_defconfig
mips                         cobalt_defconfig
sh                        edosk7705_defconfig
powerpc                     mpc5200_defconfig
sparc64                             defconfig
arm                        magician_defconfig
mips                        nlm_xlr_defconfig
mips                           ci20_defconfig
mips                            ar7_defconfig
ia64                        generic_defconfig
arm                          iop32x_defconfig
m68k                             alldefconfig
mips                     loongson2k_defconfig
mips                      fuloong2e_defconfig
powerpc                      bamboo_defconfig
arm                         s3c2410_defconfig
arm                           sunxi_defconfig
h8300                       h8s-sim_defconfig
sh                           se7724_defconfig
m68k                        m5407c3_defconfig
sh                         apsh4a3a_defconfig
powerpc                 mpc834x_mds_defconfig
mips                        vocore2_defconfig
nios2                         3c120_defconfig
m68k                            q40_defconfig
sh                           se7751_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                   sh7770_generic_defconfig
mips                         mpc30x_defconfig
arm                         bcm2835_defconfig
arm                       netwinder_defconfig
powerpc                     tqm8555_defconfig
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
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210830
x86_64               randconfig-a015-20210830
x86_64               randconfig-a013-20210830
x86_64               randconfig-a016-20210830
x86_64               randconfig-a012-20210830
x86_64               randconfig-a011-20210830
i386                 randconfig-a016-20210830
i386                 randconfig-a011-20210830
i386                 randconfig-a015-20210830
i386                 randconfig-a014-20210830
i386                 randconfig-a012-20210830
i386                 randconfig-a013-20210830
s390                 randconfig-r044-20210830
arc                  randconfig-r043-20210830
riscv                randconfig-r042-20210830
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
i386                 randconfig-c001-20210830
s390                 randconfig-c005-20210830
riscv                randconfig-c006-20210830
powerpc              randconfig-c003-20210830
mips                 randconfig-c004-20210830
arm                  randconfig-c002-20210830
x86_64               randconfig-c007-20210830
x86_64               randconfig-a005-20210830
x86_64               randconfig-a001-20210830
x86_64               randconfig-a003-20210830
x86_64               randconfig-a002-20210830
x86_64               randconfig-a004-20210830
x86_64               randconfig-a006-20210830
i386                 randconfig-a005-20210830
i386                 randconfig-a002-20210830
i386                 randconfig-a003-20210830
i386                 randconfig-a006-20210830
i386                 randconfig-a004-20210830
i386                 randconfig-a001-20210830
i386                 randconfig-a016-20210831
i386                 randconfig-a011-20210831
i386                 randconfig-a015-20210831
i386                 randconfig-a014-20210831
i386                 randconfig-a012-20210831
i386                 randconfig-a013-20210831
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
