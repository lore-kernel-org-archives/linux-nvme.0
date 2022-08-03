Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78673C00140
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 02:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gBk9lwDYSvi16zNR6+m0FCtfOUAAGjtNjpaAwq1gdV0=; b=thMMJ1YA2P1mrRtu5xv8vN1S36
	I9/Pv22liHHCvujdrNFDyhzr8MO0Hmr0BoHR0L/CZLhwi0DnUwFU3AZUclY3/IBt28r8+ues2jp1b
	wCsFelPpnZUtLbv0hDSkrp5znteQiqq0CcOtDE4lSBS5fIvObdWzURsT4xLh8cKQ+AekhHtAB/RZb
	G+dfRTrcrynzehQIuVkhGhT9eaMQIpAOAnLZNlRJK6i+h8SZP3jXvNYX35mvFbeKJXb3gc2mu1ii/
	bXPeVV6cwZaEDuA7SmlOncUu42D067F9CREeOCz4bdiDtRV3kBLZINfP6nzvziB5F7bfRsg6ftx9u
	H25rH7iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJ3mc-001VcJ-5j; Wed, 03 Aug 2022 02:06:50 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJ3mY-001VaN-RE
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 02:06:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659492406; x=1691028406;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Fz1XVV1uY2vk+kNI4kW97/4VoB3vPAJA8FcbH71+4HQ=;
  b=DyCo/6p8HVR8rLipPAEpSXOnat9g3ZoqxWvJeL+CGlv45mm56eMaqe3/
   AFBu5fY+ZxmgWRixbOkk9Krc3175FzOYY8BPzmbGQNeAZIDfxqIE3Cptj
   yNhHLRwRWCgYx0eXnDhCxXEhVLt/2GvuLtG8AJwjkj+Enq+bM1diIvA2b
   mf6SNgme9t+1lWBAhJTWDJRn0Y9YxPnBPsjjliyC8muRBIt5AXEJW3Mdc
   7SkhNBBJOl7juPiHmApNnCUT8tYgs/BL85hRP+NaESZ6KaWcvj+FXKlnY
   4CTELvrWNeKcEWDYHvHk9Y6wzmfQku3AFMV0Y4aDJXHhX67mvhHdsJim1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="272609290"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="272609290"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 19:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="602652989"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2022 19:06:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oJ3mU-000GgN-1C;
	Wed, 03 Aug 2022 02:06:42 +0000
Date: Wed, 03 Aug 2022 10:06:16 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.20] BUILD SUCCESS
 e1872d91ceb95b57dd18eb813fd5fb32f5b064c8
Message-ID: <62e9d818.RI98LFLF7WCp4GFw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_190646_951959_DFAF8F24 
X-CRM114-Status: UNSURE (   8.85  )
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
branch HEAD: e1872d91ceb95b57dd18eb813fd5fb32f5b064c8  nvme: add ctrl state machine pdf creator

elapsed time: 724m

configs tested: 82
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64               randconfig-a014-20220801
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a013-20220801
x86_64               randconfig-a015-20220801
x86_64               randconfig-a016-20220801
x86_64                              defconfig
i386                                defconfig
arm                                 defconfig
m68k                             allmodconfig
i386                             allyesconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
arc                              allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
ia64                             allmodconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
riscv                randconfig-r042-20220801
x86_64                           allyesconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
arm                              allyesconfig
arc                  randconfig-r043-20220801
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
x86_64                    rhel-8.3-kselftests
s390                 randconfig-r044-20220801
x86_64                           rhel-8.3-syz
i386                 randconfig-a012-20220801
i386                 randconfig-a013-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a015-20220801
i386                 randconfig-a016-20220801
i386                 randconfig-a014-20220801
sh                   secureedge5410_defconfig
arm                        mini2440_defconfig
nios2                         10m50_defconfig
sh                     sh7710voipgw_defconfig
sh                   sh7724_generic_defconfig
alpha                             allnoconfig
xtensa                generic_kc705_defconfig
csky                              allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-c001-20220801
loongarch                           defconfig
loongarch                         allnoconfig
x86_64               randconfig-k001-20220801
mips                      loongson3_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
xtensa                         virt_defconfig
powerpc                      makalu_defconfig
m68k                          atari_defconfig
powerpc                      tqm8xx_defconfig
sh                           se7712_defconfig

clang tested configs:
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a004-20220801
i386                 randconfig-a006-20220801
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a005-20220801
x86_64               randconfig-a004-20220801
hexagon              randconfig-r045-20220802
s390                 randconfig-r044-20220802
hexagon              randconfig-r041-20220802
riscv                randconfig-r042-20220802
powerpc                      ppc44x_defconfig
arm                       cns3420vb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

