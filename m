Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA671C4321E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 02:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XQLf3nl3CMxVyKjuiRVpZlQjOXfPL2fPxxVRArAozSY=; b=Xz/lAltzkQ2zXUZR1tGTlsSTUb
	GB5zx+5enNB+gBgEaQO/apyqsj+4q/6vIW1ihegUTOA1LY/k0Kxmfb+gupHroHASxOKqEXbTsSrBK
	2BuS3fQc2Vhx/QHKAV0FTnk5LFstv484MomJ0Zw912rd1y3kpGlQgoVURj8zQmQrFnN/Te/QNQepk
	SXWlUQyuO3zP1Djk00tmPnTTEEbWL/Tgo8YrY0D52NaZ/PM9QrWbJnxHle2AkmA30cqOaa2/fMRiz
	RriAV+pJ5X+tu9ZEAKdzjGq7SuRkoTq55a15e2ZpnpJMKJwI2KtNYWKAVjxUDGwf3PKXg623G7sIQ
	7irEPBWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0ZP2-003wpz-HK; Thu, 01 Dec 2022 02:34:20 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0ZOn-003wlE-W1
	for linux-nvme@lists.infradead.org; Thu, 01 Dec 2022 02:34:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669862045; x=1701398045;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Xjx/ynTPopX4s/Z8LUlYucyYk71pwzQ6rLjBThL6C9c=;
  b=M7DLxHZwvXJ+fd4tmEO8VXCjy0MjgGxwpcCExFz6f6W0XGNLmHmpUV5g
   pVGlDwp4PlGua+CO+V6zOHhCZS4ctO60ETN2k/FwwLgfgWncVpzPwFWth
   2C94OPrpCXlwwKq2vfGQe+OKCCB2QOB98ISy/CuoaOjrrw0fapljcCMy6
   yCcjrUjF6OoPzkowca7ZeilrK4E0c4jm9ql+IpkaIPtzXhldfDkbGj3El
   x/ZpG0csQQPG1WfQ08X9vlrCNJZ/o+vrCl9oc7Ax3EINVxK5M8rAWcEyJ
   oQr4DToRUJAjIEW+HQfMgNWcD1CpYQvJQpFbx8QDH7BLXL1qQHBAiDGXu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="316720504"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="316720504"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 18:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622121106"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622121106"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2022 18:34:00 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p0ZOh-000C4P-2P;
	Thu, 01 Dec 2022 02:33:59 +0000
Date: Thu, 01 Dec 2022 10:33:46 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 987bbc7bfacb1eb51235b661e535917e2d2135ab
Message-ID: <6388128a.NL40vX6OK7pgrva9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_183406_155679_68920E5B 
X-CRM114-Status: UNSURE (   6.68  )
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
branch HEAD: 987bbc7bfacb1eb51235b661e535917e2d2135ab  nvme: don't allow unprivileged Write Zeroes passthrough on read-only FDs

elapsed time: 724m

configs tested: 77
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                           x86_64_defconfig
um                             i386_defconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                              defconfig
i386                 randconfig-a002-20221128
i386                 randconfig-a003-20221128
x86_64                           allyesconfig
arc                  randconfig-r043-20221130
i386                 randconfig-a001-20221128
s390                 randconfig-r044-20221130
i386                 randconfig-a005-20221128
i386                 randconfig-a004-20221128
riscv                randconfig-r042-20221130
i386                 randconfig-a006-20221128
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                            allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                           u8500_defconfig
sh                           se7780_defconfig
openrisc                       virt_defconfig
arm                     eseries_pxa_defconfig
arm                           sunxi_defconfig
powerpc                         ps3_defconfig
mips                    maltaup_xpa_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221130
hexagon              randconfig-r041-20221130
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r045-20221128
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-k001-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

