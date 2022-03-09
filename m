Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BEDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ed/nN9S9Lz/EVEnb1DzABtm7HYs4o7+VCI/Kqa6OAFU=; b=red/i2oNdHafvDa1xPR15ESULE
	oMJuLnnDOZL9RUwCS2DsQwsZO+4VFIKXGTf/J3KeaZSQexmFhcNs7OfgjHArwknMg0hIRhj+X+bnl
	X31SmQQDD+geFnxdniJuZhIGpNLJCY/qwIXrTJNtab8dg0oQ3thI+jo1jChJ5Aph7wcvNs3dLRxN3
	uiFZx7rcnf3wBtXG3/qcps1BugVMWlLR0I7xSBvzs82WncoAT4dfqZ25yfTufwwm3SKvjSSApcW4g
	R8eEXQRSJr5ENSW5UjBG8czRiq+RGcgBG6U7XHY+UoEF5F13RRi2zXyzgCAQKNyJe03oOPKer8KfQ
	YCqdcdsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRlaK-006riW-Mm; Wed, 09 Mar 2022 01:57:52 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRlaH-006riE-V5
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 01:57:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646791069; x=1678327069;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=dBxIMsVppzVpwU6PfM8okILc6YeqyXyTB/E7RS8Wspw=;
 b=hceghyNra2L0epXu76R3emlJ7SGEExOsfTUXbZYbi/9IoRbgtgM76Ayh
 oHB/jauj/yOBtE+D5GuZELwVV8ZPGRYU8HTfK6N7wIe+637F0v01A97Ht
 1uq4BUJBlN03FDbZvnKhT8nBJpHBSZGjluA7D9jvERVqbydXRLNalx4YB
 J9iWRvs+vyxiz7omKpTCF+dpUNWA1wkRRUJT9hfH9309TQ+jcpWWQOTdg
 FkiJeOy9KpKBwV5zPf6LgjpCn+rskKX7tSZp0qaZCggll+6tjrubwNmEL
 MOg9P7XQQfRg1AK9y9HKk0EgF7KMdnzkmUzCzxtusA3DZ5u3ujEfniyGO g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254804119"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; d="scan'208";a="254804119"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 17:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; d="scan'208";a="513343232"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 08 Mar 2022 17:57:47 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nRlaE-0002O4-HU; Wed, 09 Mar 2022 01:57:46 +0000
Date: Wed, 09 Mar 2022 09:57:05 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 4162e0a0978ccc606b902587c7ffe815807334eb
Message-ID: <62280971.PmFz7wiqAfFbNzXI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_175750_106068_162E7034 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-5.18
branch HEAD: 4162e0a0978ccc606b902587c7ffe815807334eb  nvme-tcp: don't fold the line

elapsed time: 2138m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          landisk_defconfig
sh                          urquell_defconfig
mips                           ip32_defconfig
mips                      fuloong2e_defconfig
m68k                          atari_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       m5249evb_defconfig
arm                            hisi_defconfig
riscv                               defconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220307
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220308
powerpc              randconfig-c003-20220308
i386                          randconfig-c001
arm                  randconfig-c002-20220308
mips                 randconfig-c004-20220308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

