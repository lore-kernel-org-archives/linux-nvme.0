Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1105C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N/QuIqzQpWFpa0B1XsXpBoykYz6VDT5JXnQyJGWbYBU=; b=S4rrJX3qRtivoRonpnLFGnO6qF
	VyBNTb8pzgsfxzsAdAQNYvUbxMJf6AfkDuZa+7V4sid8OMF2qJhrFFpsuP2QzJ/fVJAfMHmXBIeib
	hCtyVHZY3PPFRf+Zk8OU4hz6j4J7ehMsTbptJ9s1cPAZFAM0/ytTbZ4mGQAcun/C/eycdx/8ubjFA
	nzGmJ8wL8GsjA4u3R6BBNC4znWiEvtTKgdLSWaNh7vmdhQh8R61PGz1/vbnbKB5KlOFnt8ShkZPBc
	87/wnk8dRG395/BOeWF+Ew842MlBW2QoCuL0DsKWiaL9S+wwhkcd/g3NHJ2gLX6jiOGqg9ERi/VqR
	xVivY7Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCN60-00883g-VJ; Fri, 15 Jul 2022 15:19:13 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCN5b-0087mr-NS
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 15:18:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657898327; x=1689434327;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QXIy1OLsZsTMGxhs5Fzob1tvn4PGTwg+yFNP688Cix0=;
  b=khz8KNOMYXNEJPkafX9B1uSsfI4uVxyNo9Pako+Z2A8vnDYcgFZ3f9aM
   mC7z3ARXV1XmL5N+9be3DxcbYcU9uepx1R9SCXXpdXwWrtBjRaaDqvHL6
   CLiToCaSpsxZPqd2Wk65+qcavIrfpjJAwmJ2uoPgOLDNjkfB6hkTuctWT
   IrSm2Kli1MNV5YDYb/t1dKp+7KGdivyYBYClhp8e7x81Pn3inlgX8qTDv
   EVgkjwdC1Vr2GDWBUV/eLZnQDj+HpW/pVsbXab1j0LipXlyT+YB3p117j
   iuKPx9YSSXn0ZfiQW5wHKBrbcgKGP6FNaH3AX1VCK6q7iYfnrI2lYk6cF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284577130"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="284577130"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 08:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="842541137"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2022 08:18:46 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1oCN5U-0000Dn-6b;
	Fri, 15 Jul 2022 15:18:40 +0000
Date: Fri, 15 Jul 2022 17:06:34 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 6961b5e02876b3b47f030a1f1ee8fd3e631ac270
Message-ID: <62d12e1a.E3T1z4SvGS8Vbzlk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_081847_822738_CE643574 
X-CRM114-Status: UNSURE (   6.13  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.19
branch HEAD: 6961b5e02876b3b47f030a1f1ee8fd3e631ac270  nvme: fix block device naming collision

elapsed time: 1041m

configs tested: 79
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-c001
sparc                             allnoconfig
arm                           h3600_defconfig
mips                         cobalt_defconfig
sh                        sh7785lcr_defconfig
m68k                       m5275evb_defconfig
arm                        oxnas_v6_defconfig
arm                        clps711x_defconfig
powerpc                      pcm030_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
powerpc                     pq2fads_defconfig
arm                             ezx_defconfig
sh                             sh03_defconfig
m68k                        m5272c3_defconfig
arc                                 defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8540_ads_defconfig
alpha                             allnoconfig
arm                           viper_defconfig
sh                        edosk7705_defconfig
x86_64                                  kexec
csky                              allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                 mpc836x_rdk_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
s390                             alldefconfig
powerpc                   lite5200b_defconfig
powerpc                     ppa8548_defconfig
powerpc                     kilauea_defconfig
riscv                            alldefconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220714
hexagon              randconfig-r041-20220714

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

