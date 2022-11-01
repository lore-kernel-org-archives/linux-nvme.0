Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC027C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 22:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E6ivh6edE8TRKFvv4Wrleddjtfp9zliDcBCFLn5IY9U=; b=JI+VBuxXox7w3/+STP+Od9dNDZ
	C8KH03zG2Dy+UINeP8trxjSdbZu6fbBxTc2SBV09TYXEiL2mXxOwro/xcKg5T5MR8j2g3jFmC/pId
	Wqe5AGIXRN7nnoeOJY8rwp75QcVeLDNLRyfAAa24WrM65jF4sVZtg0rnllCYBy92ExeJuIfmOEJhB
	ifteW1kJefwKpon5wMXBrH+3Olhx3KizvmpFrpBSF6inYwAQoC6wXt6BTJFQh+eZT6gfHqWlWBi4K
	5Av7lnWEd3PAOf6WXXsBfyZNF7+cFau4roLfDK2ZRX5rmHKbv8SEJvDEf3zgUcJS5SsKSkG6Nq47x
	4FH5tcCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opzdW-007Psn-D5; Tue, 01 Nov 2022 22:21:34 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opzdT-007PrT-H0
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 22:21:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667341291; x=1698877291;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Yphb/FSvYEOwrbgq3aWirp1XDunNmVk9lzl7RTwqvyE=;
  b=bZBBPC9urGOr3yFvq6iHVW+FTEAXSns/dM8FjWvqeqGH7o/RrjtMb7Fn
   uRtkYrG6FA0N4hwQJ0EgXPj8vOoiKnnuNkZVpX6gL5R+rihlxmyKDa6+d
   5ARRVUjXNymxDQBX2edA4MeOx2gbc3aK3p6KhgYwhkfSr8dISIVP+jcXb
   C6+yqeYiDEjKb7a5/+jbu37mwtbdBhlgmXmOSIN8YpuGQTgKfdwv7QS0U
   OCgy1i6zkBNSAl4RAqYjZO/cL4XxeznJLXmJC4ksw4HtDw9NBreOMFbNs
   H7tYEeQhglgdHUtgrD+Q5SrNjFeY2SIoYqz5IWJrtsNJoGxYUIW3FomMR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310971650"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="310971650"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 15:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="634027824"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="634027824"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Nov 2022 15:21:27 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1opzdO-000E6S-2j;
	Tue, 01 Nov 2022 22:21:26 +0000
Date: Wed, 02 Nov 2022 06:21:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 d30a909f9bb5283e701a5fdfffac763ef57a3e7c
Message-ID: <63619bdb.7WR9ybgza3gxtHwJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_152131_636849_2A77E867 
X-CRM114-Status: UNSURE (   8.08  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.2
branch HEAD: d30a909f9bb5283e701a5fdfffac763ef57a3e7c  nvme: identify-namespace without CAP_SYS_ADMIN

elapsed time: 722m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20221101
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
alpha                               defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a002
arc                              allyesconfig
x86_64                        randconfig-a011
alpha                            allyesconfig
x86_64                        randconfig-a006
m68k                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allmodconfig
x86_64               randconfig-k001-20221031
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
mips                           jazz_defconfig
arm                           tegra_defconfig
mips                 decstation_r4k_defconfig
arm                          lpd270_defconfig
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
i386                 randconfig-a016-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
sh                          rsk7203_defconfig
m68k                       bvme6000_defconfig
arm                           viper_defconfig
arm                        mini2440_defconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc834x_itx_defconfig
mips                       bmips_be_defconfig
i386                 randconfig-c001-20221031
mips                 randconfig-c004-20221031
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                             allnoconfig
i386                          randconfig-c001
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig

clang tested configs:
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
riscv                randconfig-r042-20221101
s390                 randconfig-r044-20221101
i386                          randconfig-a013
i386                 randconfig-a001-20221031
i386                 randconfig-a003-20221031
i386                          randconfig-a011
i386                 randconfig-a002-20221031
i386                 randconfig-a004-20221031
i386                 randconfig-a006-20221031
x86_64                        randconfig-a014
i386                 randconfig-a005-20221031
x86_64                        randconfig-a005
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a005-20221031
x86_64               randconfig-a006-20221031
x86_64               randconfig-a004-20221031
x86_64               randconfig-a001-20221031
x86_64               randconfig-a003-20221031
x86_64               randconfig-a002-20221031
powerpc                   bluestone_defconfig
arm                        magician_defconfig
mips                        qi_lb60_defconfig
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig
arm                      pxa255-idp_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

