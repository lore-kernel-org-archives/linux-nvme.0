Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF27C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 23:04:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2CB64F89
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 23:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2CB64F89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1o+0nbXIh9Q+8eqqeNWMglS7YsSNySIHq1UpzG7p+4I=; b=OM+oynBEA3MFhWXVY5JMX8yMMz
	z70AkWEzWKTW/tkMUfNp22sGaRVF0ax0AT/9zld4PEL7ctpKr82V1bK7S37Tl8NgFkad3MNWkEMzK
	DRXApV5f62MuXb9Neo4Vi0gSzvzIGXYgYtumRSAZjbMLHtX8ZUamzYEkWAP+nHHlx528miPl4DiRj
	X1phVfDApmh7RFf3PEsp+gqf0mqFeSDc1abaMTGaYFapca4kw/EycYr9J/VpbtTbPblXVAGcZqbb7
	0YC6+TjjvoFmj26U1N1MfQ5vEU4MQlzQNnvzX8r7kAfk6uWwPwFMyQBHbdoq7BkOCXk++Uw5S7mRw
	IkdzBaDg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKULN-00ACHe-4s; Thu, 11 Mar 2021 23:03:49 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKULE-00ACHD-89
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 23:03:43 +0000
IronPort-SDR: TalBqerbz1NMc1naCbdgtaYj+3ZvW6q1MRVmYfkEDsQzjFyKOngyBbdOITuN89664CgYC0QChH
 qhkvDL0T+VLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188118229"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; d="scan'208";a="188118229"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2021 15:03:32 -0800
IronPort-SDR: nE8FJ00HMrNNekaxzstj4RhaSA50QxAESfFK0MMSZVJUgwB5gf8I8nliQkZf5VN8kkQpX5++3N
 cUmZuMVU9AcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; d="scan'208";a="521241722"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 11 Mar 2021 15:03:31 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lKUL4-00010v-Ce; Thu, 11 Mar 2021 23:03:30 +0000
Date: Fri, 12 Mar 2021 07:02:51 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.12] BUILD SUCCESS
 abbb5f5929ec6c52574c430c5475c158a65c2a8c
Message-ID: <604aa19b.YMHPlFxhR70qgMyb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_230340_814508_2E0C4FA6 
X-CRM114-Status: UNSURE (   6.52  )
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
branch HEAD: abbb5f5929ec6c52574c430c5475c158a65c2a8c  nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a Samsung PM1725a

elapsed time: 727m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
mips                        qi_lb60_defconfig
powerpc                     tqm8555_defconfig
openrisc                 simple_smp_defconfig
sh                   sh7724_generic_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                       holly_defconfig
mips                       rbtx49xx_defconfig
mips                         tb0226_defconfig
powerpc                     tqm8560_defconfig
powerpc                    ge_imp3a_defconfig
sh                             sh03_defconfig
arm                             mxs_defconfig
sh                        dreamcast_defconfig
arm                          ixp4xx_defconfig
h8300                               defconfig
powerpc                     tqm8541_defconfig
arc                      axs103_smp_defconfig
ia64                                defconfig
powerpc                     sequoia_defconfig
h8300                            alldefconfig
mips                 decstation_r4k_defconfig
arc                          axs101_defconfig
m68k                         apollo_defconfig
arm                         lpc32xx_defconfig
m68k                          multi_defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
arc                     haps_hs_smp_defconfig
um                           x86_64_defconfig
s390                             alldefconfig
h8300                    h8300h-sim_defconfig
mips                        workpad_defconfig
openrisc                            defconfig
arm                     am200epdkit_defconfig
xtensa                         virt_defconfig
sh                           se7712_defconfig
powerpc                      bamboo_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                       lemote2f_defconfig
arm                          imote2_defconfig
powerpc                      pcm030_defconfig
mips                           ip27_defconfig
powerpc                       ebony_defconfig
sh                          sdk7786_defconfig
powerpc                     asp8347_defconfig
ia64                         bigsur_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
mips                           rs90_defconfig
arm                        mini2440_defconfig
powerpc                  iss476-smp_defconfig
arm                       aspeed_g4_defconfig
powerpc                     redwood_defconfig
mips                malta_qemu_32r6_defconfig
mips                           ci20_defconfig
ia64                             allmodconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
