Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE101C433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 18:20:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056AF2078E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 18:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1cNmDv0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056AF2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3zQNQz8kxHL0bQ1QY2dre0taYjvN+Mq9WE6sD4pjukU=; b=1cNmDv0MRLTSxh6NWJY8yBfEf7
	8VrVFoyVKV6rKRcAagFcpyaItm+ss1Qne6O59uCBagLScx96xDsA+a36iRia0z+1J0pU8M6GltNXA
	Fks388Rp1qmhqA7lzoXTlfhkVVNPCqs8/IWnyeWyW5R5T50aBPqaNA9uQCMSEipSu1Zv4EOEvaIch
	bghmIl5LEp/fq/PEagoAbOoHfDBJt3NwF0S+WZv6FvCFgur9I14zNlVbzMqmZLJwGm8GiU4AF+8yz
	7vWLSzVKgo9f87nQdyRFWD0st8I8XHKyQnPQ7Un+B38MeF19q8K2pwcz3F/0tc82ZbYxmrzPLDMOF
	lRfen9gA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kG4hw-000892-Ui; Wed, 09 Sep 2020 18:20:36 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG4ht-00088C-E5
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 18:20:34 +0000
IronPort-SDR: yEKsEokDOZfCCDUqKZFp26w3934qRr5yXbytsSzSjGdLqTK2DfaXyMXRGsi1ASX7nLXtxA8CsO
 sU655ERGJpNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="243208664"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; d="scan'208";a="243208664"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2020 11:20:28 -0700
IronPort-SDR: 6QvF9VbvKonBHJVNXXuSAQBcO1f3gJ70JZB/btNyL1wQbMQjLLYwOR/yraqxAmof7RBWo08chK
 kuP4DKhyN8CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; d="scan'208";a="480565791"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 09 Sep 2020 11:20:27 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kG4hm-0000Y5-PP; Wed, 09 Sep 2020 18:20:26 +0000
Date: Thu, 10 Sep 2020 02:19:35 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.9] BUILD SUCCESS
 73a5379937ec89b91e907bb315e2434ee9696a2c
Message-ID: <5f591cb7.eR0DZMn9xaq8l1vt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_142033_613972_4BE6C1A3 
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.9
branch HEAD: 73a5379937ec89b91e907bb315e2434ee9696a2c  nvme-fabrics: allow to queue requests for live queues

elapsed time: 722m

configs tested: 137
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
sh                   sh7724_generic_defconfig
c6x                              allyesconfig
arm                          simpad_defconfig
arm                         shannon_defconfig
sh                          rsk7269_defconfig
sh                             sh03_defconfig
arm                            lart_defconfig
parisc                generic-32bit_defconfig
mips                           ci20_defconfig
h8300                       h8s-sim_defconfig
mips                      fuloong2e_defconfig
sh                         apsh4a3a_defconfig
arm                      footbridge_defconfig
sh                         ecovec24_defconfig
c6x                        evmc6678_defconfig
c6x                        evmc6472_defconfig
i386                             allyesconfig
arm                        vexpress_defconfig
arm                            zeus_defconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
arm                       spear13xx_defconfig
arm                         lpc18xx_defconfig
mips                           jazz_defconfig
m68k                       m5249evb_defconfig
arm                         assabet_defconfig
arm                            dove_defconfig
openrisc                         alldefconfig
c6x                         dsk6455_defconfig
mips                 decstation_r4k_defconfig
m68k                         apollo_defconfig
sparc64                             defconfig
riscv                    nommu_virt_defconfig
s390                             alldefconfig
mips                         bigsur_defconfig
mips                      loongson3_defconfig
s390                                defconfig
m68k                                defconfig
mips                          rm200_defconfig
powerpc                          alldefconfig
sh                  sh7785lcr_32bit_defconfig
sh                   rts7751r2dplus_defconfig
arm                    vt8500_v6_v7_defconfig
arm                  colibri_pxa300_defconfig
xtensa                generic_kc705_defconfig
arm                         s3c2410_defconfig
um                            kunit_defconfig
arm                        shmobile_defconfig
arm64                            alldefconfig
mips                           rs90_defconfig
mips                          ath25_defconfig
m68k                        stmark2_defconfig
nios2                         3c120_defconfig
arm                       aspeed_g5_defconfig
arm                         hackkit_defconfig
nds32                               defconfig
arm                      tct_hammer_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
powerpc                  mpc885_ads_defconfig
mips                           ip28_defconfig
sparc                               defconfig
arm                         s5pv210_defconfig
h8300                               defconfig
mips                malta_kvm_guest_defconfig
powerpc                          allyesconfig
arm                        magician_defconfig
m68k                            mac_defconfig
xtensa                       common_defconfig
sh                           se7206_defconfig
xtensa                    xip_kc705_defconfig
mips                          rb532_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20200909
x86_64               randconfig-a006-20200909
x86_64               randconfig-a003-20200909
x86_64               randconfig-a001-20200909
x86_64               randconfig-a005-20200909
x86_64               randconfig-a002-20200909
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
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
