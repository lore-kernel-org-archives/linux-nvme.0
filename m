Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9C5C4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 02:51:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1591823609
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 02:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1591823609
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L+CTU3ZB/ZxeTi8613GTqFvSD/zmL0Zj/j4VGZS4lss=; b=JzN8lnNMRIIkuvIv3Gj28k1UUO
	V9ILT3AovT+mtstAz0rsJBrwEIcsuvMSCXrtl2McpxxQi4Bg1QNKZCknpXEuxhahxHTZKSGJvfGV+
	kcwvKOeRNNfD0Ii+0JgKZE8Og/TLR0Cdg/m7gteiK3TjyVWGoVbXTr1Z5U1JkASh8uvJGNTQ1PW0+
	umzlXj8MNVVg7tU6vbc+f2CBdTVSStjb2ccNM3C/ruPcKrt5fXe5yBpEpxGjQh41PjaFQg8CiVVH1
	c+TA8WSls53O1cS5IXQwfQESNJVkA+675rmrjl2XdMlfx3z5TBf2BlfYgLcCnNj1S3tpt5H4hmJy7
	4XK5PBHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmT5z-0005TP-KL; Tue, 08 Dec 2020 02:51:19 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmT5w-0005T1-JN
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 02:51:17 +0000
IronPort-SDR: F9pRsjNw54NOir/GHxceyrid+Kvy0ogrYdsBZM6sxSxb8kAWqa+rEyoS3vwJIst3J+YL93Fug7
 AsNw9/W0AZig==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="161587373"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; d="scan'208";a="161587373"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2020 18:51:12 -0800
IronPort-SDR: x0RFMx8mxifL5ATnH6A61BWzpeyPemyz3Q1cguzbSuFLO91ZLjb7oJDa3p5VmdtDDt7KwDxVum
 sae03TawcfsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; d="scan'208";a="483469308"
Received: from lkp-server01.sh.intel.com (HELO 6c6df46aa5de) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 07 Dec 2020 18:51:10 -0800
Received: from kbuild by 6c6df46aa5de with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kmT5q-00002Z-9A; Tue, 08 Dec 2020 02:51:10 +0000
Date: Tue, 08 Dec 2020 10:50:23 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 bd784fbde2c74c870e8fd187efea10ce2f8fea89
Message-ID: <5fcee9ef.BuzXR1lDpPH1UUI8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_215116_780858_39004139 
X-CRM114-Status: UNSURE (   8.54  )
X-CRM114-Notice: Please train this message.
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
branch HEAD: bd784fbde2c74c870e8fd187efea10ce2f8fea89  nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from interrupt context

elapsed time: 721m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
powerpc                      walnut_defconfig
arm                         palmz72_defconfig
arm                          simpad_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      arches_defconfig
um                             i386_defconfig
arm                   milbeaut_m10v_defconfig
m68k                       bvme6000_defconfig
powerpc                  mpc885_ads_defconfig
mips                           ip28_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc832x_rdb_defconfig
c6x                         dsk6455_defconfig
m68k                        m5272c3_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     powernv_defconfig
m68k                        mvme16x_defconfig
arm                           tegra_defconfig
powerpc                     tqm8540_defconfig
sh                                  defconfig
powerpc                      pasemi_defconfig
arc                         haps_hs_defconfig
arm                        multi_v5_defconfig
mips                           ci20_defconfig
powerpc                      ep88xc_defconfig
mips                           xway_defconfig
arm                       omap2plus_defconfig
arm                         lpc18xx_defconfig
sh                          sdk7780_defconfig
m68k                       m5275evb_defconfig
mips                         tb0287_defconfig
m68k                             alldefconfig
arm                           omap1_defconfig
um                            kunit_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5475evb_defconfig
m68k                       m5249evb_defconfig
powerpc                     kilauea_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201207
i386                 randconfig-a004-20201207
i386                 randconfig-a001-20201207
i386                 randconfig-a002-20201207
i386                 randconfig-a006-20201207
i386                 randconfig-a003-20201207
x86_64               randconfig-a016-20201207
x86_64               randconfig-a012-20201207
x86_64               randconfig-a014-20201207
x86_64               randconfig-a013-20201207
x86_64               randconfig-a015-20201207
x86_64               randconfig-a011-20201207
i386                 randconfig-a014-20201207
i386                 randconfig-a013-20201207
i386                 randconfig-a011-20201207
i386                 randconfig-a015-20201207
i386                 randconfig-a012-20201207
i386                 randconfig-a016-20201207
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201207
x86_64               randconfig-a006-20201207
x86_64               randconfig-a002-20201207
x86_64               randconfig-a001-20201207
x86_64               randconfig-a005-20201207
x86_64               randconfig-a003-20201207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
