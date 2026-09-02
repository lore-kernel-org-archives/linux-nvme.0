Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36561C61DD6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FnKxtzH+rf4FCEEwb2DYq1wiAX+c8jR2rfaxlBwDQsc=; b=nbW4hBsEqLcyIzimW6sGac0jRg
	1crXirg/G4enie7t0SwAD6HcaV5lQ7ww4JllsQuYwTfbs/6qMUPR1wKVUPFfKn10sWYNxJMPhOyVK
	GNWYdkRW6FocgZ5Q3oOU8TU9TeqM4dc542pTJnLrpjC8pvk33M5IgsG0660QW0TLL8GHA0eAKbzXR
	ZCKcxjzktwnFU1ouznkCpRthmpXlCZ+RLWXmiNX3kOBbPYtB9ntD+MVJjWODFG/e0Ge96K57PuFki
	/StTZVMvpsBN06wm/Oh9TW8xsbNQCw3Tr2n7lREMzdyvh5lNe0/4aP+jbOpINmzcXFPoBPa9dTXi9
	CbnCLBhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oy3-0000000FTNZ-0If3;
	Wed, 02 Sep 2026 17:41:47 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oy0-0000000FTMn-0cfP
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 17:41:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788370904; x=1819906904;
  h=date:from:to:cc:subject:message-id;
  bh=3F0VmpL29FpPAmlMbBnqU17irYGD+E9hRdLslkcP0v4=;
  b=HcBNAorETkIiB/k8FOmQMAt4UbQ+/E1JvREQVphG1fQLXXLgbu14sBAQ
   ocwyltHXOo69oDU39wp1JHWhz8s4h+SdyzFNDZLc4cdF9iWRF3mMNoj9d
   YpZe+l+qESni2bDNusqCU0lf2nigEjov5ZT2mdaXhI5jaeQHEOnZpegej
   v1T17mEbr56jKk2LFINq/r2LyUpalOM4MyhClWh2J5Z7zeRB23JHf4eL0
   7DFUUXI5EKSfEySWKCnwijN5PcjDiyYoxZgkCsGGzb3Twm7wvyMn2RFd6
   D4rFotrF9RVVZmNUN0Boa1rDwg9vuWM9Vqh/qzlZ2l44DvryohzqBxIuQ
   A==;
X-CSE-ConnectionGUID: lwZoosl/Thu3e81wuV+emQ==
X-CSE-MsgGUID: UD/IWBWUR6uqLyCHjOeKnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100353941"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100353941"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 10:41:44 -0700
X-CSE-ConnectionGUID: RjMelJGbTmuMiM8qXh/Jqw==
X-CSE-MsgGUID: QSsEOU6PQcORgZKiZtoLww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="265162311"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Sep 2026 10:41:42 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1oxv-00000000352-2I5o;
	Wed, 02 Sep 2026 17:41:39 +0000
Date: Thu, 03 Sep 2026 01:41:09 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS
 74a2caefa2ad5f8a90a098555be57c61f5296b0f
Message-ID: <202609030105.d5VemivH-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_104144_228728_6DEFE0C0 
X-CRM114-Status: UNSURE (   5.60  )
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
branch HEAD: 74a2caefa2ad5f8a90a098555be57c61f5296b0f  nvmet-tcp: reject unsolicited H2CData PDUs

elapsed time: 1458m

configs tested: 58
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
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
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

