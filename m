Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B1C433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 19:00:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141B8610CF
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 19:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141B8610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p3sZrPYS2LBddaElbfXsaa82auLQ2iLvRBUUvJga/as=; b=CUstBU/DF+OCnRKbs/jyctA8ve
	YOaMDdiEsxKxFjrPSn5PHBo7v+S9TB4V0ZIYTjbBG6DTLyBksaofiyYnGG9FDAxBuQCk4xgOqvWJO
	xDswLFJfib+ZYKBi3DT9OoInHbl/MrAcglI2aSpNUqmX/ZqxmHcoN/8N8/K3kHjNwz7P1sx/7Cop3
	FoUMOwxWD8iGnyBIeUozoE2gSsZ0VdxEyKs6olcDKqkbJs9Vnup5/fDJtBQX6KVpXtVh8maEV1C0W
	YOEYbJ5SgkaC1O0wuBjA3XRSdohO5TqFr+bmVzd6GrJJs9fVrOUwCl5cnD2YJxn7QD+EjR02LIkdd
	wxFczCOg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVIq9-003INK-MX; Sat, 10 Apr 2021 19:00:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVIpp-003IMb-Ja
 for linux-nvme@desiato.infradead.org; Sat, 10 Apr 2021 18:59:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=x70a1D30nOt5QVKP+NqkBvjt9Q1bkQ7DTci3gsoF7fE=; b=RJWASY8+snTrMLDtn5y5mJa0lb
 eZcQjF6n2NmaC2PLELzfZrN1imcvPp6yY41DBBkUvodLZlZ4Zy40BXL6GquQzfn7eB3wGAjQ/YiO/
 jusMA4K0FqvzJFKzZbmZokqHjNcFppfzGPu61ixZD6QLTOZeyrFMINaXdqPlv7NfMLBGMzDbgcLY0
 m6+pbYsI2Tn3Nx2ZRf+VsYRXGYNYiAccfGvnAQ5hAMwXAxpRsPDmt51BSrQEBtBWtcvl005pUykLf
 y9zcI70TxsDqe6WxiYGCr0c9pRila1nvAausDcUpCzQLQ+kZmyY1cf5ZR/t2qe+xqTMSxUxjiN4Sb
 tOyEQMNA==;
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVIpm-005DrC-Pl
 for linux-nvme@lists.infradead.org; Sat, 10 Apr 2021 18:59:56 +0000
IronPort-SDR: l/0T1Nshs9zbKcvEmhrmT37Zwrd8bT5XY8bNVmCRbuFRSAf3RHKddh+wNXqZHvdU43BBlZ+3LW
 5lGfEzS32Zpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="193509112"
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; d="scan'208";a="193509112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2021 11:59:52 -0700
IronPort-SDR: Sr0RbwLwLLyKvok1ovAO3VFfKftSREtgOmU/9LxN47/BGRZlo4j84VjN0SkC38s3SKSLO8fDyL
 eSSELIuAy2uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; d="scan'208";a="520660765"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2021 11:59:51 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lVIpj-000IYI-01; Sat, 10 Apr 2021 18:59:51 +0000
Date: Sun, 11 Apr 2021 02:59:35 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-5.13] BUILD SUCCESS
 ec395d894108e5ca9584ec188155900586fda04b
Message-ID: <6071f597.CEdAERfyNecxiam+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210410_115954_887920_DF0A093B 
X-CRM114-Status: UNSURE (   6.53  )
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
branch HEAD: ec395d894108e5ca9584ec188155900586fda04b  nvme: let namespace probing continue for unsupported features

elapsed time: 722m

configs tested: 92
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
arm                          gemini_defconfig
powerpc                     ep8248e_defconfig
mips                        workpad_defconfig
um                                allnoconfig
nds32                               defconfig
mips                       bmips_be_defconfig
sh                            shmin_defconfig
arm                        multi_v7_defconfig
arc                          axs101_defconfig
sh                          sdk7780_defconfig
openrisc                 simple_smp_defconfig
xtensa                  audio_kc705_defconfig
arm                          badge4_defconfig
arm                      jornada720_defconfig
sh                           se7780_defconfig
sh                          lboxre2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210409
i386                 randconfig-a003-20210409
i386                 randconfig-a001-20210409
i386                 randconfig-a004-20210409
i386                 randconfig-a002-20210409
i386                 randconfig-a005-20210409
x86_64               randconfig-a014-20210410
x86_64               randconfig-a015-20210410
x86_64               randconfig-a011-20210410
x86_64               randconfig-a013-20210410
x86_64               randconfig-a012-20210410
x86_64               randconfig-a016-20210410
i386                 randconfig-a015-20210410
i386                 randconfig-a014-20210410
i386                 randconfig-a013-20210410
i386                 randconfig-a012-20210410
i386                 randconfig-a016-20210410
i386                 randconfig-a011-20210410
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210409
x86_64               randconfig-a005-20210409
x86_64               randconfig-a003-20210409
x86_64               randconfig-a001-20210409
x86_64               randconfig-a002-20210409
x86_64               randconfig-a006-20210409

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
