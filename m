Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE604C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:47:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7452064FB2
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7452064FB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ViMbOCGIKmrJ6QFyM8NraYx1Yk+3vM/n4VXKWU3Vfqo=; b=q/CS0v+2ooUl7A+FMJf8JrG5xk
	smm6+GWiqYJDzfe13Nuha/DPYxQ44/qwzOWOwIapI7F7EJFk2+twcOQWPX8LTEOFPhHjk7tdeXAIh
	GRWHLasEMXmXkkQEit4TNQ/pSBksE0I9cVTvxJBL7cRbGT6ZyaTsZ8h9r3qC8Khic2BYSAMrFpvx2
	7XOKmFdmXTiZ8YP4YDtuLlR4/ZtAb/F8qHSD6QIyC38IpAchyS/p33M8cuMG8BJgws3kERGqowm6t
	dl8mEyxvm7w6pOVjAzbGhJypTEMJcjnSZlsoki2+PH3IfWqUILV6EtVHnDb75uMx+AvkuXGUUaNsd
	vsamAyYA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHd57-007Nm7-D2; Thu, 04 Mar 2021 01:47:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZFR-006cq5-57
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 21:41:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=90bdcSI9+0B94eIuK90eHCZr2Za2aZ/5c2d1Be4AtJ8=; b=ZG2HgblwfMUtVvNENLid2l4WsS
 eYlHHQAt4xT+Gn/ga/pMql5G/nJQ4tmixMesGqEBJLM2w/L5l8rl7IVQ6Bbj7DQaKIDr7V18fvxOo
 e1UARtozwZSn4dI1wwQYVMUfqKi/UOaV9ZwB5aKGgnUAIJzk7I60iUyy5RNgPl8KXdLOLXg7v7ns9
 kFQQF/RHtsZcj4zaHAaBUny+R5iWp0jpeU4+oe17oDILxiMiM0MYKi94b0epAgyGpVWFuSMhWwDAo
 9wA1HoLA291wJa9Pw1S8BbKE4z4/9SV+QljzO0tmsmsWUhBY3I/mcbWwzXlJjAK8svR4MSMqZV9n9
 A4ncrwPQ==;
Received: from mga06.intel.com ([134.134.136.31])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZFM-004IBR-HN
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:41:35 +0000
IronPort-SDR: +YSLbapSKaMuu1buY/S/KGzDZpvlPkZsy2k4Q2i8FpTJdBNGIOCrQpYXzw0n0aQlf65hkRCCnK
 zKIhMJv1AmIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="248685955"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="248685955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 13:40:28 -0800
IronPort-SDR: H6QM8l341/bqfJezZfsEyVR0MYl1Nb9gM9h8oK2QoLHHKbiI8M1RTF89F0GF40pz7nuCbvxpo8
 oTnI1ZWRnrgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="399927196"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2021 13:40:27 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lHZEI-0001ln-TX; Wed, 03 Mar 2021 21:40:26 +0000
Date: Thu, 04 Mar 2021 05:39:39 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.12] BUILD SUCCESS
 8396290bd481a0e4da8dce4ac0f774595c6b898d
Message-ID: <6040021b.bDfzXFAQPHeEbb35%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_214134_906586_48AEBB32 
X-CRM114-Status: UNSURE (   7.43  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.12
branch HEAD: 8396290bd481a0e4da8dce4ac0f774595c6b898d  nvmet: model_number must be immutable once set

elapsed time: 722m

configs tested: 122
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         at91_dt_defconfig
powerpc                 mpc832x_mds_defconfig
sh                              ul2_defconfig
powerpc                       maple_defconfig
xtensa                         virt_defconfig
sh                          rsk7203_defconfig
csky                             alldefconfig
powerpc                  iss476-smp_defconfig
sh                      rts7751r2d1_defconfig
arm                        clps711x_defconfig
arc                            hsdk_defconfig
arm                         lpc32xx_defconfig
arc                     nsimosci_hs_defconfig
arm                       aspeed_g4_defconfig
mips                      fuloong2e_defconfig
x86_64                           alldefconfig
arm                   milbeaut_m10v_defconfig
powerpc                      acadia_defconfig
mips                     loongson1b_defconfig
arm                             mxs_defconfig
sh                        sh7763rdp_defconfig
riscv                            allmodconfig
mips                           ip27_defconfig
arm                            pleb_defconfig
ia64                        generic_defconfig
powerpc                         wii_defconfig
sh                           sh2007_defconfig
arm                        shmobile_defconfig
arm                          exynos_defconfig
microblaze                      mmu_defconfig
arm                        oxnas_v6_defconfig
nds32                             allnoconfig
mips                malta_kvm_guest_defconfig
ia64                                defconfig
arm                      footbridge_defconfig
alpha                            allyesconfig
powerpc                        cell_defconfig
arm                         orion5x_defconfig
arc                          axs101_defconfig
arm                          pxa3xx_defconfig
mips                     cu1830-neo_defconfig
arc                        vdk_hs38_defconfig
nds32                               defconfig
c6x                              allyesconfig
xtensa                           allyesconfig
sh                         ap325rxa_defconfig
powerpc                     ep8248e_defconfig
arm                        multi_v5_defconfig
arm                        trizeps4_defconfig
alpha                            alldefconfig
powerpc                  storcenter_defconfig
m68k                           sun3_defconfig
arm                          collie_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210303
i386                 randconfig-a003-20210303
i386                 randconfig-a002-20210303
i386                 randconfig-a004-20210303
i386                 randconfig-a006-20210303
i386                 randconfig-a001-20210303
x86_64               randconfig-a013-20210303
x86_64               randconfig-a016-20210303
x86_64               randconfig-a015-20210303
x86_64               randconfig-a014-20210303
x86_64               randconfig-a012-20210303
x86_64               randconfig-a011-20210303
i386                 randconfig-a016-20210303
i386                 randconfig-a012-20210303
i386                 randconfig-a014-20210303
i386                 randconfig-a013-20210303
i386                 randconfig-a011-20210303
i386                 randconfig-a015-20210303
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
