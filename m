Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FED7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Mar 2022 00:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2f09yl30VE0ihZqLRGdg9IffAsdqzqWlVQJvyys9eyQ=; b=GzZaqDmGtKCzP4utz6EA3CrvAn
	yEILbyr7gz/rGeBcSnEgbWZgX+picOLLwJheiSBv5sL4ivccSE03y5T3J2Gex53jS3/GN++SL4rOv
	UDONNFWQUPOni2gXyhPZ8pL3TabY6mrfEcI0gdLgOFyW07bo97qORd5sntUV0HhHOk7FyGNz7O2bi
	lpZIwhq8Sy3gczHfv9cSCBJ43psoI2ve7SzIWZwsfZEc+XETCpDFOmlpk0E41T8oeG3AJ2x05GHrh
	64ivtUwa2BALQG5TwKz/vrWtjyXtaidhtrkwaXfyfnkMvP4HQCf/+N19jQveB1YVLvkCn5GN4Wu4m
	UQucS1wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZiIT-000AAl-Vw; Thu, 31 Mar 2022 00:04:18 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZiIQ-000A5S-FF
 for linux-nvme@lists.infradead.org; Thu, 31 Mar 2022 00:04:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648685054; x=1680221054;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=j99UKp3T4CzWs+MQ8W1dD023rouhym4Svd85JIB0jLY=;
 b=eA+NvO/urdF79N806sVbGK/Rvri8Wl3QVFI3rQiRe0N9K7l+IRlOzO6i
 W5beVratZABYxbOjL0iQNhGg/X3W5GLcE0aRZrqEpJxVG019/mnup5EgF
 1pCwBkhuLqV8ppEcGboR1OB6bCLCe3BlJo4WdJDvwXulE16l3hT2oLzkr
 erbN2HcDRnyTQLAx+oJBrs2rz3l04IcsrgWwIxu4gQt+yBC2L7BHiAY6i
 oaZ6O5z1lrMvVTGEpdr9gyodUnnZKirWUZYElto9MAeB0yZ0tN7FJ1TGy
 mx0T4F9+0xAzHimOnCDXVpPSEltpbALHBGDR5wJdCuG3MRwI72RzcXNPe A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320370017"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; d="scan'208";a="320370017"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 17:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; d="scan'208";a="654216325"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 30 Mar 2022 17:04:10 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nZiIL-0000gA-NG;
 Thu, 31 Mar 2022 00:04:09 +0000
Date: Thu, 31 Mar 2022 08:03:27 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 a4a6f3c8f61c3cfbda4998ad94596059ad7e4332
Message-ID: <6244efcf.ytzHW3gYAAP7Bcgv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220330_170414_618128_398BE512 
X-CRM114-Status: UNSURE (   6.33  )
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
branch HEAD: a4a6f3c8f61c3cfbda4998ad94596059ad7e4332  nvme-multipath: fix hang when disk goes live over reconnect

elapsed time: 2296m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
sh                          landisk_defconfig
csky                             alldefconfig
sh                          rsk7264_defconfig
arm                        multi_v7_defconfig
s390                                defconfig
sh                          urquell_defconfig
arm                  randconfig-c002-20220329
arm                  randconfig-c002-20220327
ia64                                defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a006-20220328
x86_64               randconfig-a005-20220328
arc                  randconfig-r043-20220329
s390                 randconfig-r044-20220327
arc                  randconfig-r043-20220328
arc                  randconfig-r043-20220327
riscv                randconfig-r042-20220329
s390                 randconfig-r044-20220329
riscv                randconfig-r042-20220327
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
mips                malta_qemu_32r6_defconfig
x86_64               randconfig-a016-20220328
x86_64               randconfig-a012-20220328
x86_64               randconfig-a011-20220328
x86_64               randconfig-a014-20220328
x86_64               randconfig-a013-20220328
x86_64               randconfig-a015-20220328
i386                 randconfig-a015-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a014-20220328
i386                 randconfig-a013-20220328
hexagon              randconfig-r041-20220328
riscv                randconfig-r042-20220328
hexagon              randconfig-r045-20220327
hexagon              randconfig-r045-20220329
hexagon              randconfig-r045-20220328
hexagon              randconfig-r041-20220327
s390                 randconfig-r044-20220328
hexagon              randconfig-r041-20220329

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

