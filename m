Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BF8E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 22:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YMdMtBHGWCfr/1ujpqp610frwhe9kRlpvEyHLzZ/n8s=; b=r4egzKxGOrHLOh3KRwqqsP7fNJ
	XB8lIGJpuzMhLzv2GUjknkGBqZtQkXWs8ThUI3YBpdcNrjkxWBBsyheX9QIL/KoWmnTrhm8wXz6+X
	iwhshm3OIyaHXZe/oaLkW6TFOU1vBULwRVSAmUDySCJ2P7HQJ8XNqSVDPqaV0HeTEKoge6nKSugGC
	0DbLZKF9O07Ucl5vvr1nj5iP2MIhWRckRNQy6nclxbCmr2IDPvEPDbW7kdKhltRcswb1huLdfldTJ
	CDdkIYKShWM31jimNNoew9y+TI1IQigbXXhCG0CQpkyc916crL6jOOw/P9oBfqT/GisEGylPmg5Me
	Ud6uiSyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLVTW-0000000GOkm-2Pd2;
	Wed, 11 Dec 2024 22:46:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLVQV-0000000GO4k-47O4
	for linux-nvme@bombadil.infradead.org;
	Wed, 11 Dec 2024 22:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YMdMtBHGWCfr/1ujpqp610frwhe9kRlpvEyHLzZ/n8s=; b=CnVxmrVDs9OVNA7FNKnAvenl1a
	rByp+eyxE/rydQ9KMfmeFxrG+bYZGcEXgdeXRhFabvN4Ul/V74HfwG0fhKU9Lj8PAbHuoYx9KnItR
	0IMa95GOeaWUkxkU8IOQFuZeeqaPwQnyv/bknSIVj3lGWnLXgABsivunWbJzZp4uOdchpxZl9TxtE
	tY0iFfy6LrgR2OtIaQvcEhCFH8rHwcSXeCXzPDr8IWWR+peICG8tP+TntBJTXssxFXwDkQ8e709nM
	YtgrsEharMHN0CNiEATBonRWzaGqr4Lz8sh79eiYbUmwQKLE8M1VMpVTXNKfhXu+q4E7FQqDaqU9n
	EAws8MhQ==;
Received: from mgamail.intel.com ([198.175.65.20])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLVQS-00000003uFi-1Fh5
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 22:43:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733957004; x=1765493004;
  h=date:from:to:cc:subject:message-id;
  bh=CghLxMRFjWP6kM+FFYvIESKg+po9oii2T73CVo08zLM=;
  b=YccIbgJSd+J4xFO+TKh0oEUddwkOtObJIkphNg16e2GTaOunCRT1sbml
   ITIaCqaBngufGn/CSp82uxW2RjpoUcRzHCxICb422yMjyaIOJd/tYeRq5
   QQcu8d8uNhYPXiR9cYNgy/d0w6focjrGkz7H4y6y5/W6K08HvZLjSiU0I
   P2uoBw/n4Dp8MufrOSGpkxgPXG0ZEFzt8TIAv5QiJ0cH2zL9R4Mn6jl+2
   o5UpfefDby7xk8Wc+MzvBbBvyARxI7tGhSbT/fo8gJ1rvv8p1ReKgnw9H
   jI+7qaepTBomI9InjggQFN2EDCmh4gad29XHrAUYbIMtEbePFTDYr5Pt2
   A==;
X-CSE-ConnectionGUID: RBWPlpDDRE+dgqx6r3qIBQ==
X-CSE-MsgGUID: oY24RWMJRzaCMQat6frdjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34084015"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34084015"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:43:21 -0800
X-CSE-ConnectionGUID: DMpxTu+AQJ6Xp9+/IsvhwQ==
X-CSE-MsgGUID: iGvEUUbPTeSmpu0GkggWhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="95846008"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2024 14:43:20 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLVQL-0007Ah-2a;
	Wed, 11 Dec 2024 22:43:17 +0000
Date: Thu, 12 Dec 2024 06:42:37 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 ccd84b8d6f4a60626dacb933b5d56dadca75c0ca
Message-ID: <202412120629.8OWy4OI8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_224324_849614_4C9A182F 
X-CRM114-Status: UNSURE (   4.68  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.13
branch HEAD: ccd84b8d6f4a60626dacb933b5d56dadca75c0ca  nvme-pci: 512 byte aligned dma pool segment quirk

elapsed time: 1466m

configs tested: 111
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241211    gcc-13.2.0
arc                   randconfig-002-20241211    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-17
arm                   randconfig-001-20241211    clang-18
arm                   randconfig-002-20241211    gcc-14.2.0
arm                   randconfig-003-20241211    clang-20
arm                   randconfig-004-20241211    gcc-14.2.0
arm                           tegra_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241211    gcc-14.2.0
arm64                 randconfig-002-20241211    clang-18
arm64                 randconfig-003-20241211    gcc-14.2.0
arm64                 randconfig-004-20241211    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241211    gcc-14.2.0
csky                  randconfig-002-20241211    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241211    clang-20
hexagon               randconfig-002-20241211    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241211    clang-19
i386        buildonly-randconfig-002-20241211    gcc-11
i386        buildonly-randconfig-003-20241211    clang-19
i386        buildonly-randconfig-004-20241211    gcc-11
i386        buildonly-randconfig-005-20241211    gcc-12
i386        buildonly-randconfig-006-20241211    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241211    gcc-14.2.0
loongarch             randconfig-002-20241211    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20241211    gcc-14.2.0
nios2                 randconfig-002-20241211    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241211    gcc-14.2.0
parisc                randconfig-002-20241211    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241211    clang-18
powerpc               randconfig-002-20241211    clang-16
powerpc               randconfig-003-20241211    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241211    gcc-14.2.0
powerpc64             randconfig-002-20241211    clang-20
powerpc64             randconfig-003-20241211    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241211    gcc-14.2.0
riscv                 randconfig-002-20241211    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241211    clang-20
s390                  randconfig-002-20241211    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                    randconfig-001-20241211    gcc-14.2.0
sh                    randconfig-002-20241211    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20241211    gcc-14.2.0
sparc                 randconfig-002-20241211    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241211    gcc-14.2.0
sparc64               randconfig-002-20241211    gcc-14.2.0
um                                allnoconfig    clang-18
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241211    gcc-12
um                    randconfig-002-20241211    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241211    gcc-12
x86_64      buildonly-randconfig-002-20241211    gcc-11
x86_64      buildonly-randconfig-003-20241211    gcc-12
x86_64      buildonly-randconfig-004-20241211    gcc-12
x86_64      buildonly-randconfig-005-20241211    gcc-12
x86_64      buildonly-randconfig-006-20241211    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20241211    gcc-14.2.0
xtensa                randconfig-002-20241211    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

