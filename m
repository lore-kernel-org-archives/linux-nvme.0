Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85CBC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 22:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fzAK2ttGTiZhZt1+QM9OXyJg/KxbLkcZA+R1MO7LV8g=; b=I8uNKPxekEX5LK9p6CNIPtyYp9
	d0FaLN6cFYwdli+MkC1zizBSzbPTONARnCosM5Y27fQkZiRi2/FZOWOh4FaiSY4w6zVmARQZXgpZB
	BEOCvvmrHIugUr0wIjrzTlaJlTVwLd7q3n6SqoRCSPHW6rc/wqdI0jIvGgHUlTlWMCjTs4t9K8xZr
	NTMRw8sxGxQCQ9xLCDSI2mqQa6h2sPNAZH3od5NRFsMSm8SriJ36aWWiGDnyBvig8PtIVZ2DxuMp2
	pphe8tRtMthDU8+VebXDi6wmfgwE+saF/4CfI7CUq3fJpuYxkYHHvXpzgEA5iPX5zNRu8W4pm1Mcf
	U1PeMNyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p87r8-003Fw5-Ti; Wed, 21 Dec 2022 22:46:35 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p87qg-003FdW-OE
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 22:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671662766; x=1703198766;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bH6TeNO3B/vAN/OPJdV+ZaUnVKBvwaMTJ2HHE2M6zm8=;
  b=d/HwoxqZDekg/cPQgeFQlqUzdB2Bc6EN9H32DQjsy9yfsdjzyPVNJl8n
   WEn1a8gHHRHAZyZW9N8FiFG5lMBgEUYthiTDMb2jIYxrxJplEJphBoNPW
   pgc0F2TPF9yqtgzNBye9mOOpXSMB3s8ASCd5Cln99TL8/FnRDxzg9c8US
   4bmxIwf0wCi02JC1DGmY0rtw4G6IEbsHI71yMMLoioeaV0VM2bW/F2D4f
   gSZQ5+hnFi+feqFVPAnwP3bRaaVlq0uFmCo/PvF1ndi+zFm5UR26Bs7Q6
   49mlcXK0TQcAPQp7pP54ws2WEvb+u3hs/fyHZpuDERQyHIY6p0S1LNS32
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="317627307"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="317627307"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 14:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="714956798"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="714956798"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Dec 2022 14:46:01 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p87qX-000Atj-1o;
	Wed, 21 Dec 2022 22:45:57 +0000
Date: Thu, 22 Dec 2022 06:45:35 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 841734234a28fd5cd0889b84bd4d93a0988fa11e
Message-ID: <63a38c8f.QBiH/NlMsLBbJ0F3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_144606_974949_39CB9B8B 
X-CRM114-Status: UNSURE (   7.43  )
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
branch HEAD: 841734234a28fd5cd0889b84bd4d93a0988fa11e  nvme-pci: fix page size checks

elapsed time: 842m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20221219
i386                 randconfig-a001-20221219
i386                 randconfig-a003-20221219
i386                 randconfig-a002-20221219
x86_64                              defconfig
x86_64                          rhel-8.3-func
i386                 randconfig-a005-20221219
x86_64                           rhel-8.3-bpf
arm                                 defconfig
x86_64                           rhel-8.3-syz
i386                 randconfig-a006-20221219
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
s390                             allmodconfig
x86_64                           rhel-8.3-kvm
s390                                defconfig
i386                                defconfig
ia64                             allmodconfig
s390                             allyesconfig
arm                              allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
i386                             allyesconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
riscv                randconfig-r042-20221218
sh                         microdev_defconfig
x86_64               randconfig-a003-20221219
sh                             espt_defconfig
x86_64               randconfig-a001-20221219
sh                   sh7724_generic_defconfig
arc                  randconfig-r043-20221219
x86_64               randconfig-a004-20221219
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
x86_64               randconfig-a006-20221219
arm                           sama5_defconfig
arm                             pxa_defconfig
x86_64               randconfig-a005-20221219
x86_64               randconfig-a002-20221219
s390                 randconfig-r044-20221218
powerpc                    sam440ep_defconfig
sparc                       sparc32_defconfig
m68k                             allyesconfig
m68k                          hp300_defconfig
alpha                            allyesconfig
arc                              allyesconfig
sh                        apsh4ad0a_defconfig
powerpc                     taishan_defconfig
m68k                             allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a011-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a015-20221219
i386                 randconfig-a014-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-a016-20221219
arm                  randconfig-r046-20221218
mips                           ip22_defconfig
hexagon              randconfig-r041-20221218
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a015-20221219
hexagon              randconfig-r045-20221219
i386                 randconfig-a016-20221219
mips                        bcm63xx_defconfig
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
i386                 randconfig-a011-20221219
arm                        neponset_defconfig
powerpc                      walnut_defconfig
riscv                randconfig-r042-20221219
powerpc               mpc834x_itxgp_defconfig
powerpc                  mpc885_ads_defconfig
s390                 randconfig-r044-20221219
powerpc                 mpc836x_rdk_defconfig
powerpc                     akebono_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

