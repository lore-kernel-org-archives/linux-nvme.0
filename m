Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D64C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 08:02:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CD820706
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 08:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CD820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TD5AcH4/L/us1q/LEtw33MJLzed4kcf/1CmnfE9kg2s=; b=fFG9xXVoviHTQY2jrbd9g3K6gp
	4fPpbexh2jci2o4KxT7HMm1OayJ/LW2OmXIYQWhcDmlArwLWYzKrq9x8Fz/7zlkTJjtsXVz2uFb2m
	L5eUqSaTyz00i2g9J7L9mBsJm0Im2vgH91Bp8yiJmzxtCoML6VKZF664kMW9ugxaUmPXCxaNj+FOL
	oRAlRn/t/SL+MEujB2L+DN0Qugf+EKJR3h5qzupdPJfCaHTunQYmMd4p9nYTgmjoVm/6jPOOQiwog
	RLMupoiXMaAfrb2+CQ690bZXW4877a4TzlhD952aTpayvMMzSN98QaBEDjcPQv1rjJ9tqY74CLicE
	2vcSFG9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0K48-0003i4-HB; Fri, 15 Jan 2021 08:02:40 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0K46-0003hd-1B
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 08:02:39 +0000
IronPort-SDR: 7ANn62p44IbytjjcNMo/IzFyIOshi9AN7OnDEGnRFsr3rsmGQ6OoiMj/8BJPDfEpSb4Cxo7KQX
 giyWSD2M4DZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177735785"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="177735785"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2021 00:02:33 -0800
IronPort-SDR: /34ZsSyhD/1VIIEDMIV1c8LwHm0lg/kD0wUPGAs6+Lcb9c3pq6RXBIXxotYhvYrHoc6swChV0T
 2FRdtoswJPRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="390043848"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 15 Jan 2021 00:02:30 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l0K3y-0000Fo-2Q; Fri, 15 Jan 2021 08:02:30 +0000
Date: Fri, 15 Jan 2021 16:01:33 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 94900716af1770eb3067ab8210d90c0af67e0694
Message-ID: <60014bdd.3hkK6FWLm2EaFucf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_030238_250051_FA38337D 
X-CRM114-Status: UNSURE (   8.88  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.11
branch HEAD: 94900716af1770eb3067ab8210d90c0af67e0694  nvme: don't intialize hwmon for discovery controllers

elapsed time: 728m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
powerpc                  iss476-smp_defconfig
mips                           gcw0_defconfig
openrisc                         alldefconfig
arm                        multi_v5_defconfig
sh                            migor_defconfig
powerpc                      ppc44x_defconfig
arc                        nsimosci_defconfig
ia64                             allmodconfig
mips                      bmips_stb_defconfig
powerpc                      ppc6xx_defconfig
arm                             ezx_defconfig
powerpc                     mpc5200_defconfig
mips                        workpad_defconfig
mips                  decstation_64_defconfig
arm                          pxa168_defconfig
powerpc                      cm5200_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     sbc8548_defconfig
mips                           ci20_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
parisc                generic-32bit_defconfig
sh                     sh7710voipgw_defconfig
mips                        nlm_xlp_defconfig
mips                   sb1250_swarm_defconfig
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
i386                 randconfig-a002-20210114
i386                 randconfig-a005-20210114
i386                 randconfig-a006-20210114
i386                 randconfig-a001-20210114
i386                 randconfig-a003-20210114
i386                 randconfig-a004-20210114
x86_64               randconfig-a015-20210114
x86_64               randconfig-a012-20210114
x86_64               randconfig-a013-20210114
x86_64               randconfig-a016-20210114
x86_64               randconfig-a014-20210114
x86_64               randconfig-a011-20210114
i386                 randconfig-a012-20210114
i386                 randconfig-a011-20210114
i386                 randconfig-a016-20210114
i386                 randconfig-a015-20210114
i386                 randconfig-a013-20210114
i386                 randconfig-a014-20210114
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210114
x86_64               randconfig-a006-20210114
x86_64               randconfig-a001-20210114
x86_64               randconfig-a003-20210114
x86_64               randconfig-a005-20210114
x86_64               randconfig-a002-20210114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
