Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51891C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D3C239D4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z8z3+o/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D3C239D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jVopB+bA7y1VMps77XuvHxcCP2CuexwXscmm12Db6Ws=; b=z8z3+o/JanNMvwjsdne1QQSYuw
	2tILG9stk4OLlt2i5+cYu1OVWbDKYBPEdBiGLyty1Bk5B3YgLTkwx/n+pyUzRwbm4I4KB7riCU3RD
	ZckuC8NZ0BwwMDnvcZ97sd7YclmQXHueAcNJfSCBDLbHriiM5YnVQ5/mKp6zf7d4h8NEj2iYArF2g
	FD8r2Yn9SwMuMO5jG0gj+kAyvB/CR2A7bm3tzmN7EFBlqCjQ2OaKUd4wegv82QvRXt8ae0VUg9fGR
	2PFTzAfrgXE2GuGc1UyvZWzXNrBCImTm5U++OM/KKzJD+oiGyfsOmGsJyCIDkjvAG6H3c4f6lxkzJ
	XqD7uaQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKYbg-0005mb-25; Tue, 22 Sep 2020 03:04:40 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKYbc-0005lA-MN
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 03:04:38 +0000
IronPort-SDR: vMg3HMXmA/RGZl0eNbQ6Nw5CauekKm9vY4PfaLV0YfNN2u/SVjUdW6GFE32hEbQt0PbUza4fsh
 od5WHoOLmjdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="159810007"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="159810007"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 20:04:23 -0700
IronPort-SDR: E5piBVKPE0F7PlszxiibOFKbhI2TJedz2srPXonUy85HvtQtjdJcX7xEQAi0gCek8y7hcTO4vK
 YfrPAKhkZDlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="454313619"
Received: from lkp-server01.sh.intel.com (HELO 928d8e596b58) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 21 Sep 2020 20:04:22 -0700
Received: from kbuild by 928d8e596b58 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kKYbN-0000KI-Ht; Tue, 22 Sep 2020 03:04:21 +0000
Date: Tue, 22 Sep 2020 11:04:10 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.9] BUILD SUCCESS
 3b86a1dfbeb2d45a3a79daca43aa3a04771836e9
Message-ID: <5f6969aa.SOrIaj0zemDewB82%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_230437_009173_D68D8B33 
X-CRM114-Status: GOOD (  11.53  )
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
branch HEAD: 3b86a1dfbeb2d45a3a79daca43aa3a04771836e9  nvme-fc: fail new connections to a deleted host or remote port

elapsed time: 725m

configs tested: 155
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     eseries_pxa_defconfig
arm                            xcep_defconfig
powerpc                      acadia_defconfig
mips                 decstation_r4k_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      ep88xc_defconfig
powerpc                          g5_defconfig
sh                        apsh4ad0a_defconfig
arm                         orion5x_defconfig
xtensa                  cadence_csp_defconfig
c6x                        evmc6474_defconfig
h8300                       h8s-sim_defconfig
c6x                        evmc6457_defconfig
sh                               j2_defconfig
arm                          ep93xx_defconfig
arm                          tango4_defconfig
c6x                        evmc6472_defconfig
powerpc                     pq2fads_defconfig
m68k                            q40_defconfig
arm                      tct_hammer_defconfig
arc                            hsdk_defconfig
xtensa                          iss_defconfig
powerpc                  mpc866_ads_defconfig
arm                        clps711x_defconfig
ia64                            zx1_defconfig
arm                  colibri_pxa300_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
arc                        nsim_700_defconfig
sh                            hp6xx_defconfig
mips                  cavium_octeon_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7203_defconfig
arm                         s5pv210_defconfig
arm                       versatile_defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
powerpc                     tqm8540_defconfig
arm                          pxa910_defconfig
m68k                             alldefconfig
arm                            pleb_defconfig
arm                      footbridge_defconfig
x86_64                              defconfig
mips                        nlm_xlr_defconfig
m68k                         apollo_defconfig
sparc                       sparc64_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
mips                       bmips_be_defconfig
powerpc                     tqm8548_defconfig
parisc                           allyesconfig
arm                           sunxi_defconfig
powerpc                      makalu_defconfig
sh                        edosk7760_defconfig
powerpc                       eiger_defconfig
mips                        vocore2_defconfig
sh                     magicpanelr2_defconfig
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
x86_64               randconfig-a005-20200920
x86_64               randconfig-a003-20200920
x86_64               randconfig-a004-20200920
x86_64               randconfig-a002-20200920
x86_64               randconfig-a006-20200920
x86_64               randconfig-a001-20200920
i386                 randconfig-a002-20200921
i386                 randconfig-a006-20200921
i386                 randconfig-a003-20200921
i386                 randconfig-a004-20200921
i386                 randconfig-a005-20200921
i386                 randconfig-a001-20200921
i386                 randconfig-a002-20200920
i386                 randconfig-a006-20200920
i386                 randconfig-a003-20200920
i386                 randconfig-a004-20200920
i386                 randconfig-a005-20200920
i386                 randconfig-a001-20200920
x86_64               randconfig-a011-20200921
x86_64               randconfig-a013-20200921
x86_64               randconfig-a014-20200921
x86_64               randconfig-a015-20200921
x86_64               randconfig-a012-20200921
x86_64               randconfig-a016-20200921
i386                 randconfig-a012-20200921
i386                 randconfig-a014-20200921
i386                 randconfig-a016-20200921
i386                 randconfig-a013-20200921
i386                 randconfig-a011-20200921
i386                 randconfig-a015-20200921
i386                 randconfig-a012-20200920
i386                 randconfig-a014-20200920
i386                 randconfig-a016-20200920
i386                 randconfig-a013-20200920
i386                 randconfig-a011-20200920
i386                 randconfig-a015-20200920
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
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200921
x86_64               randconfig-a003-20200921
x86_64               randconfig-a004-20200921
x86_64               randconfig-a002-20200921
x86_64               randconfig-a006-20200921
x86_64               randconfig-a001-20200921
x86_64               randconfig-a011-20200920
x86_64               randconfig-a013-20200920
x86_64               randconfig-a014-20200920
x86_64               randconfig-a015-20200920
x86_64               randconfig-a012-20200920
x86_64               randconfig-a016-20200920

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
