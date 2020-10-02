Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D89C4363D
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 05:19:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7202B206C3
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 05:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMFD3hT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7202B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j2KljEWsBZH4N6ueezoh1/74ShYreBxUIobCngfG5Xk=; b=HMFD3hT+AyKqBC/7pTLe3jNCFl
	jGPF6Ag1szYvEDHp62Z2OciawkPbeV9Sy7l8wUl9a6oPvSB1DaxzMdWPM+ui075Rhf6pr4MY3BV/B
	F8vgo2SJjHOC7Wi9CjbkeXaRV4xwSC4Wd1Gfa7K5cvsaarv3U5LlKZ0Y/lrSrAKWoxrVOth2BtR0t
	HXFDgQtCpe8A3pTigbaNrYpNd4nOVJfoY5BSPHYd/NkejOqu/UYY4bPgUp0TS1BTgG4MTAcHrEVmz
	wGYBMRuhojFMBOQtArXGy4xA/o/xZrnMdoaia78TLVgpgdn3Vy99CX+0sb2s7OJofxmcS02fU7ONT
	SHwkbihw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kODTD-0004sq-Mp; Fri, 02 Oct 2020 05:19:03 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kODT6-0004r4-G8
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 05:18:59 +0000
IronPort-SDR: HvwSQ3NxJKnzK7xs4sGvBQsXNZ5s9pnRQEqt/NKSiCa+UKO/4VXRtduXwXkN3HUNj15i/e+xp7
 1JC1rUEtY44g==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="142309488"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; d="scan'208";a="142309488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 22:18:49 -0700
IronPort-SDR: RGdLW78eHcYZ0n1C5a/Uhs763FgItntAQTd5v/1nEmJfxYjZqUB71410I+VBGE5i7Q6GnpLZKj
 uDQWCu5Q8jTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; d="scan'208";a="313376739"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 01 Oct 2020 22:18:48 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kODSx-0000rM-Gp; Fri, 02 Oct 2020 05:18:47 +0000
Date: Fri, 02 Oct 2020 13:18:03 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.10] BUILD SUCCESS
 5ad9675443f6e73deeb2245bf2affb73c92ae363
Message-ID: <5f76b80b.C3K5gHZ7AN6TLyse%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201002_011856_685964_CA730EDE 
X-CRM114-Status: GOOD (  10.99  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git  nvme-5.10
branch HEAD: 5ad9675443f6e73deeb2245bf2affb73c92ae363  nvme: remove nvme_identify_ns_list

elapsed time: 720m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          landisk_defconfig
sh                             sh03_defconfig
arm64                            alldefconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
arm                          gemini_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
riscv                             allnoconfig
arm                              alldefconfig
m68k                          hp300_defconfig
arc                      axs103_smp_defconfig
csky                             alldefconfig
sh                            shmin_defconfig
powerpc                        cell_defconfig
mips                malta_kvm_guest_defconfig
um                           x86_64_defconfig
sh                           se7724_defconfig
xtensa                    smp_lx200_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      pcm030_defconfig
ia64                        generic_defconfig
arc                            hsdk_defconfig
arm                             ezx_defconfig
sh                             shx3_defconfig
mips                     cu1830-neo_defconfig
arm                            mmp2_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
arm                          simpad_defconfig
s390                       zfcpdump_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
arm                           spitz_defconfig
h8300                               defconfig
arc                          axs101_defconfig
riscv                    nommu_k210_defconfig
sh                ecovec24-romimage_defconfig
alpha                               defconfig
powerpc                      ppc40x_defconfig
mips                          ath25_defconfig
arm                           efm32_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
arm                           viper_defconfig
i386                             alldefconfig
parisc                              defconfig
powerpc                    klondike_defconfig
xtensa                              defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc85xx_cds_defconfig
h8300                     edosk2674_defconfig
sh                                  defconfig
arm                           omap1_defconfig
mips                   sb1250_swarm_defconfig
arm                         axm55xx_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
microblaze                      mmu_defconfig
powerpc                          allmodconfig
nios2                               defconfig
riscv                            alldefconfig
arm                         palmz72_defconfig
powerpc                     ksi8560_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    mvme5100_defconfig
s390                             alldefconfig
arm                          pxa910_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
x86_64               randconfig-a012-20201001
x86_64               randconfig-a015-20201001
x86_64               randconfig-a014-20201001
x86_64               randconfig-a013-20201001
x86_64               randconfig-a011-20201001
x86_64               randconfig-a016-20201001
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
i386                 randconfig-a014-20201001
i386                 randconfig-a015-20201001
i386                 randconfig-a013-20201001
i386                 randconfig-a016-20201001
i386                 randconfig-a011-20201001
i386                 randconfig-a012-20201001
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930
x86_64               randconfig-a004-20201001
x86_64               randconfig-a001-20201001
x86_64               randconfig-a002-20201001
x86_64               randconfig-a003-20201001
x86_64               randconfig-a005-20201001
x86_64               randconfig-a006-20201001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
