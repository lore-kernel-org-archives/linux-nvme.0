Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806D5F589A4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V9beciCj/DHyVe6n1qf2A8HssbIujOYJF5cT9afqJo4=; b=hKwZfeeBQp7miVVtPKEJulsUBd
	RheDE2pPILEdwOKV+5qT8aAhUMqRJcYv7wS5McaaaYwFzLR5rpAZNN9qeKSbFGWxuZFqZu9uYFymW
	8aMD6SIq4k2udMbdDGNPKap2HfUKY1/z8V5Aemr+90nSd3TKL3oWZOazEnkG+R6L2yJIusaDqyy01
	UOd6Hps9D9U+JcqZNwW1ariPhp/cQUHxO+9Q1ge979sXhBLB2UX/jsmGexln82kvzN9myeGic3bnl
	F4tDuho/fm3ZIG7NcUmybx4c9WZ7FTx6FeFsW7+7mYqOjHOBOYTJ8AGgFNZHHbmozFyWFDbrbqkVo
	ilj/pjOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFswo-0000000BbBI-2emg;
	Thu, 23 Apr 2026 12:14:22 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFswj-0000000Bb9S-26RI
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 12:14:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776946458; x=1808482458;
  h=date:from:to:cc:subject:message-id;
  bh=eCVfJKXOgD3WdyUV7Lt6MsEbM/Aey6sLKjf7JbarodU=;
  b=LhbxXekbs1x2B/z/v7fDwxtRX5Z76SCCEO4it4ohD1UzMc/0NAPD8dTf
   zy+32gcAJasTH/5NOGgyTVLuMD7Ig5j5cGiShisqeOhLnKouSopXI7NwG
   ejva9pTT8gD6fAVCgpwhfIoZIW4Gw7dsbA2m5fdRhOBat8uTZKKr2iZhk
   zqenzquurTPbkIne0KO2qKAOPMvy0+nOVFKnwayS46DQVkKkxyYJq94pa
   hrwugOnrsJ2X57Xqx3OMGDDikxeDQH7CLNS+tdx54T5cSRCEN2hHVau2+
   3sT/R+1MaGkyCnWkpNQjTMPnoUsaX7BzO6BDPgNtBIm1VxlYs7Q0MVjQC
   w==;
X-CSE-ConnectionGUID: uaJwoOFwRWmma03A2EvgAg==
X-CSE-MsgGUID: ANkpwNXhQQ+jOPdSzHagUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77824738"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77824738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 05:14:17 -0700
X-CSE-ConnectionGUID: wP1GCosoRn260BV4OJWaGQ==
X-CSE-MsgGUID: Q+Why9MnRzOpBSmSJ8kZlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="232950740"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Apr 2026 05:14:16 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wFswf-000000002xJ-14WW;
	Thu, 23 Apr 2026 12:14:13 +0000
Date: Thu, 23 Apr 2026 20:13:31 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.1] BUILD SUCCESS
 bd7b7ce96db4487bb77692a85ee4489fd2c395df
Message-ID: <202604232024.5z1K5y6H-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_051417_574419_272AC0FA 
X-CRM114-Status: UNSURE (   4.13  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.1
branch HEAD: bd7b7ce96db4487bb77692a85ee4489fd2c395df  nvme-auth: Hash DH shared secret to create session key

elapsed time: 953m

configs tested: 52
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

