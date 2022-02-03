Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0612BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Reg4Q9vISu6hbPQuo6F5tuejqS7R7bGnWmvaCuP7B8k=; b=EkMVySQd5hEu/gFbh5GR4cmL1e
	TBdxxiBSere7wxQ7RnWoiw60VH/3UZk7Padb30rTxaZ0ayNg79aA3lOZbpLHCo6suW3tuUOWIpc1q
	F7GoryYeg79GaGGqOBqKML6rHilRP/7cG8UWAhnZWg6crJBh1OYiAfysN6ualtfU0gVQ+wrygIXth
	aRKYFMSPnzpp2rzA5z+oQ8p6lGAV8CJgp/Xsz5kw2FQKTKtI5swttUNUcGmEQCZj0sMgr+4SGZ9fx
	pPALz6bC4NkLJEREs7bvfsCFioZHQ2g6g5hdkfkkRDhd6mTCxbxYynAV29Gd+p+mHnEjLwpkUnYn4
	xY59k7fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFhtJ-002bHI-1Z; Thu, 03 Feb 2022 19:35:37 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFhtG-002bGS-1w
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 19:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643916933; x=1675452933;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=1d3lVHyjUm4mCp1oXyDlWj7jHQnuLj5YTjETp7ZgxZw=;
 b=gHqrYMOdqAwaoGzK3Ab9svMJxI4CagVXVdjZG9vRy7u0+Hg5IGp6ahH/
 WZf6EedPs85h/ShSoD8kYcxfNXOJHyKylDK9Wle795Zd2g9rwof9YeT/a
 znGSmvoi/dr4oBQeqk+IgBAdTmoisE84NxRkDmtww6SV/2XS0vsPLodj7
 JO20/ZOY9Ag47KemR7bqHIY6KzHzVumZOweCsZuW5asgn3U/A+vZ8RBTO
 f8p7VtN89+bGk2NYCk8udkOrcMFZ7Tp/9DNL5IaFSNGbPVdbhefJcHGlj
 gNtUzsJPQHubST7bFrQq3ZJWlgWpSS2V9t6OzKcZboNslFVb9w1zo3jsw w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248450629"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; d="scan'208";a="248450629"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2022 11:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; d="scan'208";a="620614760"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2022 11:35:32 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFhtD-000WaS-GY; Thu, 03 Feb 2022 19:35:31 +0000
Date: Fri, 04 Feb 2022 03:34:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.17] BUILD SUCCESS
 6a51abdeb259a56d95f13cc67e3a0838bcda0377
Message-ID: <61fc2e47.4VEDCxL+xM6QOhbQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_113534_172846_18FB6A7B 
X-CRM114-Status: UNSURE (   7.57  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.17
branch HEAD: 6a51abdeb259a56d95f13cc67e3a0838bcda0377  nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts()

elapsed time: 726m

configs tested: 173
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
powerpc              randconfig-c003-20220131
i386                          randconfig-c001
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
mips                            ar7_defconfig
powerpc                     rainier_defconfig
arm                           h5000_defconfig
m68k                        m5307c3_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
microblaze                      mmu_defconfig
sh                          r7780mp_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
openrisc                  or1klitex_defconfig
parisc                generic-32bit_defconfig
arm                           viper_defconfig
mips                        vocore2_defconfig
s390                       zfcpdump_defconfig
h8300                       h8s-sim_defconfig
powerpc                      pcm030_defconfig
parisc                generic-64bit_defconfig
sh                           se7721_defconfig
powerpc                     taishan_defconfig
s390                          debug_defconfig
microblaze                          defconfig
mips                           ci20_defconfig
nds32                             allnoconfig
sh                           se7206_defconfig
arm                            qcom_defconfig
powerpc                     pq2fads_defconfig
m68k                            q40_defconfig
sh                              ul2_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
powerpc                       holly_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
mips                           gcw0_defconfig
powerpc                      ppc6xx_defconfig
sh                     sh7710voipgw_defconfig
arm                           corgi_defconfig
sh                          r7785rp_defconfig
ia64                          tiger_defconfig
m68k                          sun3x_defconfig
h8300                     edosk2674_defconfig
arm                          simpad_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                              debian-10.3
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a002-20220131
x86_64               randconfig-a004-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
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
riscv                randconfig-c006-20220201
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
arm                  randconfig-c002-20220201
powerpc                     ppa8548_defconfig
arm                        mvebu_v5_defconfig
riscv                    nommu_virt_defconfig
arm                         lpc32xx_defconfig
hexagon                             defconfig
powerpc                      obs600_defconfig
mips                           rs90_defconfig
arm                        spear3xx_defconfig
arm                  colibri_pxa300_defconfig
i386                             allyesconfig
riscv                             allnoconfig
arm                         hackkit_defconfig
arm                           spitz_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          imote2_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         shannon_defconfig
powerpc                        icon_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                       ebony_defconfig
mips                malta_qemu_32r6_defconfig
mips                      bmips_stb_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
hexagon              randconfig-r045-20220203
hexagon              randconfig-r041-20220203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

