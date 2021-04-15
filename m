Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD79C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 18:47:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E5260FF0
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 18:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E5260FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5VSpo2dUIixigmAmNREZ//wSCtLcTmuR3oiVjNRQZx4=; b=NkIUpojaizFlN5RHiuU6UtP6KU
	Aqz0b4cZ7/AncrG60FiQZowFIaCFs6bdhwdfNuYYkCrf9q2+izQMxhzjK+1gS83rGj97EFbJ8rMH6
	9U2gWAmolNfO0J4DM7rR9NJHb/8oy5jjCu/ptnTPZAuSk2apjMBteYkArYJDwcChzcihTy6ck339X
	Ubp6sTwNeyVnqVw/Zac1Ro29VxA18Msdfx3OtFSD+EWjEcA/ru1f+oVwNR0AmPmeDE01G96xHeMUK
	2mzOWZHCqdnuIT6n1lxnkRPjrp3DnOAbTTbG4IVrqRxUvQoFfo6DkgYI+wdZ+VJ00l+ih+vf8ylk5
	FWFXa4uA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX71C-00H2DU-DO; Thu, 15 Apr 2021 18:47:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX71A-00H2D1-4n
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 18:47:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=2vJrUT65s1vD77t5QnSWsRrfNGiYmzo9fuTyMtVG980=; b=Sk8gLAGcJqPdOmLRRXcdu3UjMI
 byCV7SJH2CUuogVpXj+PNpx6ueaJVt4fpumCfDLm41v6z20biSglbAfJC+83m9ESYl8wnCCJ+fBgq
 03rsz3Jd68s37sKuiawaDhFcLbtv0B0lyXR4DMcyjJ1FNbtsaVyD8UeVgCJ2PaQnyV4Mz64nzz0Ie
 r4W23Z6vSO1LkVh0eNBVhMkd1PMdOWxmDvNHtbjwlncy8IsoqdTua2hy2rYcX86ne8bqQvjD/r7mb
 aWU2mR7SoIgmEJmzevLuVgTaOfX126Fh5tbxyv7kRUgdCFlqhX8+6vnGztD92aonVgGi4SDK21OSD
 DLY8CL/w==;
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX717-008ozB-1h
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 18:47:06 +0000
IronPort-SDR: /kcjEMp9toJM422b5wosrUROP2lpnjjmNYlPdVcK0RmnOeqqeFF41Iq1BfZ1bQyGi69nKeYsa2
 9uM36eqSf72g==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="191728610"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; d="scan'208";a="191728610"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 11:46:48 -0700
IronPort-SDR: IeqGDBgkVlkMrWHnJ5TeM7dykJspT5fSUnVGNn2mIUKyU4mYlYSrBmQMQHX8Z+TyeagXvRllpg
 nztsY/BFtjSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; d="scan'208";a="399667611"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 15 Apr 2021 11:46:47 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lX70o-00012i-BW; Thu, 15 Apr 2021 18:46:46 +0000
Date: Fri, 16 Apr 2021 02:45:45 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 d6609084b0b81abc74dc9db0281cdd0e074df5d4
Message-ID: <607889d9.LmM4v6QwBNSFaEel%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_114705_143022_07D78A1A 
X-CRM114-Status: UNSURE (   8.35  )
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
branch HEAD: d6609084b0b81abc74dc9db0281cdd0e074df5d4  nvme: fix NULL derefence in nvme_ctrl_fast_io_fail_tmo_show/store

elapsed time: 726m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
powerpc                    amigaone_defconfig
mips                        qi_lb60_defconfig
powerpc                 canyonlands_defconfig
m68k                             alldefconfig
arc                         haps_hs_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      makalu_defconfig
mips                         tb0287_defconfig
sh                        edosk7760_defconfig
powerpc                    mvme5100_defconfig
sparc64                             defconfig
m68k                            mac_defconfig
powerpc                   lite5200b_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
powerpc                     tqm8548_defconfig
powerpc                         ps3_defconfig
openrisc                         alldefconfig
sh                           se7751_defconfig
arm                        vexpress_defconfig
powerpc                    gamecube_defconfig
um                                  defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
sh                        apsh4ad0a_defconfig
powerpc                 mpc836x_mds_defconfig
arm                              alldefconfig
mips                   sb1250_swarm_defconfig
arm                          moxart_defconfig
arm                           sama5_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      arches_defconfig
arm                      integrator_defconfig
powerpc                        icon_defconfig
alpha                            alldefconfig
arm                            pleb_defconfig
arm                           stm32_defconfig
powerpc                     taishan_defconfig
arm                        keystone_defconfig
mips                        nlm_xlr_defconfig
arm                       omap2plus_defconfig
xtensa                generic_kc705_defconfig
alpha                            allyesconfig
powerpc                    sam440ep_defconfig
mips                           ip28_defconfig
arm                          pcm027_defconfig
m68k                       bvme6000_defconfig
powerpc                       eiger_defconfig
riscv                             allnoconfig
m68k                          hp300_defconfig
powerpc                 mpc8540_ads_defconfig
mips                          ath25_defconfig
sh                           sh2007_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         db1xxx_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ci20_defconfig
powerpc                     kilauea_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210415
x86_64               randconfig-a002-20210415
x86_64               randconfig-a005-20210415
x86_64               randconfig-a001-20210415
x86_64               randconfig-a006-20210415
x86_64               randconfig-a004-20210415
i386                 randconfig-a003-20210415
i386                 randconfig-a006-20210415
i386                 randconfig-a001-20210415
i386                 randconfig-a005-20210415
i386                 randconfig-a004-20210415
i386                 randconfig-a002-20210415
i386                 randconfig-a015-20210415
i386                 randconfig-a014-20210415
i386                 randconfig-a013-20210415
i386                 randconfig-a012-20210415
i386                 randconfig-a016-20210415
i386                 randconfig-a011-20210415
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210415
x86_64               randconfig-a015-20210415
x86_64               randconfig-a011-20210415
x86_64               randconfig-a013-20210415
x86_64               randconfig-a012-20210415
x86_64               randconfig-a016-20210415

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
