Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A588C49361
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 02:09:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7A7613BA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 02:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7A7613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5QGzcz0h4XlO74vxr959NJtnvAs2MCR1mq685WTLucE=; b=HS+Es+ZPb5ccD3
	KiQwiqVaRxlU4li1190rPp0o7CCtYsniMqmI47tYNfiRpIbmy8pDzE28ERwxQWzXNaKxlnET+a7Sh
	LiTNn5ks2h7IL/WuZ+iA7tDiXewXP9GcPjjlY6RKJsw5WUSKs+rqSXs1oeGjnoYcVkAmvU2fOFbT2
	Vg89t0dPxHDXIQN57e98X6oDr7RQ73KInL9f8pbZjih4vwYsU/S6QLBvPzprBnvfqCGXfbn94JdLd
	2mr+xghz6vLBJfMg0duyRN7cCLlQ80QhEz4DdJUxfwxE9opxvDIJ0oydaBOgXSYzP0HlWQAFokrKJ
	vGAJcP+/G6XD6tyO0Xdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lu3ww-00CMnF-RA; Fri, 18 Jun 2021 02:09:38 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lu3wh-00CMmv-31
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 02:09:24 +0000
IronPort-SDR: aqiiVIVhHJ16ozV4D/C2Z5PthGGvrqM/PYcqYdO8tflG9lfoRhWJjdNqs9U5eutIhXfSv/pRfw
 6i8Jx4KXx1zg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206300826"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="206300826"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 19:09:21 -0700
IronPort-SDR: yawResPjUeUIxguoBdba6a5LaDqmUDuhi4QyVdARBqwuJw+ZCVHR+zn+m3Ceqtr3KZXB3aDz04
 VJbjlG5xmF7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="422069517"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 17 Jun 2021 19:09:19 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lu3wd-0002R4-AE; Fri, 18 Jun 2021 02:09:19 +0000
Date: Fri, 18 Jun 2021 10:08:35 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.14] BUILD SUCCESS
 8cf486e131b351db4f224078bef8e1efedcf0340
Message-ID: <60cc0023.a3gxG2NSPUI22eRV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210617_190923_208798_ED13F8CD 
X-CRM114-Status: UNSURE (   7.25  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.14
branch HEAD: 8cf486e131b351db4f224078bef8e1efedcf0340  nvme.h: add missing nvme_lba_range_type endianness annotations

elapsed time: 723m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7705_defconfig
arm                         s3c6400_defconfig
powerpc                      arches_defconfig
arm                          ep93xx_defconfig
um                            kunit_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
mips                      bmips_stb_defconfig
arm                        mini2440_defconfig
mips                        bcm63xx_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7203_defconfig
sh                         ap325rxa_defconfig
parisc                           alldefconfig
h8300                    h8300h-sim_defconfig
powerpc                 mpc834x_mds_defconfig
arm64                            alldefconfig
arm                        keystone_defconfig
riscv                          rv32_defconfig
arm                        trizeps4_defconfig
m68k                            q40_defconfig
arm                       aspeed_g5_defconfig
m68k                       m5249evb_defconfig
riscv                    nommu_virt_defconfig
arm                          lpd270_defconfig
arm                           sama5_defconfig
arm                            pleb_defconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
powerpc                      walnut_defconfig
arm                           h3600_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          pxa910_defconfig
mips                      maltasmvp_defconfig
arm                         hackkit_defconfig
sh                           se7206_defconfig
mips                           rs90_defconfig
powerpc                     tqm8555_defconfig
powerpc                     taishan_defconfig
sh                           se7750_defconfig
arc                            hsdk_defconfig
openrisc                 simple_smp_defconfig
arm                          moxart_defconfig
powerpc                     redwood_defconfig
powerpc                       ppc64_defconfig
powerpc                      chrp32_defconfig
mips                           ip28_defconfig
m68k                        mvme147_defconfig
mips                  decstation_64_defconfig
mips                        workpad_defconfig
mips                           gcw0_defconfig
arm                         lubbock_defconfig
arc                              alldefconfig
xtensa                       common_defconfig
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
csky                                defconfig
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
x86_64               randconfig-a004-20210617
x86_64               randconfig-a001-20210617
x86_64               randconfig-a002-20210617
x86_64               randconfig-a003-20210617
x86_64               randconfig-a006-20210617
x86_64               randconfig-a005-20210617
i386                 randconfig-a002-20210617
i386                 randconfig-a006-20210617
i386                 randconfig-a001-20210617
i386                 randconfig-a004-20210617
i386                 randconfig-a005-20210617
i386                 randconfig-a003-20210617
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210617
x86_64               randconfig-a015-20210617
x86_64               randconfig-a011-20210617
x86_64               randconfig-a014-20210617
x86_64               randconfig-a012-20210617
x86_64               randconfig-a013-20210617
x86_64               randconfig-a016-20210617

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
