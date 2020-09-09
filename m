Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E6EC43461
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 06:04:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545F9207DE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 06:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZK57qdxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545F9207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iJcR27u2Ek2WiUYLomT1OGva6H9Vh6ekgs8von3xcZ4=; b=ZK57qdxtlPDxtvXhdn9W2+MZMS
	yjsTPY/LUe/TtqprNM36uiXoMcb3tHUNkBvrHmPhXyk5XrIzB0yp7Zo9ziBUstjSRiodT678txMkZ
	0ILmUw+T5HRi80NC6OzJbr9hSIkGAkrs4Eem2Var4F/MgSM+2NJ+Xqxh6dOmRuFERmC12aE/GpJ8B
	9qeVkNYlbChOAAg5Kv/aUvSpwvHa5w0lGfYiwHdHguFom8V4yTaEwSjwusQDHrajxDiHv1iJHAa8b
	gYWOfpAfCA7XIVdrNvpEoeQjRUYJ0uFvCdyOHaItj2OjEArikN+aaViABt3GvKwlwbkGISaq63j/g
	getdp6dw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFtDB-0003sR-GU; Wed, 09 Sep 2020 06:04:05 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFtD8-0003s1-Hd
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 06:04:03 +0000
IronPort-SDR: 6CBt8gAN59Zu/CHPaEvPrynkOwKbHqA8ck6lrylqs3VN22ItxBbmNq9v+zB7aaub8Utv7UpW33
 e0caqLy61ulA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="137792397"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; d="scan'208";a="137792397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 23:04:00 -0700
IronPort-SDR: 2JWQWKa5kQKvgjiyljgsV5U81dsEBp/c5O4CTpDQOsw5sZFZeHcq+1HhSvjTGkyU/q6PMwyqSc
 xykfAFt0a7qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; d="scan'208";a="300042218"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 08 Sep 2020 23:03:59 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kFtD4-00003V-HC; Wed, 09 Sep 2020 06:03:58 +0000
Date: Wed, 09 Sep 2020 14:03:36 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.9] BUILD SUCCESS
 ceb1e0874dba5cbfc4e0b4145796a4bfb3716e6a
Message-ID: <5f587038.9l/TD//DrLF/PUTd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_020402_714823_C48BFB42 
X-CRM114-Status: GOOD (  11.05  )
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
branch HEAD: ceb1e0874dba5cbfc4e0b4145796a4bfb3716e6a  nvme-tcp: cancel async events before freeing event struct

elapsed time: 722m

configs tested: 160
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
mips                            ar7_defconfig
arm                           omap1_defconfig
sh                           se7619_defconfig
mips                           ip28_defconfig
mips                          malta_defconfig
powerpc                       holly_defconfig
arm                        mvebu_v7_defconfig
arc                     nsimosci_hs_defconfig
mips                malta_kvm_guest_defconfig
m68k                        m5407c3_defconfig
c6x                              allyesconfig
mips                            gpr_defconfig
sh                           se7780_defconfig
powerpc                           allnoconfig
m68k                       m5475evb_defconfig
mips                     decstation_defconfig
i386                                defconfig
h8300                    h8300h-sim_defconfig
arm                            zeus_defconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
arm                       spear13xx_defconfig
mips                         tb0287_defconfig
riscv                            alldefconfig
m68k                         amcore_defconfig
arm                           h5000_defconfig
sh                          lboxre2_defconfig
sh                   secureedge5410_defconfig
um                            kunit_defconfig
sh                           se7721_defconfig
riscv                            allmodconfig
arm                        spear6xx_defconfig
ia64                          tiger_defconfig
microblaze                      mmu_defconfig
powerpc                     mpc512x_defconfig
arm                          collie_defconfig
arm                         hackkit_defconfig
powerpc                 linkstation_defconfig
arm                      footbridge_defconfig
xtensa                              defconfig
nios2                         3c120_defconfig
arm                       aspeed_g5_defconfig
mips                           rs90_defconfig
mips                         rt305x_defconfig
arm                         s3c2410_defconfig
m68k                        stmark2_defconfig
h8300                            allyesconfig
sh                 kfr2r09-romimage_defconfig
sh                         microdev_defconfig
powerpc                  mpc885_ads_defconfig
sh                         apsh4a3a_defconfig
arc                          axs101_defconfig
sh                        apsh4ad0a_defconfig
c6x                        evmc6472_defconfig
riscv                          rv32_defconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20200908
i386                 randconfig-a005-20200908
i386                 randconfig-a006-20200908
i386                 randconfig-a002-20200908
i386                 randconfig-a001-20200908
i386                 randconfig-a003-20200908
i386                 randconfig-a004-20200907
i386                 randconfig-a005-20200907
i386                 randconfig-a006-20200907
i386                 randconfig-a002-20200907
i386                 randconfig-a003-20200907
i386                 randconfig-a001-20200907
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
x86_64               randconfig-a006-20200907
x86_64               randconfig-a004-20200907
x86_64               randconfig-a003-20200907
x86_64               randconfig-a005-20200907
x86_64               randconfig-a001-20200907
x86_64               randconfig-a002-20200907
x86_64               randconfig-a013-20200908
x86_64               randconfig-a016-20200908
x86_64               randconfig-a011-20200908
x86_64               randconfig-a012-20200908
x86_64               randconfig-a015-20200908
x86_64               randconfig-a014-20200908
i386                 randconfig-a016-20200907
i386                 randconfig-a015-20200907
i386                 randconfig-a011-20200907
i386                 randconfig-a013-20200907
i386                 randconfig-a014-20200907
i386                 randconfig-a012-20200907
i386                 randconfig-a016-20200908
i386                 randconfig-a015-20200908
i386                 randconfig-a011-20200908
i386                 randconfig-a013-20200908
i386                 randconfig-a014-20200908
i386                 randconfig-a012-20200908
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200908
x86_64               randconfig-a006-20200908
x86_64               randconfig-a003-20200908
x86_64               randconfig-a001-20200908
x86_64               randconfig-a005-20200908
x86_64               randconfig-a002-20200908
x86_64               randconfig-a013-20200909
x86_64               randconfig-a016-20200909
x86_64               randconfig-a011-20200909
x86_64               randconfig-a012-20200909
x86_64               randconfig-a015-20200909
x86_64               randconfig-a014-20200909

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
