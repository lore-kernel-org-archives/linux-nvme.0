Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C9C388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 07:10:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692F820756
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 07:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="efS+geLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692F820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B3v980E6dYct/hWEBTCRZMaNYqW5G7/TaGN8fpaiBCM=; b=efS+geLjc6u1sLdp9FeJFd4Hy0
	MNY/Ndg+Z9He6CP+VtKFGUZz8IvPW+Zm78gjiS6hJwT+FZdrNByp+NEyrEbYruvLb3nfDgtn9wYfE
	MprT3Cw8bN/i4OYHovSzY1CL75N4/XF/UzpqdPASEovLg07FrmckyAQzgCoNXR38gDmSdHO4a+Obq
	FSqqQCbC6/4/bX8A6R99uLra+y1ShHjD1pmZetl9xn9WXuEX3rtYgmTmyDF7nByqEZqhlw7LXXTV9
	m4IUpoP6QUeAl1ehur4E5XEbaGjLTQSt5gOSN/EZJYqFsDn5KgjX9aUiGg80/dH6ndQdjk9zSCZ/a
	xgDzz4/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kckGR-0005Sh-QK; Wed, 11 Nov 2020 07:09:55 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kckGM-0005S9-T3
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 07:09:52 +0000
IronPort-SDR: nsMwIPcTtfKsd4fZp6+PpC+dqX8UDu9yp3JXqAryhhT5JbqCVRpbN2lV4Lhlt9UdLOTz+Q8sRj
 0jXo7a6Uxrsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="167521839"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; d="scan'208";a="167521839"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2020 23:09:49 -0800
IronPort-SDR: bq6uB3HuxwqCascElot9P0MlFCPjz+OIAmiABrlFU8DFK2V6X479Hg+j/WkhD+obMK+lwowtbi
 znuzfcYL1W4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; d="scan'208";a="428662771"
Received: from lkp-server02.sh.intel.com (HELO 898ef09051d7) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2020 23:09:48 -0800
Received: from kbuild by 898ef09051d7 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kckGJ-00004H-IS; Wed, 11 Nov 2020 07:09:47 +0000
Date: Wed, 11 Nov 2020 15:09:08 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 c8eed9f5b1ff75ff5a7e12d127f0dc5fe15012e3
Message-ID: <5fab8e14.O959c6zXHt+6CrCf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_020951_157096_A128646F 
X-CRM114-Status: GOOD (  12.14  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.11
branch HEAD: c8eed9f5b1ff75ff5a7e12d127f0dc5fe15012e3  nvmet: use inline bio for passthru fast path

elapsed time: 725m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                               defconfig
arm                             mxs_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
openrisc                 simple_smp_defconfig
arm                    vt8500_v6_v7_defconfig
arm                          pxa3xx_defconfig
arm                           corgi_defconfig
arm                            mmp2_defconfig
ia64                      gensparse_defconfig
ia64                             alldefconfig
powerpc                    sam440ep_defconfig
nios2                         10m50_defconfig
arm                          exynos_defconfig
xtensa                          iss_defconfig
powerpc                     skiroot_defconfig
sh                           se7751_defconfig
powerpc                     tqm5200_defconfig
xtensa                              defconfig
arm                        trizeps4_defconfig
xtensa                    xip_kc705_defconfig
arm                            hisi_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
powerpc                     tqm8541_defconfig
arm                          pcm027_defconfig
riscv                    nommu_virt_defconfig
sh                        dreamcast_defconfig
sh                     sh7710voipgw_defconfig
mips                           ip28_defconfig
h8300                     edosk2674_defconfig
arm                        mini2440_defconfig
sh                               j2_defconfig
powerpc                   currituck_defconfig
ia64                         bigsur_defconfig
sh                              ul2_defconfig
arc                          axs101_defconfig
mips                           jazz_defconfig
arm                            pleb_defconfig
nds32                             allnoconfig
sh                          r7780mp_defconfig
powerpc                       ebony_defconfig
alpha                               defconfig
arm                          lpd270_defconfig
powerpc                     ppa8548_defconfig
m68k                            q40_defconfig
arc                      axs103_smp_defconfig
parisc                              defconfig
x86_64                           alldefconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
i386                 randconfig-a006-20201110
i386                 randconfig-a005-20201110
i386                 randconfig-a002-20201110
i386                 randconfig-a001-20201110
i386                 randconfig-a003-20201110
i386                 randconfig-a004-20201110
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
x86_64               randconfig-a003-20201110
x86_64               randconfig-a005-20201110
x86_64               randconfig-a004-20201110
x86_64               randconfig-a002-20201110
x86_64               randconfig-a006-20201110
x86_64               randconfig-a001-20201110
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
