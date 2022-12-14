Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F55C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 21:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vKvGAv6XlXj3h+6FKY5jJglTGbKToQ6MK3Fj75v6DZI=; b=LV2LXMg7effxtJPYe5LFTlsp1e
	PD+kQUP1GOyddBh/bGBf2WA7i2rHDh54Vih6x49trrR9uN9S85lT68ChIV4n1lVA4h8CUb7gHT4vy
	5+QG1iVelPLdCW5rkuEk147sIWDGTFkMtC6KiMEhwOOO+uZO/f30uTIO1c5TiNHuP4PC1IJEJMhGW
	qaQp9hZSDy647U11R4zaoClyce1eimtzJRDdiAjG7tCy9G/5VCpFUm7ijkJOFg9PWHMuLhBvd8E9k
	EkFITL/yMtMR+qrGXquBTczuPEhN0UESaVKSr0PsD/TbOQcyog+YSB6g5Ggb+v5isJ36trdkBvR9F
	ZNkPX1Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Yue-002xe2-Ll; Wed, 14 Dec 2022 21:03:36 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Yub-002xcC-Nb
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 21:03:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671051813; x=1702587813;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HGGTtaeDAAGQbCxIeUbkin/+l2vckO9eiWL+1H+B6i8=;
  b=GSrWxTASX8YGemuUBz1nHFHN/hCv4eJMkxP0JPiNyLj0yCl4Usc2fIz5
   j5fqbmORLSzTHNHqytsufwcNRhJAl7E2tVgZvCLUFy9jKBFXHEBcJzezP
   IPtpIhDZCmcVTes9StBhhof1V0jELJuxm4G3QarXgebEjQdOFC/OEBnZ9
   gsCWD6I31cO0v6/saZCvgS5zNZAVEhxmQDpoznEImKmlWr7/KdxUE1agU
   XXJ48zyNSVCrM4Zi90li5LG54ZvRQ292OlK/SIUjoMROY6LNyaK2gb2eV
   DDAUqo1KMMsVfPo5n3uc2KuXXHoo+G5oxtpEQyIv5QPzscEfHnDigZ7Ry
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="380709197"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="380709197"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 13:03:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="756027369"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="756027369"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2022 13:03:26 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p5YuU-0005nW-0j;
	Wed, 14 Dec 2022 21:03:26 +0000
Date: Thu, 15 Dec 2022 05:02:47 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 524badb852865b36a334d12d5bf6090f4556a737
Message-ID: <639a39f7.vrqFapGWRO1RVsAw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221214_130333_878872_DC634314 
X-CRM114-Status: UNSURE (   6.89  )
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
branch HEAD: 524badb852865b36a334d12d5bf6090f4556a737  nvme-pci: fix doorbell buffer value endianness

elapsed time: 724m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
arc                  randconfig-r043-20221213
mips                             allyesconfig
i386                                defconfig
powerpc                          allmodconfig
arm                  randconfig-r046-20221213
arc                                 defconfig
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a004
s390                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-rust
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
alpha                               defconfig
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
x86_64                        randconfig-a002
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a011
m68k                             allmodconfig
arm                                 defconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
arc                              allyesconfig
x86_64                        randconfig-a006
x86_64                              defconfig
i386                          randconfig-a005
arm                              allyesconfig
arm64                            allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                            allnoconfig

clang tested configs:
hexagon              randconfig-r041-20221213
hexagon              randconfig-r045-20221213
riscv                randconfig-r042-20221213
i386                          randconfig-a002
s390                 randconfig-r044-20221213
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

