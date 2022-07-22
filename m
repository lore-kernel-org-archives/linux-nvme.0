Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87041C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 04:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gKnnlZ1kR7mfrByatyLptqXsnS7zI2D1qC58ut3bej8=; b=uDJSSxT/ZPOdTi9o56AFgoZ68N
	/GT6ixnsMmagYeRP7BV1Za9Bl1lSzC6g0qxhZ/aV+Xmx5Mg8Q2lRrir3F2GSsdZTXz4JRnjFfkLJW
	MJKqR7FVGF/X8OHzWfdT55eJZyuZ464zoTSNjFSECIc3YBDgzA9O32MtWyZhUzXebWiuCCNnGuyxy
	6YG4otKsaqTQ094MCst5PHQw005HNLDu5ptKPFOL1971xR1ARnZ3THLfuJc74Bu2C466HSt91vNPX
	9FDVvRRLSGjcutC2JtGL0/U9P7iASylZZjQByg7El7C8uiodpl4DO6HQVjfZ6v6THi9pMGEzVcRse
	NnDOy/nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkIw-00HUVs-F5; Fri, 22 Jul 2022 04:30:22 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkIt-00HUVK-8T
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 04:30:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658464219; x=1690000219;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PL7Vm7lfUVdH2GqGHRGfdST2aZmRx0x0cjCAjn+pPKo=;
  b=lLAglGD2pZKQVsXv7rPo5G+4zE1WbdSHf0XJlKSBg1xOqRZ41m025EEM
   eGdl2ZsIODmRjmeZXQwYX54XRdrV1nGy0BblXvKFMtjNSYfGeod/Mx0AU
   FLmcVGKiNebp0bC7zuxmSIZZdViQHdmbHPZSg4xS+3De+H/I+Uub79J8y
   4of9F2Tp8595aPmm0nIVgSqW4B0PTbPLNLCR5BSZqTjgBUSRtKhPE2dBP
   Z/o0Af23QcyMUntn7/vLbsxOdEqvYInx7XHS/AFFrqhycmj6vVELh5esq
   xy3u+UtJo/om0vRiMzmpN4mEj9GsEp9i9a5/qd8yNHFvSEnas/gWjasfB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="270268647"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="270268647"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 21:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="657059667"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2022 21:30:15 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oEkIo-0000xg-2b;
	Fri, 22 Jul 2022 04:30:14 +0000
Date: Fri, 22 Jul 2022 12:29:54 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.20] BUILD SUCCESS
 f6dca740ff24dcdbeee803cf64ceb351a7fc9f59
Message-ID: <62da27c2.8RnaY7WAvX1Bg4Z0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_213019_375496_1743D6F0 
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.20
branch HEAD: f6dca740ff24dcdbeee803cf64ceb351a7fc9f59  nvme-apple: stop casting function pointer signatures

elapsed time: 729m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                              ul2_defconfig
powerpc                        cell_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                        mvme147_defconfig
mips                     loongson1b_defconfig
arm                         at91_dt_defconfig
arm                             pxa_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                        oxnas_v6_defconfig
arm                  randconfig-c002-20220721
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220721
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
arm                          ixp4xx_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

