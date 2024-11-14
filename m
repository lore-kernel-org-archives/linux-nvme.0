Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F6DD41C3A
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 05:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iJcDqoLmMhfH5koezy2KV7sXvF/+XOzK6++YyEzWuPI=; b=LHxr/AGiiNDo3q8vIbskhTrTvI
	RtzVysVno8YkhhBqhc2/7xqEbO7k4StV8PFHdnvhL+iJLe3OdOqTdeyV27Qjv8s6HjrJBhslqtJgm
	RFY5fMtZM2rbMP7EfuyWu9/dR5QsCgPG3+vFoiLFcg0WoGfpr9GHI2d1mGgiiWgFfcgebbAwMflzx
	VbHQmieU44TlIy4OY6N0Y9r4ZN6ateTHOoMP76OeLR0iuRMURtP/fsnxvsGPWty5zDYM6GCfbvswG
	qIfxeo7ZDX+YS2/lZTfKx8CgJpqAY9UqIt4MQC4TOheZi2t1/6zTnVaMnDwAs04p7jwy5RwIG5eTl
	/bzIVtXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBSYM-00000008rsb-1NlQ;
	Thu, 14 Nov 2024 05:38:02 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBSYI-00000008rrL-470h
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 05:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731562679; x=1763098679;
  h=date:from:to:cc:subject:message-id;
  bh=JRajQgu/fafCB/UB3mQFkc3kx6XTxnpCIDO9jFMmB0I=;
  b=CLEP51jeUdnZ0xKtz0puUwGtNoZXgQtR+2EqzLm3bxYpEA1GeGg0eVxA
   G4Xb8eZ0+bPj/3HlCpVla4qMbDhFWtMYDx5/MhaCUCoBZWta/Y4v/eye4
   Mxw8OBu01Jx2jt3cKRDQFgEl6fMQKU6kkNoFnF7wCuafV0xJ/s1df/sgj
   zM8NR0KDd9NGpMAK0ojyLIFVGmP9f1KaJVOttBEWXlqhl0ym3pargccQ4
   8B2d5bp7V1HpTonsM5whSyrBBevlXqF0QtCociCDiCpDJibjkr3wfJuhD
   S/L8dBWyH4V9H9V9qYmWIojvZthhE+77C/OzNh/+b3fQeAfYhi+eYRVyg
   A==;
X-CSE-ConnectionGUID: y4drSOV5QPeAURBfpkEjtQ==
X-CSE-MsgGUID: rBGPtqUJRei2KigEOsKDBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42101036"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42101036"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 21:37:54 -0800
X-CSE-ConnectionGUID: +XcN9zRRTMaI1L7j66Uneg==
X-CSE-MsgGUID: gA5ViLf4RQ+o0Uj8BTyGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="87844566"
Received: from lkp-server01.sh.intel.com (HELO b014a344d658) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Nov 2024 21:37:52 -0800
Received: from kbuild by b014a344d658 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBSYA-0000Ae-1S;
	Thu, 14 Nov 2024 05:37:50 +0000
Date: Thu, 14 Nov 2024 13:37:42 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 50bee3857d081ab1b83f93c64cb5c10a4babe2d9
Message-ID: <202411141334.GKYU21yv-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_213759_051367_A980B2F9 
X-CRM114-Status: UNSURE (   5.01  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.13
branch HEAD: 50bee3857d081ab1b83f93c64cb5c10a4babe2d9  nvmet: add tracing of reservation commands

elapsed time: 728m

configs tested: 95
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                allnoconfig    gcc-14.2.0
alpha               allyesconfig    clang-20
alpha               allyesconfig    gcc-14.2.0
alpha                  defconfig    gcc-14.2.0
arc                 allmodconfig    clang-20
arc                  allnoconfig    gcc-14.2.0
arc                 allyesconfig    clang-20
arc                    defconfig    gcc-14.2.0
arc           vdk_hs38_defconfig    gcc-14.2.0
arm                 alldefconfig    gcc-14.2.0
arm                 allmodconfig    clang-20
arm                  allnoconfig    gcc-14.2.0
arm                 allyesconfig    clang-20
arm                    defconfig    gcc-14.2.0
arm               dove_defconfig    gcc-14.2.0
arm            socfpga_defconfig    gcc-14.2.0
arm64               allmodconfig    clang-20
arm64                allnoconfig    gcc-14.2.0
arm64                  defconfig    gcc-14.2.0
csky                 allnoconfig    gcc-14.2.0
csky                   defconfig    gcc-14.2.0
hexagon             allmodconfig    clang-20
hexagon              allnoconfig    gcc-14.2.0
hexagon             allyesconfig    clang-20
hexagon                defconfig    gcc-14.2.0
i386                allmodconfig    clang-19
i386                 allnoconfig    clang-19
i386                allyesconfig    clang-19
i386                   defconfig    clang-19
loongarch           allmodconfig    gcc-14.2.0
loongarch            allnoconfig    gcc-14.2.0
loongarch              defconfig    gcc-14.2.0
m68k                allmodconfig    gcc-14.2.0
m68k                 allnoconfig    gcc-14.2.0
m68k                allyesconfig    gcc-14.2.0
m68k                   defconfig    gcc-14.2.0
m68k           m5272c3_defconfig    gcc-14.2.0
m68k           m5307c3_defconfig    gcc-14.2.0
m68k               q40_defconfig    gcc-14.2.0
microblaze          allmodconfig    gcc-14.2.0
microblaze           allnoconfig    gcc-14.2.0
microblaze          allyesconfig    gcc-14.2.0
microblaze             defconfig    gcc-14.2.0
mips                 allnoconfig    gcc-14.2.0
mips         bmips_stb_defconfig    gcc-14.2.0
mips        loongson1b_defconfig    gcc-14.2.0
nios2                allnoconfig    gcc-14.2.0
nios2                  defconfig    gcc-14.2.0
openrisc             allnoconfig    clang-20
openrisc            allyesconfig    gcc-14.2.0
openrisc               defconfig    gcc-12
openrisc     or1klitex_defconfig    gcc-14.2.0
parisc              allmodconfig    gcc-14.2.0
parisc               allnoconfig    clang-20
parisc              allyesconfig    gcc-14.2.0
parisc                 defconfig    gcc-12
parisc64               defconfig    gcc-14.2.0
powerpc             allmodconfig    gcc-14.2.0
powerpc              allnoconfig    clang-20
powerpc             allyesconfig    gcc-14.2.0
powerpc           cell_defconfig    gcc-14.2.0
powerpc          ebony_defconfig    gcc-14.2.0
powerpc        mpc83xx_defconfig    gcc-14.2.0
powerpc       socrates_defconfig    gcc-14.2.0
riscv               allmodconfig    gcc-14.2.0
riscv                allnoconfig    clang-20
riscv               allyesconfig    gcc-14.2.0
riscv                  defconfig    gcc-12
s390                allmodconfig    clang-20
s390                allmodconfig    gcc-14.2.0
s390                 allnoconfig    clang-20
s390                allyesconfig    gcc-14.2.0
s390                   defconfig    gcc-12
sh                  allmodconfig    gcc-14.2.0
sh                   allnoconfig    gcc-14.2.0
sh                  allyesconfig    gcc-14.2.0
sh                     defconfig    gcc-12
sh              se7721_defconfig    gcc-14.2.0
sparc               allmodconfig    gcc-14.2.0
sparc64                defconfig    gcc-12
um                  allmodconfig    clang-20
um                   allnoconfig    clang-20
um                  allyesconfig    clang-20
um                  allyesconfig    gcc-12
um                     defconfig    gcc-12
um                i386_defconfig    gcc-12
um              x86_64_defconfig    gcc-12
x86_64               allnoconfig    clang-19
x86_64              allyesconfig    clang-19
x86_64                 defconfig    clang-19
x86_64                     kexec    clang-19
x86_64                     kexec    gcc-12
x86_64                  rhel-8.3    gcc-12
xtensa               allnoconfig    gcc-14.2.0
xtensa             iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

