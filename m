Return-Path: <SRS0=SkPw=EU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B859C5519F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2020 21:04:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6E620A8B
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2020 21:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aNfmsMKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6E620A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/qlHD9Z7l0zTeJRwaqwWI9N9JNYDl1tAQRgphkdClnY=; b=aNfmsMKIpDNv/POWj779NezvIc
	AtkgmenNSS5lAWUY8N7aDVuB4rYhU+IwplwbTDkJe6Jmm+pzqaFojJ/DzZA+qA42nmkk4/IZPM0Cz
	CSOGcK4RnsKRSl0V8XScmI+a4+p5TRgCCi0S3EwkiiMWAddCe8cAXgaJKSwsgdGTwB1n9N6PU/aJS
	8lQE4+fB4pORE4/b6d2yE/ZJLAmfsT6jgUylc714JLFzJAAZn/EweM3KO2wg/iM85p+sLwvoCUw4J
	OOOUZ/Uzfw/+LI32ilPE8DxKhnab0ZbO/+gRYOjWCFRsYmYqMfkdckSBzj91sfaR4iXDPltMvv6Q4
	etYXBN+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ke2is-0000wk-Hj; Sat, 14 Nov 2020 21:04:38 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ke2in-0000wA-KQ
 for linux-nvme@lists.infradead.org; Sat, 14 Nov 2020 21:04:34 +0000
IronPort-SDR: kJlvfq0gXw5SFjOJo1W71gVqGouKCLf2fA/LhnXEbeu4ondaArgnNnKFG3nc/72eeP1L6t+ILp
 AhlJXmOatwlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="232216901"
X-IronPort-AV: E=Sophos;i="5.77,479,1596524400"; d="scan'208";a="232216901"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2020 13:04:32 -0800
IronPort-SDR: V5oS2Ya1Pd3AuCYThIe9dgqeBoN1LtZMaq8KOb246A187Z9v7MXJPGOPgPs2WaQwFQp8eLQLSU
 VXv+tis1pGSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,479,1596524400"; d="scan'208";a="329248639"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 14 Nov 2020 13:04:31 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1ke2ik-0000z7-I7; Sat, 14 Nov 2020 21:04:30 +0000
Date: Sun, 15 Nov 2020 05:03:52 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 8168d23fbcee4f9f6c5a1ce8650417f09aef70eb
Message-ID: <5fb04638.Vjs0POKdM6qfA1n9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201114_160433_857780_1953A7C9 
X-CRM114-Status: GOOD (  11.15  )
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
branch HEAD: 8168d23fbcee4f9f6c5a1ce8650417f09aef70eb  nvme: fix memory leak freeing command effects

elapsed time: 724m

configs tested: 112
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    sam440ep_defconfig
mips                             allyesconfig
h8300                    h8300h-sim_defconfig
sh                             shx3_defconfig
xtensa                              defconfig
powerpc                  iss476-smp_defconfig
powerpc                     sequoia_defconfig
powerpc                       eiger_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
m68k                                defconfig
arm                          gemini_defconfig
m68k                       m5249evb_defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
arm                           sunxi_defconfig
nds32                            alldefconfig
arm                       aspeed_g4_defconfig
arm                         assabet_defconfig
um                            kunit_defconfig
xtensa                         virt_defconfig
arm                        shmobile_defconfig
powerpc64                           defconfig
arm                           sama5_defconfig
mips                           ip32_defconfig
riscv                               defconfig
sh                          kfr2r09_defconfig
mips                     loongson1c_defconfig
arm                   milbeaut_m10v_defconfig
arm                           spitz_defconfig
mips                         tb0226_defconfig
m68k                        m5272c3_defconfig
ia64                          tiger_defconfig
arm                            xcep_defconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201114
x86_64               randconfig-a005-20201114
x86_64               randconfig-a004-20201114
x86_64               randconfig-a002-20201114
x86_64               randconfig-a001-20201114
x86_64               randconfig-a006-20201114
i386                 randconfig-a006-20201114
i386                 randconfig-a005-20201114
i386                 randconfig-a001-20201114
i386                 randconfig-a002-20201114
i386                 randconfig-a004-20201114
i386                 randconfig-a003-20201114
x86_64               randconfig-a015-20201113
x86_64               randconfig-a011-20201113
x86_64               randconfig-a014-20201113
x86_64               randconfig-a013-20201113
x86_64               randconfig-a016-20201113
x86_64               randconfig-a012-20201113
i386                 randconfig-a012-20201114
i386                 randconfig-a014-20201114
i386                 randconfig-a016-20201114
i386                 randconfig-a011-20201114
i386                 randconfig-a015-20201114
i386                 randconfig-a013-20201114
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201114
x86_64               randconfig-a011-20201114
x86_64               randconfig-a014-20201114
x86_64               randconfig-a013-20201114
x86_64               randconfig-a016-20201114
x86_64               randconfig-a012-20201114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
