Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF7FC19F21
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Vw12isLV8maWuislbAVZMyKeGzqgphXvaNwMAilrze0=; b=X9VbFbtaPX5JipldI0KcpShvs4
	MfttPLD883o8esZxgubqvmcyko2r+CrxpnYwmvaQQE6eocPTqNes6/vuL6mIhhMKoy2zoDPq66x73
	9uvMYunsxQzBfVgVa34moKt/yWRWqYZqg712xMGDfaQEi0u0GuvkFaBHmLdmcbwtXthD44jTOy6UO
	JYdFJkylNdC2q/hswdjsBsu43AA/xuPPCV0ox4obSMuTOyUg7GIQDzcBVWjg0dQdCUZwGjOOKzA4q
	AP///bo9Q4QdJf5ZD4CCUeWAqUPUURZH709CfCZWiF2OtvpdqbUeIJH4ACZ5klRtEU2AH7nkVr7eK
	XnjldoZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGcpv-00BQao-FN; Wed, 27 Jul 2022 08:56:11 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGcps-00BQWY-EE
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 08:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658912168; x=1690448168;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Y7qtLI6OhrJIJL4awvW561PjA/akj4TqeVyUgczn9io=;
  b=EP7BtGwRBrBGMPWFQHioCTBtPZgjSArhH32x5kIdsetT2vHo6LmOK8bw
   BQfMXP4NQifmQj/n1Mx6sxPcXJaYOwLJDqklGH/jMsXD/4S0WdVnJl9kp
   CahR1pMrRkGCQ82MYSL+nUcGkK8DZYH2yjok2ihuNOpauQkeYY29+N8/S
   F5eZO+ngiVnn2oxm/BmtmZ2tcqaNCSusHKT7gMMwLRE/cK3FoMons5Wjo
   /5TLkTIFEx29Le4cL+Q/wlZC68txma17Z0CIWz8ym9jKzblIutwu7lueD
   WHQ53IrqCpHjKGJyFyHY9ooSRQtY5zI0IvKidYBgBiPzdvkM1mioTQrAz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="352178192"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="352178192"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 01:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="742577334"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2022 01:56:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oGcpn-0008YJ-2Z;
	Wed, 27 Jul 2022 08:56:03 +0000
Date: Wed, 27 Jul 2022 16:55:53 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.20] BUILD SUCCESS
 26203a5e04d5cb1d1715f71c48cf6eec0dd9b88f
Message-ID: <62e0fd99.uk/9IbSNELHxrYuw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_015608_589111_CAC1AE93 
X-CRM114-Status: UNSURE (   7.68  )
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
branch HEAD: 26203a5e04d5cb1d1715f71c48cf6eec0dd9b88f  nvme: update MAINTAINERS for the new auth code

elapsed time: 723m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                         apollo_defconfig
mips                      loongson3_defconfig
sh                            migor_defconfig
arm                          badge4_defconfig
powerpc                         ps3_defconfig
arm                        keystone_defconfig
mips                         bigsur_defconfig
arm                           stm32_defconfig
arc                    vdk_hs38_smp_defconfig
openrisc                 simple_smp_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
s390                 randconfig-r044-20220724
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz

clang tested configs:
mips                           ip28_defconfig
powerpc                        fsp2_defconfig
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
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

