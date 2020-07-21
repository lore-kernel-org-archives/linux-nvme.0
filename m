Return-Path: <SRS0=MSYC=BA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A9C433E4
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 07:07:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6135A21702
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 07:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wgAp+WHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6135A21702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fFEVthN2P/YLomFwyRLThOflV58f5MZpbLhv+Zb44J8=; b=wgAp+WHayqHP3h4nyp/NEbikkO
	JsgnVi2RG87a7v5qPjRYOXbK+ST9HtrHqN5r4xx6XGnOtSI3+C6j1U2j6G9AVOfrQ9tXc9+TFMUu2
	Xm+I5I96hZv4gwNh7tZcLObZoRqeI/Hh24bDlx0psCKvTEe/jQ2Pb6lSn/HduH8ZNAp+VMwjwTQk6
	Ym4BxQ5JRC5xpth9vkQS8oh7TJ0pF9msxKLAx8K47pLa0stdL+9ND/7scCrSR5KvupJvhMHHCr9ou
	QqYe6Q1Nlko+qfbTJ7DtKv+0SjGzjtLyVM30wX/Ys8g//KpgFSbtq7SBPQcwflZst50++feGzOXRd
	LWFlDXtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxmN0-0006eB-1u; Tue, 21 Jul 2020 07:07:22 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxmMw-0006cq-78
 for linux-nvme@lists.infradead.org; Tue, 21 Jul 2020 07:07:19 +0000
IronPort-SDR: zugci/JpAwktvSEidrLRVtVyB4bVUEZqzLqCTzTb2RI7VBtqMpXunq1m9i3xqd7cREWVmG/boc
 nnxmmkxdjJPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="147578658"
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; d="scan'208";a="147578658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2020 00:07:14 -0700
IronPort-SDR: 662oeqNJoDVypSGpIBC3Qr87KguS8s6QHwF6MeYlOrEGz8xIhCyStppxSZJM+smHlkZaHCTRw/
 a1JKOrcb+ImQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; d="scan'208";a="271643701"
Received: from lkp-server02.sh.intel.com (HELO 12bd1abd8ab8) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2020 00:07:13 -0700
Received: from kbuild by 12bd1abd8ab8 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1jxmMq-00001P-CW; Tue, 21 Jul 2020 07:07:12 +0000
Date: Tue, 21 Jul 2020 15:05:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.9] BUILD SUCCESS
 e40d5c54cc0e827f34b9497a67a561aade822129
Message-ID: <5f1693b4.hkDBpDlYzX+gS0c2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200721_030718_458971_4AF92684 
X-CRM114-Status: UNSURE (   9.39  )
X-CRM114-Notice: Please train this message.
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.9
branch HEAD: e40d5c54cc0e827f34b9497a67a561aade822129  nvmet: use xarray for ctrl ns storing

elapsed time: 1047m

configs tested: 114
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                     eseries_pxa_defconfig
c6x                                 defconfig
arc                         haps_hs_defconfig
arm                        realview_defconfig
arm                          lpd270_defconfig
c6x                         dsk6455_defconfig
m68k                         amcore_defconfig
arm                          simpad_defconfig
openrisc                         allyesconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
arm                      footbridge_defconfig
s390                             alldefconfig
c6x                               allnoconfig
arm                            zeus_defconfig
sh                ecovec24-romimage_defconfig
arm                       netwinder_defconfig
mips                        nlm_xlr_defconfig
powerpc                        cell_defconfig
s390                          debug_defconfig
arm                          pxa3xx_defconfig
m68k                        m5407c3_defconfig
sh                          sdk7780_defconfig
arm                           h5000_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a014-20200720
x86_64               randconfig-a015-20200720
x86_64               randconfig-a016-20200720
x86_64               randconfig-a012-20200720
x86_64               randconfig-a013-20200720
x86_64               randconfig-a011-20200720
x86_64               randconfig-a005-20200719
x86_64               randconfig-a002-20200719
x86_64               randconfig-a006-20200719
x86_64               randconfig-a001-20200719
x86_64               randconfig-a003-20200719
x86_64               randconfig-a004-20200719
i386                 randconfig-a015-20200719
i386                 randconfig-a011-20200719
i386                 randconfig-a016-20200719
i386                 randconfig-a012-20200719
i386                 randconfig-a013-20200719
i386                 randconfig-a014-20200719
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
