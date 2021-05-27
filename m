Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807ABC47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 02:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A3F613C5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 02:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A3F613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=p198E4jP+pXC7kOZWlMct7QcJKkvlUSLL4KjlphNFEw=; b=SoBZDc36f+tEuM
	2h2U5TA8els5YknOnC06+utTVUN5hrkiNcjnZbtep+c7rNn4jbanTj+gyUknUok0X6Xau5U0aUEsf
	wcuvG0LJcHiGj/SQ7SdLrq21YLuWK/wusx1S3dgJeIcoaN8Wb50TZh39nbfEKxDJqZzOuhdVLp2+D
	YZVEnOZnvuXwKB+SJTYIyvj4d8J1fRy5qwEppLELrHprn+19tjLjUTD0WewXMsnLOghflYWbeXT55
	XF3+ICnqPqhWaijzyLHe88t1O9E9PkuLYvh956iKudv4YDQV0hPC19tDbczZMKuYJ/yakAgBADKil
	NpEmWiFMy+Msx2wghMBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lm66D-001tcF-RE; Thu, 27 May 2021 02:50:17 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lm66A-001taL-Mk
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 02:50:16 +0000
IronPort-SDR: ZaukVzzXpSBIl+L6hUe3aHuxMisyQvopX3L0P7Fs2dVHk5uscJbuEpXPrY9iNfv0a8xP6ud6V5
 f7FWgVpRz79A==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202668855"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; d="scan'208";a="202668855"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2021 19:50:12 -0700
IronPort-SDR: 3zq3aNWnTINrx3BMK+/gdUMfkhydJ0+bA3tvPgtlwVdluzxGwsmdbZ3HbqtJu5ebyLyGtdntyb
 zNWky4/ffhYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; d="scan'208";a="444395739"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 26 May 2021 19:50:11 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lm666-0002XR-FC; Thu, 27 May 2021 02:50:10 +0000
Date: Thu, 27 May 2021 10:49:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 aaeadd7075dc9e184bc7876e9dd7b3bada771df2
Message-ID: <60af08bb.ELzo/jSMAlTt4IrL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_195014_840569_E035D91C 
X-CRM114-Status: UNSURE (   6.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-5.13
branch HEAD: aaeadd7075dc9e184bc7876e9dd7b3bada771df2  nvmet: fix false keep-alive timeout when a controller is torn down

elapsed time: 723m

configs tested: 184
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                         amcore_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc44x_defconfig
mips                        nlm_xlp_defconfig
powerpc                  iss476-smp_defconfig
powerpc                  mpc866_ads_defconfig
xtensa                         virt_defconfig
arm                          ep93xx_defconfig
s390                                defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm8548_defconfig
sh                           se7780_defconfig
arm                        spear3xx_defconfig
powerpc                    sam440ep_defconfig
sh                        edosk7760_defconfig
arm                          iop32x_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
powerpc                       maple_defconfig
sh                          sdk7780_defconfig
mips                      malta_kvm_defconfig
arm                         palmz72_defconfig
mips                       bmips_be_defconfig
arm                           sunxi_defconfig
mips                         rt305x_defconfig
arc                        vdk_hs38_defconfig
arc                      axs103_smp_defconfig
parisc                generic-32bit_defconfig
um                            kunit_defconfig
arm                          imote2_defconfig
powerpc                     tqm8560_defconfig
powerpc                     skiroot_defconfig
powerpc                           allnoconfig
m68k                        m5307c3_defconfig
sh                           se7712_defconfig
arm                        keystone_defconfig
arm                      footbridge_defconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
arm                     davinci_all_defconfig
sparc64                          alldefconfig
arm                          pxa910_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                     nsimosci_hs_defconfig
mips                         tb0287_defconfig
arm64                            alldefconfig
mips                        bcm47xx_defconfig
h8300                               defconfig
sh                     sh7710voipgw_defconfig
mips                           ip22_defconfig
powerpc                    amigaone_defconfig
mips                    maltaup_xpa_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       ebony_defconfig
mips                        vocore2_defconfig
mips                        workpad_defconfig
arm                          moxart_defconfig
mips                          malta_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc834x_mds_defconfig
mips                            ar7_defconfig
powerpc                      bamboo_defconfig
arm                           u8500_defconfig
arm                             ezx_defconfig
arm                         s3c2410_defconfig
parisc                           allyesconfig
sh                          r7780mp_defconfig
powerpc                    mvme5100_defconfig
mips                          ath79_defconfig
arm                          lpd270_defconfig
mips                          rm200_defconfig
riscv                    nommu_virt_defconfig
sh                           se7343_defconfig
powerpc                   lite5200b_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
alpha                               defconfig
mips                        omega2p_defconfig
arm                        mini2440_defconfig
arm                          badge4_defconfig
ia64                             alldefconfig
powerpc                 mpc836x_mds_defconfig
arm                      jornada720_defconfig
powerpc                      mgcoge_defconfig
openrisc                            defconfig
mips                     loongson1c_defconfig
m68k                             allmodconfig
arm                       omap2plus_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     mpc83xx_defconfig
microblaze                          defconfig
xtensa                           allyesconfig
arm                            qcom_defconfig
arm                       cns3420vb_defconfig
arc                        nsim_700_defconfig
mips                        nlm_xlr_defconfig
mips                     cu1830-neo_defconfig
arm                           corgi_defconfig
mips                     cu1000-neo_defconfig
parisc                generic-64bit_defconfig
sh                            shmin_defconfig
mips                           ci20_defconfig
arm                         hackkit_defconfig
m68k                         apollo_defconfig
um                             i386_defconfig
mips                        qi_lb60_defconfig
sparc                       sparc64_defconfig
arm                        mvebu_v5_defconfig
mips                      maltaaprp_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
i386                 randconfig-a011-20210526
i386                 randconfig-a016-20210526
i386                 randconfig-a015-20210526
i386                 randconfig-a012-20210526
i386                 randconfig-a014-20210526
i386                 randconfig-a013-20210526
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210526
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
