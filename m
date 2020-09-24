Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87204C4346E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 06:15:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C11235FD
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 06:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXMr5fAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C11235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oEq74Frc+db7gWTwo9XzXQUagI5C5Etw6agAVckTpoI=; b=bXMr5fAzJu80boRcxHen81wM4k
	c1t550xVMb8qGNFFSpXYT0dEGx0x2gvbMzeNpfnitGcq4bSni9VY6m0iICY/FwG3x1T+NQUdaCsAt
	EJbts/2w0xn3B1P/hjOES+N2Yx8Os2krexBDwdW5Xm2J7SHTTNJBb9Yww5DRRST5e9obRGKEx1kdw
	CHhhRNSP9XyG5LUsjBoa7Hn6TiD0mjbpLrlkDmz1nUu++YqFgkEdGEp5YOsPx0dgTT8iowyg4/n3x
	KED7DngVxbUmQDkRystlNCIkWOUjPju2TwFq/rj8HEtjLF5dB/MMtsQQmBH7APP1f1IenBol6/RY6
	hvrA57Ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLKXJ-0000Kr-LN; Thu, 24 Sep 2020 06:15:21 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLKXH-0000Jy-3f
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 06:15:20 +0000
IronPort-SDR: uklEMOh5rwn2z0kUZkDEEa91egX1eEE/+aThZ2uNqb5XC3vh2nsYwkqQrUopZLaHbbsLMEIRiO
 jWteo1rk9nbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="225251199"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; d="scan'208";a="225251199"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 23:15:17 -0700
IronPort-SDR: 6OxkL0gVncv/IG9S4qkdJOnNjQdKqUPrPraTsuKb/c4UVm38NGdfPZD7PNbXgSRETVStwe4jLv
 wm8yvqDBKuHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; d="scan'208";a="382927058"
Received: from lkp-server01.sh.intel.com (HELO 9f27196b5390) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 23 Sep 2020 23:15:16 -0700
Received: from kbuild by 9f27196b5390 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kLKXE-0000YT-05; Thu, 24 Sep 2020 06:15:16 +0000
Date: Thu, 24 Sep 2020 14:14:42 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.9] BUILD SUCCESS
 46d2613eae51d527ecaf0e8248a9bfcc0b92aa7e
Message-ID: <5f6c3952.n85+kszk8YzXyiCk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_021519_295255_3773C0E5 
X-CRM114-Status: GOOD (  12.47  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.9
branch HEAD: 46d2613eae51d527ecaf0e8248a9bfcc0b92aa7e  nvme-core: don't use NVME_NSID_ALL for command effects and supported log

elapsed time: 723m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                             pxa_defconfig
xtensa                         virt_defconfig
sh                          rsk7269_defconfig
arm                       imx_v6_v7_defconfig
arm                             rpc_defconfig
riscv                               defconfig
arm                       omap2plus_defconfig
powerpc                 mpc8540_ads_defconfig
ia64                          tiger_defconfig
mips                             allmodconfig
mips                    maltaup_xpa_defconfig
powerpc                      ppc40x_defconfig
powerpc                    sam440ep_defconfig
arm                         ebsa110_defconfig
powerpc                 mpc8313_rdb_defconfig
h8300                       h8s-sim_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
arm                       spear13xx_defconfig
arm                          simpad_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    ge_imp3a_defconfig
mips                          rm200_defconfig
csky                                defconfig
i386                                defconfig
arm                          lpd270_defconfig
sh                          rsk7264_defconfig
arm                        neponset_defconfig
powerpc                      makalu_defconfig
arm                       aspeed_g4_defconfig
arm                         axm55xx_defconfig
m68k                            q40_defconfig
sh                           se7712_defconfig
arm                           corgi_defconfig
mips                 pnx8335_stb225_defconfig
arc                     nsimosci_hs_defconfig
powerpc                    amigaone_defconfig
nios2                         10m50_defconfig
arm                         s3c6400_defconfig
mips                           rs90_defconfig
microblaze                    nommu_defconfig
sh                           se7206_defconfig
m68k                         apollo_defconfig
arc                            hsdk_defconfig
mips                          ath79_defconfig
arm                          imote2_defconfig
arm                           u8500_defconfig
powerpc                     sbc8548_defconfig
mips                       rbtx49xx_defconfig
sh                   rts7751r2dplus_defconfig
riscv                          rv32_defconfig
mips                  maltasmvp_eva_defconfig
arm                       cns3420vb_defconfig
arc                             nps_defconfig
arm                         orion5x_defconfig
mips                      malta_kvm_defconfig
arm                             mxs_defconfig
powerpc                      katmai_defconfig
openrisc                 simple_smp_defconfig
arm                          pxa910_defconfig
sh                      rts7751r2d1_defconfig
sh                        sh7757lcr_defconfig
riscv                             allnoconfig
c6x                              allyesconfig
sh                                  defconfig
mips                          ath25_defconfig
mips                        nlm_xlp_defconfig
sh                           se7721_defconfig
powerpc                     ep8248e_defconfig
powerpc                          g5_defconfig
powerpc                      acadia_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 mpc85xx_cds_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
x86_64               randconfig-a011-20200923
x86_64               randconfig-a013-20200923
x86_64               randconfig-a014-20200923
x86_64               randconfig-a015-20200923
x86_64               randconfig-a012-20200923
x86_64               randconfig-a016-20200923
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
i386                 randconfig-a012-20200924
i386                 randconfig-a014-20200924
i386                 randconfig-a016-20200924
i386                 randconfig-a013-20200924
i386                 randconfig-a011-20200924
i386                 randconfig-a015-20200924
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a006-20200923
x86_64               randconfig-a001-20200923
x86_64               randconfig-a011-20200924
x86_64               randconfig-a013-20200924
x86_64               randconfig-a014-20200924
x86_64               randconfig-a015-20200924
x86_64               randconfig-a012-20200924
x86_64               randconfig-a016-20200924

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
