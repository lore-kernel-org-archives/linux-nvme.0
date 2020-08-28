Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70669C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 10:55:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE9F2098B
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 10:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a5NmNY3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE9F2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hbJ23WBY5qKaGKO+T7ZvsipHQV8LZGsICdJ6ED1tSyM=; b=a5NmNY3Vp9WaEyZMPyMdUSASKu
	zzaPIW4leiJH053TxoSyLy2IH5xbZlflsJSKzSOAiFemZMC0tXiS4Fy7gGbUqiqUACLlM8ng3YghJ
	2w05rznHv0PjLIPrNPnchlsgvgpd/7G53qaSUESycNG/sAvnkW2v0aDuhfosQvW0dkliAkDzC7It6
	fF9s4+XOJv8G8ybCSo3NgAzjfINxSNW5EKffKwfd3g07rPQFxB9FnrBr4KaRrxtpyDrS0zmTWiiC+
	ZV0jp6M5UeKmqPzcCnkTGdKuxPQ58sMaxiyJZfVWsjLgYjhASqZCN+1c/4Wgz8sEdN2WfafRJiu9V
	w+ar8ydw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBc2R-00017h-AW; Fri, 28 Aug 2020 10:55:19 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBc2L-00017C-3r
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 10:55:14 +0000
IronPort-SDR: SF4gLzJuBNeY9Zfi7eXPh63T/MR0vm1aJXfLme2Ex2UBgY1ZeMLAGzQxCbvTVx7ogQRXYY2nR0
 Ew9z6jcROykg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="157669734"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; d="scan'208";a="157669734"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2020 03:55:11 -0700
IronPort-SDR: eaZVrteCIaud3IVfrKcSGyRjtkvIUJ2rMbn3IFZrHKeDojDJpm1vajtXvVqZ3wCn89Gp4Ec+Zk
 EvWSVjDTWIIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; d="scan'208";a="403719952"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2020 03:55:10 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kBc2H-0002eB-HT; Fri, 28 Aug 2020 10:55:09 +0000
Date: Fri, 28 Aug 2020 18:54:55 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: [linux-nvme:nvme-5.9-rc] BUILD SUCCESS WITH WARNING
 82e3e51f2fb2246eee837fa4aeee79ec1f921c89
Message-ID: <5f48e27f.8fDcXMSo1IZRpjNr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_065513_320078_84A65BF1 
X-CRM114-Status: GOOD (  13.23  )
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

tree/branch: git://git.infradead.org/nvme.git  nvme-5.9-rc
branch HEAD: 82e3e51f2fb2246eee837fa4aeee79ec1f921c89  nvme: only use power of two io boundaries

Warning in current branch:

include/uapi/linux/byteorder/big_endian.h:33:27: warning: 'buflen' is used uninitialized in this function [-Wuninitialized]
include/uapi/linux/byteorder/little_endian.h:33:27: warning: 'buflen' is used uninitialized in this function [-Wuninitialized]
include/uapi/linux/swab.h:120:2: warning: 'buflen' is used uninitialized in this function [-Wuninitialized]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- alpha-allyesconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- arc-allyesconfig
|   `-- include-uapi-linux-swab.h:warning:buflen-is-used-uninitialized-in-this-function
|-- c6x-allyesconfig
|   `-- include-uapi-linux-swab.h:warning:buflen-is-used-uninitialized-in-this-function
|-- h8300-allyesconfig
|   `-- include-uapi-linux-swab.h:warning:buflen-is-used-uninitialized-in-this-function
|-- i386-allyesconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- i386-randconfig-a001-20200827
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- ia64-allmodconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- m68k-allmodconfig
|   `-- include-uapi-linux-swab.h:warning:buflen-is-used-uninitialized-in-this-function
|-- m68k-allyesconfig
|   `-- include-uapi-linux-swab.h:warning:buflen-is-used-uninitialized-in-this-function
|-- mips-allmodconfig
|   `-- include-uapi-linux-byteorder-big_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- mips-allyesconfig
|   `-- include-uapi-linux-byteorder-big_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- mips-randconfig-r034-20200828
|   `-- include-uapi-linux-byteorder-big_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- nios2-allyesconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- parisc-allyesconfig
|   `-- include-uapi-linux-swab.h:warning:buflen-is-used-uninitialized-in-this-function
|-- powerpc-allmodconfig
|   `-- include-uapi-linux-byteorder-big_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- powerpc-allyesconfig
|   `-- include-uapi-linux-byteorder-big_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- riscv-allmodconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- riscv-allyesconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- s390-allyesconfig
|   `-- include-uapi-linux-byteorder-big_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- sh-allmodconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- sparc-allyesconfig
|   `-- include-uapi-linux-swab.h:warning:buflen-is-used-uninitialized-in-this-function
|-- x86_64-allmodconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- x86_64-allyesconfig
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- x86_64-rhel
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
|-- x86_64-rhel-8.3
|   `-- include-uapi-linux-byteorder-little_endian.h:warning:buflen-is-used-uninitialized-in-this-function
`-- xtensa-allyesconfig
    `-- include-uapi-linux-swab.h:warning:buflen-is-used-uninitialized-in-this-function

elapsed time: 724m

configs tested: 135
configs skipped: 13

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
sh                           se7721_defconfig
sparc                               defconfig
sh                           se7206_defconfig
s390                             alldefconfig
mips                         bigsur_defconfig
sh                   sh7770_generic_defconfig
arm                          iop32x_defconfig
c6x                              alldefconfig
arm                          pxa168_defconfig
sh                           se7722_defconfig
parisc                generic-64bit_defconfig
mips                           rs90_defconfig
m68k                       bvme6000_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
m68k                        m5272c3_defconfig
sh                            migor_defconfig
arm                        multi_v7_defconfig
mips                        bcm47xx_defconfig
c6x                        evmc6474_defconfig
microblaze                    nommu_defconfig
sparc64                          alldefconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                          alldefconfig
arc                           tb10x_defconfig
m68k                           sun3_defconfig
sh                           se7780_defconfig
arm                    vt8500_v6_v7_defconfig
sh                             sh03_defconfig
arm                         mv78xx0_defconfig
arc                              allyesconfig
arm                         lpc18xx_defconfig
mips                        jmr3927_defconfig
arm                          exynos_defconfig
arm                          pxa910_defconfig
arm                          lpd270_defconfig
mips                    maltaup_xpa_defconfig
sh                             shx3_defconfig
arm                            u300_defconfig
mips                malta_kvm_guest_defconfig
mips                  cavium_octeon_defconfig
arc                             nps_defconfig
arm                       spear13xx_defconfig
arm                         ebsa110_defconfig
ia64                      gensparse_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc8272_ads_defconfig
arm                             rpc_defconfig
arc                        nsim_700_defconfig
microblaze                          defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
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
powerpc                             defconfig
x86_64               randconfig-a003-20200827
x86_64               randconfig-a002-20200827
x86_64               randconfig-a001-20200827
x86_64               randconfig-a005-20200827
x86_64               randconfig-a006-20200827
x86_64               randconfig-a004-20200827
i386                 randconfig-a002-20200828
i386                 randconfig-a005-20200828
i386                 randconfig-a003-20200828
i386                 randconfig-a004-20200828
i386                 randconfig-a001-20200828
i386                 randconfig-a006-20200828
i386                 randconfig-a002-20200827
i386                 randconfig-a004-20200827
i386                 randconfig-a003-20200827
i386                 randconfig-a005-20200827
i386                 randconfig-a006-20200827
i386                 randconfig-a001-20200827
x86_64               randconfig-a015-20200828
x86_64               randconfig-a012-20200828
x86_64               randconfig-a016-20200828
x86_64               randconfig-a014-20200828
x86_64               randconfig-a011-20200828
x86_64               randconfig-a013-20200828
i386                 randconfig-a013-20200827
i386                 randconfig-a012-20200827
i386                 randconfig-a011-20200827
i386                 randconfig-a016-20200827
i386                 randconfig-a015-20200827
i386                 randconfig-a014-20200827
i386                 randconfig-a013-20200828
i386                 randconfig-a012-20200828
i386                 randconfig-a011-20200828
i386                 randconfig-a016-20200828
i386                 randconfig-a014-20200828
i386                 randconfig-a015-20200828
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
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
