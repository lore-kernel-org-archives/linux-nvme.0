Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3E9C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qWmx1l0jd/2CJ0p8KuimSm/b7rXEEFAxP1VAYNl4AbY=; b=3y2Rv1HNdFaEd3tpEHoK6+n3/A
	Zc8v18i99/IM1zrtcetAtmnEQHBk0eW8FPa0Vzqhi20OZS3zpofJvxtnFsu3x8czYdNhGLSVFcI9w
	exuI0MK7RSeRSaMK6Pqqj4pKJaIIiBRm6TA/I83pwkd1Aiu7Sy3uvhc9MmsdWtr71Sh3phb57/lam
	l657oQf/ncaMVKQ/dq73pmLZa1Hty7Pdo2FLBYJXzliedbbsU3lcfkyFhV6bMjyacHoESHjFwwzgM
	TwBQdZueEVnXyQMWIPFG6LNfNdkHbjiShIOg8oK9ct5jzL8P/dAX1DfOPCJ/cdkxuUDbSAGIsgMAD
	12o7leNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovNTM-007GIE-EU; Wed, 16 Nov 2022 18:49:20 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovNTJ-007GHu-4i
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 18:49:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668624557; x=1700160557;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hGkiOUQrju3MGbPfnUEQcPRdK7Wn+uiPa1riMgQVwfs=;
  b=DH9UT8Mw/Jx9QrwHZQgqwIW0yZPVptsZvDGVi3bkia6s/P2iuFtUtIDx
   TU3ITlmfnADwYkZkiFMRhuT6wQd+Mr9Cu2eAtckVhgiKg+owubc7iY1xc
   3cno/sRtDAmeCAjL9+afhGd7nVmXP7jaZjN1iVtAZxuZ5kEHG0VFVYnt7
   JDbRcRC3LJ0Q4EqOEjW4TytEh7h/EU4mt+QW29WGCQzFpPbm80cs8NgAm
   o6ctTYZ3OjUwjo4VlTdbwRCZxJkl82Vg/J7WSr2sFRuiUdcCDjrLgA3ro
   qHPWcaS+6U67G/pMSWw5Ieh+yGICu0QxuQzHsmlUUo5vHeE0+dldPbKZJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="310260419"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="310260419"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 10:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617280078"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="617280078"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2022 10:49:15 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ovNTG-0002cv-1N;
	Wed, 16 Nov 2022 18:49:14 +0000
Date: Thu, 17 Nov 2022 02:49:01 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 0a52566279b4ee65ecd2503d7b7342851f84755c
Message-ID: <6375309d.5rzuA9t0DGOx468H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_104917_245499_D462FF1C 
X-CRM114-Status: UNSURE (   7.83  )
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
branch HEAD: 0a52566279b4ee65ecd2503d7b7342851f84755c  nvmet: fix a memory leak in nvmet_auth_set_key

elapsed time: 721m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
um                           x86_64_defconfig
x86_64                               rhel-8.3
um                             i386_defconfig
x86_64                              defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           allyesconfig
s390                                defconfig
arm                                 defconfig
i386                 randconfig-a001-20221114
i386                 randconfig-a004-20221114
powerpc                           allnoconfig
powerpc                          allmodconfig
s390                             allyesconfig
i386                 randconfig-a002-20221114
sh                               allmodconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221115
riscv                randconfig-r042-20221115
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arm64                            allyesconfig
i386                 randconfig-a005-20221114
s390                 randconfig-r044-20221115
arc                              allyesconfig
mips                             allyesconfig
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
i386                 randconfig-a006-20221114
alpha                            allyesconfig
i386                             allyesconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a003-20221114
m68k                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arm                         s3c6400_defconfig
sparc64                             defconfig
arm                       multi_v4t_defconfig
powerpc                     asp8347_defconfig
x86_64                            allnoconfig
arm                        shmobile_defconfig
sh                   sh7770_generic_defconfig
loongarch                 loongson3_defconfig
mips                           gcw0_defconfig
alpha                            alldefconfig
powerpc                     tqm8555_defconfig
i386                          randconfig-c001
sh                          r7785rp_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
s390                 randconfig-r044-20221116
riscv                randconfig-r042-20221116
hexagon              randconfig-r041-20221116
hexagon              randconfig-r045-20221116

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

