Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BD606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cmUVsfoh;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ftrAo6qv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=6FoE7nUSQn/SRln1yZzjO6BaY3D1Ca7u2Y1Y+QHUzsc=; b=cmUVsfohLmlJizUioBItp7eTY4
	Od9EbS9oFbtY+p6IqE2XIUKSWcwDMrvc9dKzcTw9T8Ra6r06wDUowz8Zes7h9lWZBAVA0+A07rkQD
	mlJugXuLlZBRuGIkyN9LV+LCwq3QMLcfUJS+HcXz8G8FaEn2maqJN17btE5yjYeOuQozeF152628e
	oEVBefe7KGA/GS7xVcuFUe4guDTfU3FBs+fvZS7KqArV6e0uOO4tQBwdsQrLNaGEjhcYD8S+ZUzMX
	lJj0+sxYTnDxlk+s9sWeuDtSiMO5SKVKwdk8AwxEhLcRF2SNta2GP/nIb2EVI5xKuvn5y2DWUeVHr
	biDikA2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLZsE-00000003mmD-19aR;
	Tue, 27 Oct 2026 05:37:26 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLZsB-00000003mlg-0oSg
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 05:37:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793079443; x=1824615443;
  h=date:from:to:cc:subject:message-id;
  bh=4skTrDOqkDm75z41uz+/NAp64Eio6EAxAH0zfoRUbZU=;
  b=ftrAo6qvfeQjJk3EaVLCoX6foNKQZAhcjZMUEmmIPkkm0fxhPnMrUKby
   EGMJW34cn5JyCKUqTFZBlJiU8p13NYg4qmW8VLlOwm8sfasoau3V6Kvnz
   R865bnMd2HlyQC00TRkrehUcUDOhXxk/0LaDhyf4tVi0Ym5AHLGB8olRd
   B52o37qzJXFZzWdLKu18XeR3KYZVJrdUWSCSo3ymMeJ93/21Yg1U9/ZG8
   lEL4HVha8T9+QrHw77Cy4knbUO6zV4QXpSdUFD3BvxTAvMq1w/bacJFhJ
   LulJUjgydOT2/Mpt/QjRaoBm8IgjkPtoG7s2TpfaRLAe7qpxamkF8Zr0u
   A==;
X-CSE-ConnectionGUID: hB0ZWrmkSXyrQNELjhDTXQ==
X-CSE-MsgGUID: 7jCy3LuHR9uEuAxmJBHt6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1654357"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1654357"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 22:37:22 -0700
X-CSE-ConnectionGUID: 6AC5A76HSJanl707i+bkZA==
X-CSE-MsgGUID: afmYGt8aS7iF4Ky/5cxT5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4557065"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Oct 2026 22:37:20 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLZs6-00000000WtA-2Xaz;
	Tue, 27 Oct 2026 05:37:18 +0000
Date: Tue, 27 Oct 2026 13:37:18 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.4] BUILD SUCCESS
 aaedcff9014876387504a8b92d227766cb95015c
Message-ID: <202610271308.pniuhmG9-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_223723_267564_D4E6F2F2 
X-CRM114-Status: UNSURE (   5.13  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -4.7 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: git://git.infradead.org/nvme.git nvme-7.4
branch HEAD: aaedcff9014876387504a8b92d227766cb95015c  nvmet: protect nvmet_ports_list with nvmet_config_sem

elapsed time: 3837m

configs tested: 86
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    gcc-16.2.0
arm                                allnoconfig    clang-17
arm                               allyesconfig    gcc-16.2.0
arm                   randconfig-1001-20261027    gcc-10.5.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                 randconfig-1002-20261027    gcc-8.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                  randconfig-1000-20261027    gcc-16.2.0
csky                  randconfig-1001-20261027    gcc-16.2.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon               randconfig-1000-20261027    clang-24
hexagon               randconfig-1001-20261027    clang-24
i386                               allnoconfig    gcc-14
i386        buildonly-randconfig-1000-20261027    gcc-14
i386        buildonly-randconfig-1001-20261027    gcc-14
i386        buildonly-randconfig-1002-20261027    clang-22
i386        buildonly-randconfig-1003-20261027    gcc-14
i386        buildonly-randconfig-1004-20261027    clang-22
i386        buildonly-randconfig-1005-20261027    clang-22
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261027    gcc-13.5.0
loongarch             randconfig-1001-20261027    gcc-15.3.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    gcc-16.2.0
m68k                                 defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    gcc-16.2.0
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20261027    gcc-8.5.0
nios2                 randconfig-1001-20261027    gcc-8.5.0
openrisc                          allmodconfig    gcc-16.2.0
openrisc                           allnoconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    gcc-16.2.0
parisc                            allyesconfig    gcc-16.2.0
parisc                               defconfig    gcc-16.2.0
parisc64                             defconfig    gcc-16.2.0
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    gcc-16.2.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    gcc-16.2.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20261027    gcc-8.5.0
s390                  randconfig-1001-20261027    gcc-9.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    gcc-16.2.0
sh                                allyesconfig    gcc-16.2.0
sh                                   defconfig    gcc-16.2.0
sh                    randconfig-1001-20261027    gcc-16.2.0
sparc                              allnoconfig    gcc-16.2.0
sparc                                defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
um                                 allnoconfig    clang-17
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                            x86_64_defconfig    clang-24
x86_64                             allnoconfig    clang-22
x86_64      buildonly-randconfig-1001-20261027    gcc-14
x86_64      buildonly-randconfig-1003-20261027    gcc-12
x86_64      buildonly-randconfig-1004-20261027    gcc-14
x86_64                               defconfig    gcc-14
xtensa                             allnoconfig    gcc-16.2.0
xtensa                            allyesconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

