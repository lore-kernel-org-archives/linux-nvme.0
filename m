Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F1EC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 06:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1E4XGjquvg+CTKl1badcXbc6Hh2ReCb28GswZB0S894=; b=pvVMi5YDsMHQBaZyd5zoLkdk3r
	5ASJ+E2GHCAn4cQ4RGTuVMkU0ewY0e4zDHXeGPTzbMr7LPHQiwUTOk0itPeKy4VdDIeI2pMCDuSgy
	+U40c+JfbEe2Zca+mm38zY/oMJL/Zh4vjfLGWqhswBXeehpUpwAleZwgeY0WkkTup2nIVk0OtbBM9
	fWWXGsOUyuGqggZMxP6CTdRAqils7/FrA1ulJ4ukAH3FqRYanHNSI2kybKFQ5jVXwsMFTnlSpVJSO
	c1oKc+b8evI3pGM24hgcWRbOcEe4h7prAFGRIHRX6EFhoMAdX7tgdtMIGq9hA+MVOQSvx5UXhdRGp
	77gDBeYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o10SY-007PqM-QY; Tue, 14 Jun 2022 06:55:30 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o10SR-007Pmz-Cc
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 06:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655189723; x=1686725723;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qzJVpuWda9g0xUuWhQkS6bjGV99tJ5WuNvWmMxtcsvo=;
  b=GZHRlAa2Evzg+aJwFlFs3BgT4jH9MEV5EwmFw8dcEAadcQiqYd7dBUqW
   nHxik4zO9HvNudmu9A1RFbJlKBdIJCrerpiOacPL1kP4/7vHZhoRDwyIG
   AugN++s8xP1VK+R3MhcKHDQhOIx20GPgcInvP30yBtGELX1kPTMwbM7cG
   ndh7FXOBOErysr7pmhJOxKPWFP+3ARwx2+80PFogv7QPf+4NBDmi9o/Qn
   wm2H5DijDTg0hU59PkKd+xYlikG4w9a53RDYHK1bld7LvBBXWT1bzcULK
   RNoIA+biX1EQ1h5dEQiAjX+tyA+WDvEwj5LzqVNSuyIYL/oHx5NZTuMb8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303934587"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="303934587"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="535443271"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2022 23:55:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o10SM-000Lao-1o;
	Tue, 14 Jun 2022 06:55:18 +0000
Date: Tue, 14 Jun 2022 14:54:29 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.20] BUILD SUCCESS
 df793a7e5bbf012c5a8c0a4d4e29512b9e6263e3
Message-ID: <62a830a5.IoBhlnX4V/ktdQQP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_235523_489281_E442BC7F 
X-CRM114-Status: UNSURE (   8.69  )
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
branch HEAD: df793a7e5bbf012c5a8c0a4d4e29512b9e6263e3  nvme-core: fix qid param blk_mq_alloc_request_hctx

elapsed time: 726m

configs tested: 81
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
nios2                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc64                            defconfig
s390                                defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a014-20220613
x86_64               randconfig-a012-20220613
x86_64               randconfig-a011-20220613
x86_64               randconfig-a013-20220613
x86_64               randconfig-a016-20220613
x86_64               randconfig-a015-20220613
i386                 randconfig-a013-20220613
i386                 randconfig-a011-20220613
i386                 randconfig-a012-20220613
i386                 randconfig-a016-20220613
i386                 randconfig-a015-20220613
i386                 randconfig-a014-20220613
arc                  randconfig-r043-20220613
riscv                randconfig-r042-20220613
s390                 randconfig-r044-20220613
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func

clang tested configs:
x86_64               randconfig-a002-20220613
x86_64               randconfig-a004-20220613
x86_64               randconfig-a005-20220613
x86_64               randconfig-a001-20220613
x86_64               randconfig-a003-20220613
x86_64               randconfig-a006-20220613
i386                 randconfig-a002-20220613
i386                 randconfig-a003-20220613
i386                 randconfig-a001-20220613
i386                 randconfig-a005-20220613
i386                 randconfig-a004-20220613
i386                 randconfig-a006-20220613
hexagon              randconfig-r041-20220613
hexagon              randconfig-r045-20220613

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

