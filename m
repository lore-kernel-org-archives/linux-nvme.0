Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44FDECAAD5
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5NCt04LeetadqvLDGvKXo5DLdqRr0De0ZqqWZxVsXA4=; b=LbgYKEBmB1m3yfR/O9V+CmpYx6
	w53Bb9tK/r6sM+TgBXAHlAFcFSUEffZ8XWurPyLwq6YCblTEuf5teEkHVyoy3v5czP8q0VirVIATj
	vaY6oFirot4/qmmzlLso7Cogx17jmVRxOiIu6KJO3+mEZNWNYN5s8pUxNod8OwWInD8Bg0eVR4XEo
	95esJhzvVwiCMPR83z6wYNnzOZ0V/mwrFBe7XGMN2pRfYTNzYGp4A9Tb9TV9WtKqW1Jhe9u6vEc3H
	KIirG/akSdLm4SP0wl04okLl39/Dks4vf1WPBeu9x4Evl3yFURH6JDqLSQQ17qAw09UKCE5ZjgmFm
	eOVhj5Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVd0A-00GFDW-OL; Tue, 06 Sep 2022 18:08:46 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVd07-00GFBt-7P
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 18:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662487723; x=1694023723;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7Jyd/3fMp6mYK6LAEIM6BDg+82UXSMPwlMyYNLLV58o=;
  b=KtjqCiFsxWb7+Dkqr9VDWhJEd6WUg/17VA0fpi2Xql0AKk5uDBzsJnKo
   72hY0pR9UIVn16RdHPAUFRW0HPrKjZ2qZXST3e1qZVi+d6ZklCsVQkpmv
   lDrtT9g6uMNK07e3qlUtk2Xs9Yl+0gKppFNQk9oKKIouVdsgX7l/hfWfD
   PMt8hPRHSuoT8/1wW9henT8GDuS87b56EBFycWlnQvr3whKqF/dnr55B0
   ekBIivWUCkHplq2QVPyhUIbeJN9UZHclLPJSv6blw3esKguKLYs7Tdwys
   1+U7wh+2bzZKy9rGT7iPmEIZyKZFf4dP0lS/37kSWXZtdyzDdjggFaEDT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360614540"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360614540"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 11:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942559113"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2022 11:08:38 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oVd01-0005Rh-33;
	Tue, 06 Sep 2022 18:08:37 +0000
Date: Wed, 07 Sep 2022 02:08:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.1] BUILD SUCCESS
 500e781dc0b0586b3e5ce20486406b02d0c1a26f
Message-ID: <63178c9f.glhFeYQOTOsdsBV+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_110843_432788_D5B9E3E7 
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.1
branch HEAD: 500e781dc0b0586b3e5ce20486406b02d0c1a26f  nvme: consider also host_iface when checking ip options

elapsed time: 749m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                        randconfig-a011
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                              allyesconfig
i386                             allyesconfig
i386                                defconfig
alpha                            allyesconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
sh                               allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
m68k                             allmodconfig
riscv                randconfig-r042-20220906
arc                  randconfig-r043-20220906
s390                 randconfig-r044-20220906
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
loongarch                           defconfig
loongarch                         allnoconfig
sparc64                             defconfig
sh                         apsh4a3a_defconfig
powerpc                       holly_defconfig
powerpc                         wii_defconfig
arm                            lart_defconfig
sh                               j2_defconfig
powerpc                 mpc85xx_cds_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                          polaris_defconfig
sh                   sh7770_generic_defconfig
ia64                                defconfig
powerpc                    klondike_defconfig
ia64                            zx1_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220906
i386                          randconfig-c001
powerpc                     tqm8541_defconfig
powerpc                 linkstation_defconfig
sh                           se7780_defconfig
mips                           xway_defconfig
arm                        trizeps4_defconfig
arm                        multi_v7_defconfig
powerpc                    adder875_defconfig
arm                         lpc18xx_defconfig
arm                            xcep_defconfig
powerpc                     tqm8548_defconfig
arm                          pxa3xx_defconfig
microblaze                      mmu_defconfig
sh                          r7785rp_defconfig
sh                     sh7710voipgw_defconfig
openrisc                         alldefconfig
arm                           tegra_defconfig
arm                          gemini_defconfig
sh                         ecovec24_defconfig
xtensa                generic_kc705_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arc                        nsim_700_defconfig
powerpc                        warp_defconfig
arm                      footbridge_defconfig
mips                     loongson1b_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
mips                     decstation_defconfig
powerpc                      ppc40x_defconfig
mips                           ci20_defconfig
arm                              allmodconfig
arm                       aspeed_g5_defconfig
m68k                          multi_defconfig
arm                        shmobile_defconfig
parisc                generic-32bit_defconfig
arc                         haps_hs_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                 mpc8313_rdb_defconfig
arm                            mmp2_defconfig
arm                    vt8500_v6_v7_defconfig
mips                  cavium_octeon_defconfig
mips                           ip27_defconfig
arm                         orion5x_defconfig
powerpc                      ppc64e_defconfig
powerpc                          allyesconfig
mips                          malta_defconfig
arm                        vexpress_defconfig
powerpc                    mvme5100_defconfig
arm                             mxs_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

