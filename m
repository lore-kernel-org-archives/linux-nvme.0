Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4A0C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Feb 2022 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hGEVr/01Bohuy2CEmM7sgahPQKbp9scYnN9iSHHUYVg=; b=kbWhbMZk7tG0WlwiWQJGFwZiJv
	NQ5qF3FbO/gbBhmlaRAu7zBy/5PNYVbEwo1ulEC7abFepZ8pcfXeOvYrchFcDDYxT8Y1kFkCbOl5+
	cK6Og8opsmpWoPdqI8SRoQgzq3XWUanNFqvXmRbDTlaZVur7KPWDsMgjifcKxyO9m+16KhD7S+PDh
	2uTi6nrMtNocdEoaxCHmKMIgtUNcw4Pzee/+fig+AY+Kbbw9/0eFqN3UGwpU6do66QAoyL0FT5OIE
	izgfkBGN1awcxpgh1ykT03WAl5IK+wiuM/5lxsprZlAfKOWBu/uK4dPiWALqoyhXiapdMOjAlIFmU
	VjjfdvIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOEGP-008w4n-5g; Sun, 27 Feb 2022 07:46:41 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOEGD-008w4V-Ec
 for linux-nvme@lists.infradead.org; Sun, 27 Feb 2022 07:46:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645947989; x=1677483989;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=tPJa7ldR0K3UnSekErGl1I86RbAD8DCTKcNLifEqAq4=;
 b=YpPdBFy6/d48cPJXoflVxBqBK215fGiClszyxy/S0Fc+5+dJHIvkt7/o
 jVoUubIcA3bf4V2yE/OHUY8K9UJiz+2u1Jb1b6r0bVNr0sl4zVF0OF7J/
 5dMlWna1JTjucXAHtM5BRzyUYvxUiol29D+hn+v85+FBX6F4D+iTe6vkr
 7nX9lPodjEskkrHHGY66zwd3mvrHNuqjXlITfkOhwrpw0IZ0/8h54eDmy
 VBoUyB5X+AWE28ReOZUj5Pz1msdcHKHc1FMRPNag9mxQtyeHWluf3Tz+U
 demKD26Kdr87UsyCypSENMlXSi7Z6FpmDK4KwXNMP3i7t9Zmh7sMcttvi A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="252442431"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; d="scan'208";a="252442431"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2022 23:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; d="scan'208";a="509724406"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 26 Feb 2022 23:46:25 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nOEG8-0006LU-H5; Sun, 27 Feb 2022 07:46:24 +0000
Date: Sun, 27 Feb 2022 15:46:06 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 9e104e034ed65a85029b853d5cdb50f601a7c303
Message-ID: <621b2c3e.cPQTBZztBPvvfENT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220226_234629_614803_C19DBBEF 
X-CRM114-Status: UNSURE (   7.05  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.18
branch HEAD: 9e104e034ed65a85029b853d5cdb50f601a7c303  nvme: check that EUI/GUID/UUID are globally unique

elapsed time: 727m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
mips                           ci20_defconfig
sh                           se7780_defconfig
m68k                          sun3x_defconfig
m68k                            mac_defconfig
arm                           corgi_defconfig
m68k                       m5275evb_defconfig
mips                 decstation_r4k_defconfig
arm                  randconfig-c002-20220227
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20220227
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220227
mips                           mtx1_defconfig
powerpc                     mpc5200_defconfig
arm                          ixp4xx_defconfig
arm                        neponset_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220227
riscv                randconfig-r042-20220227
s390                 randconfig-r044-20220227
hexagon              randconfig-r045-20220227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

