Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F4EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0PLCmA063wbWlvDmMq4B8TbbKW4O9jMYtRXlrfbJGdA=; b=ojKbqcAIaKwZVmd6FWvcU6wM+A
	jCxKHJag1/3ttXLpofrjpSTpLWGGYoybTzEp4AcsyRtJJE7Pzm6u2gYrfnBtSDX4qStbk35LHHRzg
	7bjv14xIzBrhv+VRoEbNiS3H3W2fTXF6FOBo6iWV8cy7TeTGfaKdM+yW3R/DVtihJBiHkSqIddWtF
	T+pvi5Jhs+1c2mvfBjKSSA7GYmXxeZ0ceXVNfZkeKvM+/BPHS3FrvtDfwrvWltqMU7kJimQtKrx4U
	dcIRK7oLFybak4iRxNtzaPgo/KQDnmDM628jWNU+Orq339SvS8oGytLqBhury0X70u8fUwt2jBxRj
	T1jSdOlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw6CO-00C7Jz-4y; Tue, 31 May 2022 18:02:32 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw6CL-00C7J2-97
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 18:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654020149; x=1685556149;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FLChtdg9kMfBklf239bVe0ONUSMQjVhueB6HuxA40B0=;
  b=Hf6QxfnuFbg0GCrNScX70bezsMi63eKdTy/ZcWDBhMRR952epbZC41rk
   Te7y9a4AN/dO1+RDI+KenGz1YyqNMKa9y08uAVjLBOUg/+qhqlq6+wFTF
   AH6TrNYkWnc/i0ssBUVhlhzeeLFCTngQdQe7PaeGv+EA4qC68YCGAuj+z
   +sw+gWrG2GISvB+dbOTwyRcZLij0IWql1sl8FclTEERNgAqlmii64Dxfv
   wMYREiJmGzD2DgPTgzjfHlclt22DVj2CHkB3SA4yDMimrMuONw2rr4rzW
   SOgoOF0orQsPoYtkz/4RQCxn84nO0KlvyDCiu6VpXRqUJzW7rCy2AWBaI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275064931"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275064931"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 11:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="576523245"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 May 2022 11:02:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1nw6CC-0002wc-50;
	Tue, 31 May 2022 18:02:20 +0000
Date: Wed, 01 Jun 2022 02:01:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.19] BUILD SUCCESS
 cbf84dbf0600b0efe1134cc3f98ae29c523a3a23
Message-ID: <629657f4.8tC3riI94wVQ8D5I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_110229_412870_8AA107EA 
X-CRM114-Status: UNSURE (   7.49  )
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
branch HEAD: cbf84dbf0600b0efe1134cc3f98ae29c523a3a23  nvmet: fix typo in comment

elapsed time: 720m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                  sh7785lcr_32bit_defconfig
arm64                            alldefconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
sh                        sh7763rdp_defconfig
powerpc                      pcm030_defconfig
m68k                             allmodconfig
xtensa                  cadence_csp_defconfig
arm                        realview_defconfig
arm                        mvebu_v7_defconfig
arm                        spear6xx_defconfig
sh                     magicpanelr2_defconfig
m68k                       bvme6000_defconfig
arm                          badge4_defconfig
arc                                 defconfig
xtensa                  nommu_kc705_defconfig
arm                            zeus_defconfig
alpha                            alldefconfig
powerpc                      mgcoge_defconfig
parisc                           alldefconfig
h8300                               defconfig
ia64                         bigsur_defconfig
sh                        dreamcast_defconfig
parisc                generic-64bit_defconfig
arm                        clps711x_defconfig
h8300                            alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                       bmips_be_defconfig
h8300                            allyesconfig
sh                          r7780mp_defconfig
microblaze                          defconfig
sh                          rsk7269_defconfig
powerpc                 linkstation_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220531
s390                 randconfig-r044-20220531
riscv                randconfig-r042-20220531
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                 randconfig-c004-20220531
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220531
arm                  randconfig-c002-20220531
powerpc              randconfig-c003-20220531
riscv                randconfig-c006-20220531
arm                            mmp2_defconfig
mips                       rbtx49xx_defconfig
powerpc                     mpc512x_defconfig
arm                             mxs_defconfig
mips                      maltaaprp_defconfig
powerpc                     tqm5200_defconfig
powerpc                     akebono_defconfig
powerpc                   lite5200b_defconfig
arm                   milbeaut_m10v_defconfig
mips                         tb0287_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

