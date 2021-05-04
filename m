Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC78C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 20:11:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6290C611AC
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 20:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6290C611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lccb1NYiWlByP13y440PAcoBDIXfIx/gRnZbD9bFfy8=; b=MVolwm41vDFmmOBfAtpLvTFDdt
	NPfcDO0WJXqNIg8vCtq2+i1knFr1BhXsii1Uo2ItFquur7Y9fV7f2rNnhKJ6UCArMQ/LsRiIzmSN/
	DB0I8Cn5P8exjX3dqMfU9IJ2k5AgldkRvQgkFsaH3fVvukrRBygUdFel8719wTZhcpFxpMo9QqNWe
	L5BFXMSICDlx0Lulrx6iLQ0lMQzLGip4TnnMtcTZY1nM5lqWfH7MSPGnz8g+1Mp0vfqC9qFSpbzjd
	wGwJI/HbmAcV+DvlxOaoTYUZz/Wu4iB5DgPSqLDPlgWuj6+serhczigDzWqFz7t8iiQRfdrxG/RlV
	hb38cU0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le1OK-00GzaQ-1K; Tue, 04 May 2021 20:11:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1OH-00Gza2-Dv
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 20:11:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=R/UYI1Kk9efUsM9Cwd/jexEknFu703dg3kP27IRW5Fw=; b=fkjMO4gO3NC39Tgx0OrxJtK0DF
 Z+4i+T2dosVhv6wsXZ44ZS1ReN8raEtYYSXKu07b5ZKE4viE35gfpbq8rSFDXbcFe45ZO3PltzOFx
 HgpjS35yNEejES2Xq4EE+0quVUO622O95edX6UyNCYMQkulLK30SdZTlaudvpt8Y5pSUNUBWagKDA
 k2824O5GNft87uJZ190B7moncfRMAo4eLqIGcFlXe7F2yjAQcBHHljHauoDKQjy8seGpk6MAfscLO
 YHslutfvwxfi6HVq7MUJJhjBrydmDCImBd0N+CXt4WJwN8FtAXp2RmJje5Xt1g6MRDDmYv1cUDSol
 DFl+LGNg==;
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1OD-004F1r-VL
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 20:11:31 +0000
IronPort-SDR: HdPZYXCRsuSNRZBnX07T3bhP+qEQCWEWmK9aSTdquPiy0AkvXKXgHpLbuyiFXKtCtGJ+L7LaNr
 cf7TqcN6QkLQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="185201934"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="185201934"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 13:11:28 -0700
IronPort-SDR: DpKpy3c2NugpR1sbR6F0nqfGVDrySNilG+LM14f8XyeLqY3uuxod2mkYW6fw1+eJp867SizZwP
 JSZ+aF5lxj5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="531305882"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 04 May 2021 13:11:26 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1le1OA-0009iw-7W; Tue, 04 May 2021 20:11:26 +0000
Date: Wed, 05 May 2021 04:11:07 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 4a20342572f66c5b20a1ee680f5ac0a13703748f
Message-ID: <6091aa5b.YA8LLq860LpcCVHl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_131130_097280_C93C9BD3 
X-CRM114-Status: UNSURE (   8.62  )
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
branch HEAD: 4a20342572f66c5b20a1ee680f5ac0a13703748f  nvmet: remove unsupported command noise

elapsed time: 726m

configs tested: 121
configs skipped: 2

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
i386                             allyesconfig
riscv                            allyesconfig
powerpc                     akebono_defconfig
mips                        workpad_defconfig
powerpc                     pseries_defconfig
arm                          exynos_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         at91_dt_defconfig
arm                        vexpress_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc836x_mds_defconfig
mips                     cu1830-neo_defconfig
sh                             sh03_defconfig
nios2                            allyesconfig
xtensa                    smp_lx200_defconfig
sh                        dreamcast_defconfig
arc                        nsimosci_defconfig
sh                      rts7751r2d1_defconfig
xtensa                         virt_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       bvme6000_defconfig
mips                      maltaaprp_defconfig
arm                         hackkit_defconfig
mips                         tb0219_defconfig
arm                       imx_v6_v7_defconfig
m68k                       m5249evb_defconfig
arm                      pxa255-idp_defconfig
xtensa                  cadence_csp_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8313_rdb_defconfig
sparc64                             defconfig
riscv             nommu_k210_sdcard_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                       m5475evb_defconfig
sh                              ul2_defconfig
openrisc                            defconfig
arm                             rpc_defconfig
parisc                generic-32bit_defconfig
sh                          rsk7201_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210504
i386                 randconfig-a006-20210504
i386                 randconfig-a001-20210504
i386                 randconfig-a005-20210504
i386                 randconfig-a004-20210504
i386                 randconfig-a002-20210504
x86_64               randconfig-a014-20210504
x86_64               randconfig-a015-20210504
x86_64               randconfig-a012-20210504
x86_64               randconfig-a013-20210504
x86_64               randconfig-a011-20210504
x86_64               randconfig-a016-20210504
i386                 randconfig-a015-20210504
i386                 randconfig-a013-20210504
i386                 randconfig-a016-20210504
i386                 randconfig-a014-20210504
i386                 randconfig-a012-20210504
i386                 randconfig-a011-20210504
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a014-20210503
x86_64               randconfig-a015-20210503
x86_64               randconfig-a012-20210503
x86_64               randconfig-a011-20210503
x86_64               randconfig-a013-20210503
x86_64               randconfig-a016-20210503
x86_64               randconfig-a001-20210504
x86_64               randconfig-a003-20210504
x86_64               randconfig-a005-20210504
x86_64               randconfig-a002-20210504
x86_64               randconfig-a006-20210504
x86_64               randconfig-a004-20210504

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
