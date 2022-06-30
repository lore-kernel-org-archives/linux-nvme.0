Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9C3C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TCLFBPCUf8aFHVCImiduZbdETh+tLLCtXzjtSn1Cihs=; b=JQ6CdpOR0nY+Nkpz5bYwnfHdNn
	5jfvIvS8nPw1MVPHASLStPXo/cmaw+/k6CGnNRvQJ3pS5QaktfkWCe6HoFi83/F6UJ6cqGywattp1
	nQvPjBYjYh1xol6uXtpujAx2+gqMx5MuD9KUUw+uSgY21MiJ9KUG+8MeqR1PMwtGEMHl8f3J6gAZL
	ChhUoCG7/k0pnP3nuR53C6XYxJvz8ct+36I3MzZwUHS3VP7wj6Kof7KxDDoB3u0eEHfOiYglFpI1i
	RAdlsL8YOUzuUJrBz1yheJKqyiFLfG3LmcUAg8AefcK4x6GySjkA3Tuvhnz5VUo/NGWobnp3IEOcs
	CNtRYlvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6zyX-001E74-Jk; Thu, 30 Jun 2022 19:37:17 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6zyS-001E5A-4N
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 19:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656617832; x=1688153832;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NwBdZ+dJ2exaP2+tsIU9GBDc04h8mjc5GP+rFXGjCrc=;
  b=MRIc1AGmIVVkVO6raRNF2dFomxe1qF31z6+3O3SmXoeYrenwYu+ad88q
   BaV+zXeQYI4OenL8O0LrHfX3sQ0TA++07u1K6d5zB8P8yGuG+qoJ02vhW
   5XWGroUfESRfTT8xNtuzEo/1x+TxnHPRYptShmDHEdM8R/7S+yVSuaEYO
   wgxJEwjuaFGkvALX1EFcUNrhE42Lju7xC5J2FsFm8JogWjDxf1dO9punW
   aD/KE9hfR/TEgaSBHXvU+l7bOenioEX9KYoAhrBVypMJyOa/eYMzUV3J2
   JfW8VyshuJHcfWRqbGi1O3wqAosg+5ixjVIYFKS4H70coPqJNA6UckeK8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="368762739"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="368762739"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 12:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="837729980"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 12:37:07 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o6zyN-000D82-AE;
	Thu, 30 Jun 2022 19:37:07 +0000
Date: Fri, 01 Jul 2022 03:36:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 e1c70d79346356bb1ede3f79436df80917845ab9
Message-ID: <62bdfb38.V4kkjp4fQk98lsbI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_123712_234661_46DFC3A1 
X-CRM114-Status: UNSURE (   5.94  )
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
branch HEAD: e1c70d79346356bb1ede3f79436df80917845ab9  nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1

elapsed time: 722m

configs tested: 69
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
xtensa                  audio_kc705_defconfig
arc                              alldefconfig
arm                          pxa910_defconfig
arm                        multi_v7_defconfig
arm                           tegra_defconfig
m68k                       m5475evb_defconfig
nios2                               defconfig
arc                           tb10x_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         microdev_defconfig
mips                          rb532_defconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
riscv                randconfig-r042-20220629
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                 mpc8272_ads_defconfig
powerpc                      ppc44x_defconfig
arm                         orion5x_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

