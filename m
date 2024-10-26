Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AE6D10BE3
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Oct 2024 05:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ow1Dmm0yyKi6X/avr5qfLQG3zyVTc8j4BiGaVhG5i9w=; b=QnehWoeeINxa+I0yLYzhhkY21h
	0Q/XTZDidIFo3f2mzO6dcgBZWLizQAdwlr52ERZ3WJRho4iXvzb8wtp/pyOF8MbN0+1o7WfAYZTJs
	37MFXJIa4Ch+xAuyF8tZTbBMcZe2qDtGER/onXXXEEWf2hU7n6xlnz4d9i7E43mf+U5tXAGftYKXC
	ef1JKRYNoT+Q+VxvHr/s/OwQLTY7WV1WwrfQjzP5NNqSdO8Gq0x5G246qaYArWvV7uKRoOiG4ULk+
	fV17Jg7B4YXrM73SPgy1V+h5Eq3v5E/JN66UbOOIU7BAOE9q0eBhh4UfgMolkZHewXrkpboYWBPjj
	KRrG4x6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4ZkM-00000006038-2rGJ;
	Sat, 26 Oct 2024 05:53:58 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4ZkJ-0000000602k-1uEm
	for linux-nvme@lists.infradead.org;
	Sat, 26 Oct 2024 05:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729922035; x=1761458035;
  h=date:from:to:cc:subject:message-id;
  bh=XSo0Ry9+T2pRnGaFOcvOzjisyiEbGhmwvVvaoqXjHUk=;
  b=hW5PpyT083J738+r2TRUWTTEJFZyiaeedkLVV02d+FiYnID+VDKU6Moz
   FcbIS+6ik+snlVUfCQ90dRDdwtWUA9Q2j8+ydXhvypGcRY0+G1aeI8Had
   xtNAclrsyIydkIop5jff51vZ4Al1ddM5fEOjndQBtJRRek0+R7qVM9uoj
   xpZDsiW3nP6oR5ENndEek46jk/HQKBbftijpSXvK1Kj7VPbOCXVavp6mP
   WJqplZDWznPakHiCOU+0EVXYK3LzPNU3USuIBMT4qdW8UVQJQ+AGu1T4T
   BfyJk5a9r/c8g17cvYKAU8BggVO+3B2l9Jgxm+TKchgqY7JmtnI9abQtP
   w==;
X-CSE-ConnectionGUID: AUSrMNMHQJq8LOOqllZ4xQ==
X-CSE-MsgGUID: 3eKsSpWaRBSYJhbGO3S7Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="32456214"
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="32456214"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 22:53:49 -0700
X-CSE-ConnectionGUID: /1nSvGk2Q/aPpWnvmT4qLw==
X-CSE-MsgGUID: m3bYVuZSSsyZjQEwnB0NUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="85893485"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Oct 2024 22:53:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4Zk9-000ZK0-1N;
	Sat, 26 Oct 2024 05:53:45 +0000
Date: Sat, 26 Oct 2024 13:53:05 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.12] BUILD SUCCESS
 81ea3e0bd1d46b626a946127c4f907340fdee615
Message-ID: <202410261357.HfNGanro-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_225355_558194_E4643AF7 
X-CRM114-Status: UNSURE (   4.66  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.12
branch HEAD: 81ea3e0bd1d46b626a946127c4f907340fdee615  nvmet-auth: assign dh_key to NULL after kfree_sensitive

elapsed time: 877m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
i386            allmodconfig    clang-19
i386             allnoconfig    clang-19
i386            allyesconfig    clang-19
i386               defconfig    clang-19
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc         allnoconfig    gcc-14.1.0
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc           allnoconfig    gcc-14.1.0
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc          allnoconfig    gcc-14.1.0
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv            allnoconfig    gcc-14.1.0
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-17
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-19
x86_64          allyesconfig    clang-19
x86_64             defconfig    clang-19
x86_64                 kexec    clang-19
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
x86_64          rhel-8.3-bpf    clang-19
x86_64        rhel-8.3-kunit    clang-19
x86_64          rhel-8.3-ltp    clang-19
x86_64         rhel-8.3-rust    clang-19
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

