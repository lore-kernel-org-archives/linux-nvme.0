Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7412DC79F9E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2026 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fPM2BpWHDOzDcgEMmNJLsKq4oiLfENNLCo0eW94Jvmo=; b=zhjdkiXT9hCf1U0WK9wz3e03Cf
	xDi+Y21NML4xeWtmjQmXd5GCLvL41b77M5wpzlstYz9l0pC5Y5VxcwSkb1S7difCErZBaMMZbfAIv
	yjkBBsdA6a6t7zP5p02FZdZRD/5TcDhBHOXTdtYghGmkR9CiKL09vfkW6N9BIO/h5SlmkD+VXn10m
	fhM1Nqkwj797DtRkvm/BCnVoAuFprJOYZdL/QV2pbs8UkTQusXEvxTf7JDU02QusEu/UAZji8aG9k
	8CXkuMkjmsea68GbRIeXMbieSyCOPfNZVe1jrs4MEwhgdb8qiYqNk5g3zO8UMqe0btrbx+hhVIZpI
	aOL310Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3UCC-00000006Cph-21L6;
	Mon, 07 Sep 2026 07:55:16 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3UCA-00000006CoR-0rWQ
	for linux-nvme@lists.infradead.org;
	Mon, 07 Sep 2026 07:55:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788767715; x=1820303715;
  h=date:from:to:cc:subject:message-id;
  bh=Ss0HDHzbHNVtDcx8GeemtBtWEJJaIMffpN192JeR9bM=;
  b=WfayPXOqtYF0GLuN/HgiDayC2E8xJetsO74ZPtM05MCXM1N/aR53QL2r
   N3/z+ejEf3B1y3EmLrq2yEETkrrnBnVOPX5zn2SK65n5JE2my1lVbdMkr
   FUPwDsZuSxciJU2F4zr1xpN9XWkcGYuxhqowVTtlxO5A5ZM1pANUac7V2
   Mc2rUHp+Mjtkq4BeYMBBGaZui3VA1acM17czea6Uz8bVzgNG60bL/KB5f
   tMMif5QiTUl8tIIvyksS23JN7H2LyvnA8Dl2VeM2ozi4lUFLE6gHTn9JL
   6r1M+tcwL3pp3qm9NhpYfPYf5YMT/oHjjGb7efyn6sZlWxnPct/rqaLBZ
   A==;
X-CSE-ConnectionGUID: HUIXsgepQ+a1AW0qlpbc/g==
X-CSE-MsgGUID: OFUWWCSrT2aRzQlVnHNW7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="92866158"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="92866158"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 00:55:13 -0700
X-CSE-ConnectionGUID: eCg7nRoERHixyt6d+E0y+Q==
X-CSE-MsgGUID: pa0gz84fROSv0TKsV+FKHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="274153330"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 00:55:12 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3UC5-0000000002u-3v1a;
	Mon, 07 Sep 2026 07:55:09 +0000
Date: Mon, 07 Sep 2026 14:43:38 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS
 fd9beb8870736e1c6a0b2351d88a161aaeb2b326
Message-ID: <202609071436.ExRCeIyf-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_005514_305277_70412EC8 
X-CRM114-Status: UNSURE (   5.31  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.3
branch HEAD: fd9beb8870736e1c6a0b2351d88a161aaeb2b326  nvme-tcp.h: drop kernel-doc comments, fix a few descriptions

elapsed time: 4350m

configs tested: 46
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc        allnoconfig    clang-24
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
s390          allnoconfig    clang-24
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

