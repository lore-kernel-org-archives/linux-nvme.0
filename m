Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B685CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Mar 2022 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u1JjMiPyDZjiW247ZOA2CwZhv1zMzYj/d7KrNbXU/tU=; b=OUK/Z5vBOe67vtClDRsOIFmi0N
	S8W9q8zdPP35wpAsZlVbbOFd5oity9e5gBoLKKdDMqFDZb8J4Is9S3YTa/8s8lmCSde7hW4Ls+P4C
	pyVoYs+q7472c6moi6gylUlKgLsl7FCBT+78rWZr2VwBc/iiy4UrSJ6RYD919jzcFOfAyVw/wGzSz
	dAtAED2NhV+8hVfevNwhSgnbK6NbQv4t5RLClCKn31CJoGIKuFzd8rOid0bPHVd7dgLyja3pqjGvL
	ODoj+7GPmUVUTy1/FcovQf3VL4gdSHcYYdPSb+JXziH/FqzKx7+JYXWIjS674is6vpybg+AkqEOBX
	AelC/Xeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOwR1-00FEJT-Mt; Tue, 01 Mar 2022 06:56:35 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOwQx-00FEIs-Us
 for linux-nvme@lists.infradead.org; Tue, 01 Mar 2022 06:56:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646117791; x=1677653791;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=HHNwlXwp0fgU+t91HELGo0j4c9zMheSNtNoWQ0xCX0g=;
 b=Jyko0mC0uxRDyfgfHDdrfQGjLdRrjKxgA31u5y7artqjM8dPOBbBX+Fm
 tc1X1PwdOzT9MHId47AOeGcOZ9i18ps3ZnmPWPeD8lByuPVOGa1nbP/Tj
 rLZDAxyZC4WvfwH5rvP6yT1XSuLZTRpJtnDSyJ771yq/jU4ud7ODLNGjH
 Zlq1BwaYTElynsQs/9EBzCmOnqImXPiKx3djUewyPopa0HC5djewSAzez
 qctQP0WyCMBr5k1QEVIUHJx93+w6zQNhuixYDXD56Jx29P2E2eFw1jggL
 Gi5CR/HUkM4tetm4qu259/kaNT9M8N0I+pb8eFyjCtzmq89TzzxYoXP1j g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236581496"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; d="scan'208";a="236581496"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 22:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; d="scan'208";a="550595216"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 28 Feb 2022 22:56:29 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nOwQv-000053-2V; Tue, 01 Mar 2022 06:56:29 +0000
Date: Tue, 01 Mar 2022 14:55:33 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 2079f41ec6ffaad9aa51ca550105b2228467aec7
Message-ID: <621dc365.MZrqwEllI0lpRn3M%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220228_225632_143293_859F6223 
X-CRM114-Status: UNSURE (   8.06  )
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
branch HEAD: 2079f41ec6ffaad9aa51ca550105b2228467aec7  nvme: check that EUI/GUID/UUID are globally unique

elapsed time: 830m

configs tested: 154
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                            lart_defconfig
arm                         assabet_defconfig
arm                          simpad_defconfig
sh                           se7780_defconfig
h8300                       h8s-sim_defconfig
nios2                         10m50_defconfig
mips                           jazz_defconfig
nds32                               defconfig
mips                     loongson1b_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7757lcr_defconfig
sh                               alldefconfig
mips                         tb0226_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      bamboo_defconfig
arm                        keystone_defconfig
mips                         rt305x_defconfig
sh                         ecovec24_defconfig
arm                        multi_v7_defconfig
sh                        sh7785lcr_defconfig
sh                          rsk7269_defconfig
sh                                  defconfig
arm                         axm55xx_defconfig
powerpc                     sequoia_defconfig
m68k                       m5275evb_defconfig
arm                        mini2440_defconfig
sparc64                          alldefconfig
sh                           se7619_defconfig
sh                          landisk_defconfig
powerpc                      ppc6xx_defconfig
arc                          axs103_defconfig
arc                        vdk_hs38_defconfig
arm                        spear6xx_defconfig
arm                           viper_defconfig
m68k                          amiga_defconfig
m68k                         apollo_defconfig
arm                  randconfig-c002-20220228
arm                  randconfig-c002-20220227
arm                  randconfig-c002-20220301
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
parisc                              defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a011-20220228
x86_64               randconfig-a015-20220228
x86_64               randconfig-a014-20220228
x86_64               randconfig-a013-20220228
x86_64               randconfig-a016-20220228
x86_64               randconfig-a012-20220228
i386                 randconfig-a016-20220228
i386                 randconfig-a012-20220228
i386                 randconfig-a015-20220228
i386                 randconfig-a011-20220228
i386                 randconfig-a013-20220228
i386                 randconfig-a014-20220228
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
s390                 randconfig-r044-20220228
arc                  randconfig-r043-20220228
riscv                randconfig-r042-20220228
arc                  randconfig-r043-20220227
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     powernv_defconfig
mips                           rs90_defconfig
arm                         palmz72_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8560_defconfig
arm                        vexpress_defconfig
powerpc                      pmac32_defconfig
mips                           ip28_defconfig
arm                        mvebu_v5_defconfig
arm                          imote2_defconfig
powerpc                      ppc64e_defconfig
arm                     davinci_all_defconfig
mips                     cu1830-neo_defconfig
x86_64               randconfig-a003-20220228
x86_64               randconfig-a005-20220228
x86_64               randconfig-a002-20220228
x86_64               randconfig-a006-20220228
x86_64               randconfig-a001-20220228
x86_64               randconfig-a004-20220228
i386                 randconfig-a002-20220228
i386                 randconfig-a001-20220228
i386                 randconfig-a005-20220228
i386                 randconfig-a003-20220228
i386                 randconfig-a006-20220228
i386                 randconfig-a004-20220228
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r045-20220227
hexagon              randconfig-r041-20220227
riscv                randconfig-r042-20220227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

