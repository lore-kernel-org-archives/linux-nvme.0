Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D0AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Mar 2022 05:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rE9ydmRnv17mbCbBzH9SnKEptIbrgpUQwh5kEs+Naj4=; b=zFRt9HwjwVZyHCNPKdBWb7va4C
	h/yzBl5VDw0xYV7u7zfbjrFsEMklstostl1P7MHAfoY94vYPaa1XiSpMCaedB483XO5vIROKab5rv
	vLCb3Nap/t7yWG23nwFVRt9XgyvPN/dIxooFrdw9ouygwXqUBIaGLcAbpvpgSUwaDN0id2Efj+zN+
	lGQEiOKJTVbBJYHpUaWyXIxHgvw6niPH+nwaBRaD3gTa6eptGTXLS30PXwfJQJ9PjmCF9N6W7EdlJ
	cZmH9tHu39jAkradrGopPzclKMvGGDibShOX+o/SNrvOT4s9y6Qkkv2U3yZnt6Tgc2sfmrZkYEIpV
	1thEplzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUivN-00F01B-HU; Thu, 17 Mar 2022 05:43:49 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUivK-00F00j-IK
 for linux-nvme@lists.infradead.org; Thu, 17 Mar 2022 05:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647495826; x=1679031826;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=4UByprziqnAIUBAmTF3wV21wogmFtYkQaFz3aUsh0KA=;
 b=YWHL0GRpNAx4lFEHjBTcUW6ka+NxbkGkWZnWd61C20OEAVAKEAMSUOQ0
 ynW5vGAcyVrcJtwJHhDmFbuoV44qGjtUZXh5OQahCtuLlZf/u1dUBw3RN
 CV0SGcT/y/vpIUvex9kOG59oBsDKB+Fg2Gzs7STXcP+LIu4nKZWpsX4sq
 1SMWHIbvoAMBW9ldse1VDCU/7e37le6UM3YOt0+gSqheMYD+o0Rar/YVM
 15YAZYOhbpMU6oIRtpYYF4spReD0npBeCfOx4xPK7kBVnuKg5SXNNlkKV
 pajZiCv7mvCwB4LCEpUcpxrukqEzdZ1do54zCM1hfrQ19tcHR77V0lR5d Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="281576138"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="281576138"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 22:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="714905149"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 16 Mar 2022 22:43:44 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nUivH-000DLg-DO; Thu, 17 Mar 2022 05:43:43 +0000
Date: Thu, 17 Mar 2022 13:43:18 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.18] BUILD SUCCESS
 ce8d78616a6b637d1b763eb18e32045687a84305
Message-ID: <6232ca76.PKFhHE5xcqc7KTiI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_224346_658588_6A9626C6 
X-CRM114-Status: UNSURE (   7.33  )
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
branch HEAD: ce8d78616a6b637d1b763eb18e32045687a84305  nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH

elapsed time: 748m

configs tested: 131
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
powerpc                  storcenter_defconfig
sh                           sh2007_defconfig
m68k                       m5275evb_defconfig
xtensa                       common_defconfig
sh                           se7712_defconfig
powerpc                         wii_defconfig
h8300                            alldefconfig
arm                         nhk8815_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-64bit_defconfig
xtensa                           alldefconfig
sh                              ul2_defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
m68k                          atari_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         lpc18xx_defconfig
arm                         assabet_defconfig
m68k                       bvme6000_defconfig
arm                            xcep_defconfig
mips                           ip32_defconfig
sh                        edosk7705_defconfig
alpha                            alldefconfig
sh                          sdk7780_defconfig
arm                           stm32_defconfig
arm                        cerfcube_defconfig
sh                        dreamcast_defconfig
arm                      jornada720_defconfig
arm                         s3c6400_defconfig
powerpc                      arches_defconfig
powerpc                     taishan_defconfig
arm                  randconfig-c002-20220314
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nds32                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220314
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                     pseries_defconfig
powerpc                      katmai_defconfig
arm                          ixp4xx_defconfig
mips                           ip28_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc8272_ads_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64               randconfig-a012-20220314
x86_64               randconfig-a014-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a015-20220314
i386                 randconfig-a012-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a016-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220313
hexagon              randconfig-r041-20220313
hexagon              randconfig-r045-20220314
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

