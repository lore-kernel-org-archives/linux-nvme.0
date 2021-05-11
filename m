Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD18FC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 11:09:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399CE6134F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 11:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399CE6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6T55SabSItyyn1pJlRThQTr1vVt2eDJag53vmReCX9k=; b=K/2LI8AIu4JVMTS3qZu6yzh7cP
	TWf/05rxB1MsmQlhM8euG9RnX8A2Y1gz97GerWilLgPNYTMIbTfx6qumSME1CdmDYhnuPpr6cdIgb
	L9lh726svh3xiTX1eJHFx1R0Sw1X05U0yR3St/SO89ZWcGghsgjVQFCnpLyKZPbrWCzWdIpim/Xwg
	VGRGasltyAlSmYvirCP+v4eBj7wHqiu2DjIF3vcpsCSj4C2ksiS+020LNur7ghNwTMnxkNZ91Vycz
	kDsd5h3scCkMW9XsCyUbj5DgiNQ0MY0yp+MVKhdNWN9g6LA/Z9ZCtlHJ+U+P8mjv2LRvc3X5ENxyH
	smITdDJA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgQG8-00H4ls-Bx; Tue, 11 May 2021 11:09:04 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgHQi-00G3rU-0i
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 01:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=kxsyAmPjSUPIhEfZYf98p/rC07x4baj50rPXVJG/nvc=; b=02H5ln1NhhAufmTvVxTt1BLC9e
 HEQzjeqhuTDvTa6nPUPkn3O2JXDEHeCxyKKILKthReqMEs4faQkbMhm9I5mXGIuN5Zwq8zGuU6942
 qQor3RU3HcH9rapY6f4+XdfDJqL771Z1jOD/d1hFynzAz7YSAXOsscy/Abz5PSYN+WYHQ8VvEUrnU
 gs/0IjIGd3mzJiG3uhZBDZBQg8JL8fjCyyHEGdo0CZhWnYtmfoR56oWiTMvpu0CTJZp84NIzCF9VO
 P7MKVgaMPgHrxVnjs5zHT1woKWgxLyk152CTZ0Zt1yj2Ppam5MJIedBaGJmQVwZHxFfbM1a0xF0H6
 OjSqajhA==;
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgHQZ-009FAD-O3
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 01:43:17 +0000
IronPort-SDR: IpxE+YkX0PzcRHv+Ub5lexqMDh16L8OpZ5oV6mLxMVydFaPRsclfLsZBRCEg0UMVzHBBJl2xWC
 F7wmC8ZeuwOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199006741"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="199006741"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 18:43:09 -0700
IronPort-SDR: mra3kCrTOxq3+zaP1YjjBtkVbhF0x1cK54jvz4NzCZb6SJfQkdEp9Zv6tDQOpg5t5GZo9R5FJS
 5eTMCqwkyQMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="408585699"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 10 May 2021 18:43:07 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lgHQR-0000Sd-9L; Tue, 11 May 2021 01:43:07 +0000
Date: Tue, 11 May 2021 09:43:03 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 2869ad623d7df02dbc280744b879ca6e23ad1fe4
Message-ID: <6099e127.B8QkYz3p7FgYKmJ1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_184315_835130_56DC1305 
X-CRM114-Status: UNSURE (   6.74  )
X-CRM114-Notice: Please train this message.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_184315_835130_56DC1305 
X-CRM114-Status: UNSURE (   1.52  )
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
branch HEAD: 2869ad623d7df02dbc280744b879ca6e23ad1fe4  nvme-multipath: fix double initialization of ANA state

elapsed time: 727m

configs tested: 180
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
h8300                     edosk2674_defconfig
sh                          landisk_defconfig
powerpc                    mvme5100_defconfig
powerpc                     sbc8548_defconfig
mips                             allmodconfig
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig
h8300                            alldefconfig
sh                          lboxre2_defconfig
nds32                               defconfig
m68k                                defconfig
sh                          urquell_defconfig
arm                         at91_dt_defconfig
arc                         haps_hs_defconfig
mips                       capcella_defconfig
powerpc                      obs600_defconfig
arm64                            alldefconfig
powerpc                mpc7448_hpc2_defconfig
arm                           tegra_defconfig
arm                            mps2_defconfig
powerpc                    sam440ep_defconfig
arm                       aspeed_g4_defconfig
sh                          polaris_defconfig
powerpc                     tqm5200_defconfig
arm                            xcep_defconfig
powerpc                      ppc44x_defconfig
mips                        workpad_defconfig
arm                       aspeed_g5_defconfig
arm                           u8500_defconfig
arm                          iop32x_defconfig
mips                          ath25_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      chrp32_defconfig
nios2                            alldefconfig
powerpc64                           defconfig
mips                        omega2p_defconfig
arm                         lpc32xx_defconfig
sparc                       sparc32_defconfig
mips                       lemote2f_defconfig
powerpc                  mpc866_ads_defconfig
arm                            lart_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
arm                        trizeps4_defconfig
arm                       cns3420vb_defconfig
m68k                          sun3x_defconfig
arc                          axs101_defconfig
sh                      rts7751r2d1_defconfig
sh                   secureedge5410_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             allyesconfig
arc                        vdk_hs38_defconfig
csky                                defconfig
mips                          ath79_defconfig
mips                  cavium_octeon_defconfig
ia64                             alldefconfig
powerpc                    klondike_defconfig
mips                          rm200_defconfig
sh                              ul2_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                          g5_defconfig
arm                      footbridge_defconfig
arm                       multi_v4t_defconfig
sh                        sh7757lcr_defconfig
mips                        nlm_xlp_defconfig
nios2                               defconfig
arm                         cm_x300_defconfig
arm                       imx_v6_v7_defconfig
sh                          rsk7269_defconfig
powerpc                     skiroot_defconfig
mips                         cobalt_defconfig
arc                          axs103_defconfig
mips                     loongson2k_defconfig
sh                   sh7724_generic_defconfig
arm                            hisi_defconfig
mips                         tb0226_defconfig
riscv                    nommu_k210_defconfig
arm                         bcm2835_defconfig
powerpc                       ebony_defconfig
sh                          r7785rp_defconfig
riscv                    nommu_virt_defconfig
arm                       versatile_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         microdev_defconfig
mips                        maltaup_defconfig
arm                        multi_v5_defconfig
mips                           ci20_defconfig
arm                          pxa3xx_defconfig
sh                               j2_defconfig
powerpc                   currituck_defconfig
mips                            gpr_defconfig
arm                          ixp4xx_defconfig
arm                            mmp2_defconfig
m68k                         amcore_defconfig
powerpc                 canyonlands_defconfig
mips                 decstation_r4k_defconfig
sh                          rsk7201_defconfig
riscv                            alldefconfig
powerpc                     rainier_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
powerpc                    socrates_defconfig
powerpc                     pseries_defconfig
m68k                       m5275evb_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc836x_mds_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210510
x86_64               randconfig-a004-20210510
x86_64               randconfig-a001-20210510
x86_64               randconfig-a005-20210510
x86_64               randconfig-a002-20210510
x86_64               randconfig-a006-20210510
i386                 randconfig-a003-20210510
i386                 randconfig-a001-20210510
i386                 randconfig-a005-20210510
i386                 randconfig-a004-20210510
i386                 randconfig-a002-20210510
i386                 randconfig-a006-20210510
i386                 randconfig-a016-20210510
i386                 randconfig-a014-20210510
i386                 randconfig-a011-20210510
i386                 randconfig-a015-20210510
i386                 randconfig-a012-20210510
i386                 randconfig-a013-20210510
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210510
x86_64               randconfig-a012-20210510
x86_64               randconfig-a011-20210510
x86_64               randconfig-a013-20210510
x86_64               randconfig-a016-20210510
x86_64               randconfig-a014-20210510

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
