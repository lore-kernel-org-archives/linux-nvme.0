Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E170C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 07:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xPNkVG+TxPwlsbn8fsLgah8TTeRl55qJKBON7zcjQf0=; b=D4HX/wY2L5RzidBjBd1fqx5M2T
	SMlgo0KnVGL7uINweJWKRJqpeTDox+ioBNtFRG7ZZC3cmcfdQhlAXqUXqji+FouRQHtqyOIobAY7N
	cM2RzuhplfyvumblZiRCLGQH5VIAsXt5ZzNWhydVoTj5QQc1m/Sn+VkzNPddMf4FXkP432cpDmo3I
	OxjWeYNmA55TVcxD7NtiaQ5QVaqlq4emVjeiwL9ZrkYvWVUYLG2fk+XwiImqpNMcWns4h0iOm9QYv
	ED0KrWr6OOkEY83ynEMWO8WyJOX/UcD7N8FuKEc53cMLWjiVZEg3I93lftbne6SMn8l4FEAKA63zq
	Dmoly6og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFWCu-0008My-7J; Thu, 03 Feb 2022 07:07:04 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFWCq-0008LH-L9
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 07:07:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643872020; x=1675408020;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=5V+u3l3d9rfStZ76wx8PjlK5hur23j6b0v4T6f4u0as=;
 b=T5qUllpyGjBxrj0PpD58ju7DHinB+DKgcxhMmxhSjuVAmcWIWccnQt18
 GWSITfiCHtsGWWN/qrLLsbiQ1qiFZp/N6mMrw2L6XSqBHTutFfk4v54KM
 bhSPogkhcYt5dQnAtJ3bK2+WNp1djrhohTckI2k0whHIyT9MKYtOb9PSp
 jVN1bJPGx6Pq4971Ai60OBg+GBCWBm++EzJMYm3QZpOS0bbTx9bTlzicl
 y4DZig2Weual6Mm2cbr4qyyogOlkFsEiUn4V/IaMOBz4px9pK1CjoxWnF
 A+kxJLd5xoYRkAegYCX+kiMsmXlGnuc58o9bsHF9H+tKjZ7KRz2v/2pQ3 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228056227"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; d="scan'208";a="228056227"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2022 23:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; d="scan'208";a="676689823"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2022 23:06:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFWCk-000Vmc-0P; Thu, 03 Feb 2022 07:06:54 +0000
Date: Thu, 03 Feb 2022 15:06:07 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 5174f53d742193d5b0412ad600fc74e36befd55b
Message-ID: <61fb7edf.++IuNauMsuthxGAq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_230700_757175_311AC04B 
X-CRM114-Status: UNSURE (   7.69  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-5.18
branch HEAD: 5174f53d742193d5b0412ad600fc74e36befd55b  nvmet: allow bdev in buffered_io mode

elapsed time: 820m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
arm                        clps711x_defconfig
sh                           se7724_defconfig
sh                         apsh4a3a_defconfig
arm64                            alldefconfig
mips                           ip32_defconfig
powerpc                     redwood_defconfig
arm                       aspeed_g5_defconfig
sh                          r7780mp_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
sh                               alldefconfig
parisc                generic-32bit_defconfig
arc                           tb10x_defconfig
powerpc                      ppc40x_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                        nsimosci_defconfig
openrisc                  or1klitex_defconfig
arm                           viper_defconfig
mips                        vocore2_defconfig
s390                       zfcpdump_defconfig
h8300                       h8s-sim_defconfig
powerpc                      pcm030_defconfig
parisc                generic-64bit_defconfig
sh                           se7721_defconfig
mips                           gcw0_defconfig
mips                           jazz_defconfig
mips                          rb532_defconfig
xtensa                       common_defconfig
s390                          debug_defconfig
microblaze                          defconfig
mips                           ci20_defconfig
arm                         axm55xx_defconfig
powerpc                       holly_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
sh                     sh7710voipgw_defconfig
arm                           corgi_defconfig
sh                          r7785rp_defconfig
ia64                          tiger_defconfig
m68k                          sun3x_defconfig
microblaze                      mmu_defconfig
powerpc                    amigaone_defconfig
arm                          pxa910_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220202
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
arc                  randconfig-r043-20220131
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
arm                  randconfig-c002-20220201
arm                         hackkit_defconfig
arm                           spitz_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          imote2_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         shannon_defconfig
powerpc                        icon_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a015-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
s390                 randconfig-r044-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

