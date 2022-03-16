Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C846CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 00:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u8uhbx3KWcf28yNUF9fgdpUF2zTP1f33IpVL87aI/UE=; b=k3eVxcMTtchQa3Y1hshzUyKYvd
	f60cJ9giXMxm9kW3uRUWGytMevnniB3VdkNQu3U/vqG+cFtwfxI05uovXtX8oBlz9sn116Zoczk0Y
	8NGDUF46S5TGacWQ6HP7kMn75H4cflkQD7MCIA6bdidedhzX4uVDNY+OrjKuQ8WX7HAPn0m9iJ03W
	EVpy9bJiXEG8agG91/9Iikz81csMizcDfGkzX/Ip6v6/+59mvqYwh4GPz6fBbnOlKDKW5Kp+Wjs5M
	Z/wmzQ58bkmg+sB6tdnf5l2+cATmVOPx/b3PVW0a4i0EE57CkS1aYRMQxCNYtZKcgGGxCOHmsyOLA
	WqTgx4/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUHZY-00B021-VT; Wed, 16 Mar 2022 00:31:29 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUHZV-00B01F-Ub
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 00:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647390685; x=1678926685;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=cQYoe8HeP03uqzecDm9azFfojiwqltvXZ6iX2urofzA=;
 b=aYnOPLVNRBiwlEGAtEj8g1B5pkBGLjs03xaAqYkPg4zqhlrq9BdqtgtM
 by7kJ8/5DBp//XQ/3bW1EXh+CJL4QBBSssOHRzTUcS1uK58ef8UOhyaUC
 XkVnf0sH99avHkJD1iNM10pzXE7I+ruwSh8/KjrjttvZyqGt9xFo4ulOK
 vNUqIPduKWUOJ7xOlntcBAXcNxirqh4AOoVojwN16bvnyXsgyZ3kp7Lrm
 gPzIV4wTHzae62Ux28IRE9JJAJYoDrabAuGo6GxzrAAZg+BOSfcYG6B03
 zYDdCcD42k0t5Khm9crpr8wk4dNlcBWx3ZksJfiXDkze8pFMV9l19W0kL A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317174999"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="317174999"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 17:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="580710805"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga001.jf.intel.com with ESMTP; 15 Mar 2022 17:31:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nUHZT-000BhZ-4u; Wed, 16 Mar 2022 00:31:23 +0000
Date: Wed, 16 Mar 2022 08:30:55 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.17] BUILD SUCCESS
 0c48645a7f3988a624767d025fa3275ae24b6ca1
Message-ID: <62312fbf.T2CibU+lpBXvwjm0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_173126_073185_43363496 
X-CRM114-Status: UNSURE (   7.32  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.17
branch HEAD: 0c48645a7f3988a624767d025fa3275ae24b6ca1  nvmet: revert "nvmet: make discovery NQN configurable"

elapsed time: 730m

configs tested: 151
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
powerpc              randconfig-c003-20220313
powerpc                 mpc834x_itx_defconfig
arm                     eseries_pxa_defconfig
arm                      footbridge_defconfig
mips                        vocore2_defconfig
powerpc64                           defconfig
mips                  decstation_64_defconfig
sh                          landisk_defconfig
powerpc                    amigaone_defconfig
h8300                            alldefconfig
sh                          rsk7201_defconfig
arc                          axs101_defconfig
openrisc                  or1klitex_defconfig
arm                            xcep_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            migor_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          rsk7269_defconfig
arm                        realview_defconfig
mips                         mpc30x_defconfig
xtensa                  cadence_csp_defconfig
mips                           jazz_defconfig
sh                   secureedge5410_defconfig
csky                             alldefconfig
arm                         axm55xx_defconfig
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
arm                          pxa910_defconfig
arm                        spear6xx_defconfig
m68k                        mvme147_defconfig
sh                             shx3_defconfig
parisc64                            defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
arm                           stm32_defconfig
arm                            mps2_defconfig
sh                          lboxre2_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
arc                  randconfig-r043-20220313
arc                  randconfig-r043-20220314
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220313
i386                          randconfig-c001
s390                 randconfig-c005-20220313
powerpc                          g5_defconfig
powerpc                     skiroot_defconfig
mips                        omega2p_defconfig
mips                     cu1830-neo_defconfig
arm                          ep93xx_defconfig
arm                          imote2_defconfig
riscv                          rv32_defconfig
powerpc                        icon_defconfig
arm                    vt8500_v6_v7_defconfig
arm                          pcm027_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

