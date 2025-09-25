Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA444CAC5B5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nR+2jg8uSJ2DwXII2BB+snam1MGHGx9RlQfNSRt5mas=; b=JecB8JYmO2/5esuPa2R6JPfy5O
	jF5gVTdEGNyg9v/RhzAOwFdzCjD7Az2LUwucC6lHhsY2Z8n0QGnsHT1VHSMDQQVfddYWPOA9OfgDp
	RoX4ChcSQNmUBrpDRaNf3QjJg7TOoCffblP8gsYmgIpil7pquWRZW72wzHE84dOegjCUxzp8cO+qq
	4MdvdImbOTPAF67yUQ/98THf3/MEvA92nB67wUhCzXxQLc6/LC59zBKMhBpVQsHKdzqnBYvBfmjcN
	zZNxihkNpy/nWkd8KVn1kON9OGfMLBd80F4dXu9oiYp48lXBfdBNamD3YDmkK056f4P9GlsN8ApbU
	Qpe6XK8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1uw4-0000000DnG6-0FjN;
	Thu, 25 Sep 2025 22:59:36 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1uw2-0000000DnFO-1L62
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 22:59:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758841175; x=1790377175;
  h=date:from:to:cc:subject:message-id;
  bh=ozxWZ0pfz2XDwqXpmJV/DsbU3NEb4YnWWQu+XYnghXc=;
  b=Vrb7jek0VK0TNLJQrB+4CCoWIC77fsGL/0Y7DAYlq/0MfkDmKvpiNhB1
   nyoyU05hp9dorUvnpNckm6ncs8HUsjC56meb7Tcp72TydXnOi9piKqQ95
   DGoVOl5+Ry7EmKdnF6yNYnoehXzT4mfHrlDVjcHgPo6FUL8BJ0G1QFFqL
   GhcA461LdwUKamdln7T8Va5iBJogAe4GaQ4u1zkIZD452GTvoJ4Fl0F2I
   15UzjOdRPFShLfc86yrZwgfub0oN9WW43MO5h1Je6dfJg1cRYkjt4kaqb
   8A70lymNcwRV1d1c0U8KcGj7qE+n80Ue6OB8O/16zBXJaAMnyyfdl6i3M
   Q==;
X-CSE-ConnectionGUID: BV5xM4GLRWinfJ2acgWbqQ==
X-CSE-MsgGUID: cX16uUarSE6pskjR/uIjTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="78608158"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="78608158"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 15:59:34 -0700
X-CSE-ConnectionGUID: /0pNa8DdT3ynW/o8woexBg==
X-CSE-MsgGUID: MqRDtkKmQGuhaYGZjEz/ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="201137285"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 25 Sep 2025 15:59:32 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1uva-0005hV-3D;
	Thu, 25 Sep 2025 22:59:16 +0000
Date: Fri, 26 Sep 2025 06:57:49 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.18] BUILD SUCCESS
 e989a3da2d371a4b6597ee8dee5c72e407b4db7a
Message-ID: <202509260643.8D64QjNf-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_155934_400034_CFF6E707 
X-CRM114-Status: UNSURE (   5.22  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git nvme-6.18
branch HEAD: e989a3da2d371a4b6597ee8dee5c72e407b4db7a  nvmet: remove redundant subsysnqn field from ctrl

elapsed time: 1472m

configs tested: 94
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250925    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250925    gcc-11.5.0
arm                   randconfig-002-20250925    gcc-10.5.0
arm                   randconfig-003-20250925    gcc-8.5.0
arm                   randconfig-004-20250925    gcc-14.3.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-004-20250925    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250925    gcc-14.3.0
csky                  randconfig-002-20250925    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250925    clang-22
hexagon               randconfig-002-20250925    clang-22
i386        buildonly-randconfig-001-20250925    clang-20
i386        buildonly-randconfig-002-20250925    clang-20
i386        buildonly-randconfig-003-20250925    gcc-14
i386        buildonly-randconfig-004-20250925    gcc-14
i386        buildonly-randconfig-005-20250925    clang-20
i386        buildonly-randconfig-006-20250925    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250925    clang-18
loongarch             randconfig-002-20250925    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250925    gcc-8.5.0
nios2                 randconfig-002-20250925    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250925    gcc-8.5.0
parisc                randconfig-002-20250925    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20250925    clang-22
powerpc               randconfig-002-20250925    gcc-8.5.0
powerpc               randconfig-003-20250925    gcc-8.5.0
powerpc64             randconfig-001-20250925    clang-22
powerpc64             randconfig-002-20250925    gcc-14.3.0
powerpc64             randconfig-003-20250925    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250925    clang-22
riscv                 randconfig-002-20250925    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250925    gcc-15.1.0
s390                  randconfig-002-20250925    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20250925    gcc-15.1.0
sh                    randconfig-002-20250925    gcc-13.4.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250925    gcc-15.1.0
sparc                 randconfig-002-20250925    gcc-12.5.0
sparc64               randconfig-001-20250925    gcc-10.5.0
sparc64               randconfig-002-20250925    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250925    gcc-14
um                    randconfig-002-20250925    clang-22
x86_64      buildonly-randconfig-001-20250925    clang-20
x86_64      buildonly-randconfig-002-20250925    gcc-14
x86_64      buildonly-randconfig-003-20250925    gcc-14
x86_64      buildonly-randconfig-004-20250925    clang-20
x86_64      buildonly-randconfig-005-20250925    clang-20
x86_64      buildonly-randconfig-006-20250925    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250925    gcc-12.5.0
xtensa                randconfig-002-20250925    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

