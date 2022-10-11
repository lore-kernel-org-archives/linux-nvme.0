Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E75DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 00:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kV5iL0r5gwxaGMaMMCxLNFbniwRXJW75jS8NzkEJ6Ls=; b=qJb3qG9SpTipKq7miWYjGGbpBM
	stsY6vCqz+m/J+wGjo3PIi5ChN8oI919GPY/kj3xsrapB/PnU4WWHBGAAVFpZdSHPDzho1s2hsAtA
	ZalE1m7j8Leaixu6Y4oQrJv9r92oOCutQ2NJqVnEsLrWQOZvWulw26QJaWJAkQHNib4WIO7FmE8g0
	1kpxiD1Hy8J+1iZ3S9FQFz8uXbCo0WVJbSt8fpM6CID/2en0AGafCWPdw/Mph49BeM1rMag895Fs6
	rj4wBQMZRNpAeVT026zfvysf3EqBWZgkt9yNVYvMMgrh//0DZkhfFOttPQQwqAl/JJ1YRsRAMiAaU
	Iw3oRULA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oi2pF-002gpb-IZ; Tue, 11 Oct 2022 00:08:49 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oi2pC-002gop-00
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 00:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665446925; x=1696982925;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IkZuktAvlkkpopBzMcVih3pOAXpo+0N6kBmhrWufCLk=;
  b=Aws7gIYXCo4jb7kFUO3fIVW4PuNlncLwk7PQNXGLUxrxzeU7J2mDSn/O
   qO2WrKn26PCDm1jj8MUx00A3EXZhq78Itb232XJTEmOBvLu9AtM/ihVjv
   E7TCxHh5xfAjrXXWAcaHXosMrkr3Ww4UEGktq5vL0VKYtU9Kw3Sh3uG/J
   fy0nBSIBXl1an+Oe8cBuZsC0hF9iEFw2E9GuvOOmghP7KC57/SN4MaVS0
   QCm30e3j+VuuULykMGsWlVa3nNcfVBbYe5RcSgkNZmN1QO/Xd/Q6PL3fp
   t/p2uGbdllhg7GmsPdy39KRKBD5Y648ss9TGFLQNksKMOOt3i7hrw5P+0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366356287"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="366356287"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="955125925"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="955125925"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2022 17:08:42 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oi2p7-0002Ir-1Y;
	Tue, 11 Oct 2022 00:08:41 +0000
Date: Tue, 11 Oct 2022 08:07:40 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 c496c68157ea0939b845a72666cc27e16a404b9f
Message-ID: <6344b3cc.PNjtT49Cdq9qKBGP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_170846_132983_00BB6F16 
X-CRM114-Status: UNSURE (   5.69  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.1
branch HEAD: c496c68157ea0939b845a72666cc27e16a404b9f  nvme-multipath: fix possible hang in live ns resize with ANA access

elapsed time: 855m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
arc                  randconfig-r043-20221010
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20221010
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
s390                                defconfig
riscv                randconfig-r042-20221010
s390                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
arc                              allyesconfig
i386                 randconfig-a012-20221010
i386                 randconfig-a011-20221010
i386                 randconfig-a013-20221010
s390                             allyesconfig
sh                               allmodconfig
i386                 randconfig-a015-20221010
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                           allyesconfig
i386                 randconfig-a014-20221010
i386                 randconfig-a016-20221010
arm                                 defconfig
x86_64               randconfig-a011-20221010
i386                                defconfig
x86_64               randconfig-a014-20221010
x86_64               randconfig-a012-20221010
x86_64               randconfig-a013-20221010
arm64                            allyesconfig
x86_64               randconfig-a016-20221010
x86_64               randconfig-a015-20221010
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                          kfr2r09_defconfig
m68k                        mvme16x_defconfig
sh                         ecovec24_defconfig
powerpc                          allmodconfig
i386                 randconfig-c001-20221010
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                        trizeps4_defconfig
arm                           stm32_defconfig
arm                            pleb_defconfig
arm                         s3c6400_defconfig
arm                         lubbock_defconfig
m68k                        m5272c3_defconfig
m68k                        m5407c3_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                     pq2fads_defconfig
powerpc                   currituck_defconfig
arm                      integrator_defconfig
sh                           se7750_defconfig
sh                             shx3_defconfig
mips                      maltasmvp_defconfig
arm                        clps711x_defconfig
m68k                          hp300_defconfig
arm                      footbridge_defconfig
sh                     sh7710voipgw_defconfig
loongarch                        allmodconfig
sh                           se7206_defconfig
sh                        edosk7760_defconfig
x86_64               randconfig-k001-20221010
arm                            lart_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      fuloong2e_defconfig
m68k                       bvme6000_defconfig
ia64                            zx1_defconfig
arm                      jornada720_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                      mgcoge_defconfig
parisc64                            defconfig

clang tested configs:
hexagon              randconfig-r045-20221010
hexagon              randconfig-r041-20221010
i386                 randconfig-a003-20221010
x86_64               randconfig-a002-20221010
i386                 randconfig-a004-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a003-20221010
x86_64               randconfig-a006-20221010
x86_64               randconfig-a005-20221010
i386                 randconfig-a002-20221010
x86_64               randconfig-a004-20221010
i386                 randconfig-a005-20221010
i386                 randconfig-a001-20221010
i386                 randconfig-a006-20221010
powerpc                  mpc885_ads_defconfig
arm                       imx_v4_v5_defconfig
mips                     cu1000-neo_defconfig
arm                          ixp4xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

