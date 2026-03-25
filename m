Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C6D109C045
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2026 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gTr1io59iwt2NiW6KRpQ/5XnHwouogrGmgJGgvzYC4A=; b=kakJkZI0xrf1ZkOI2Aitst5gM5
	ueQfyAT745SBY2WvQGWAUpAy2bAxON8cnamdruRB2KS0KFHgh5d7+4ojhSOfLfIG5XmuO/teor7Hj
	aWs1UhW5qOc53mb1YivsXXkNrZFDf/4mquZb5A2QqN6AUmFIiZ/uknhlXgps2BjRAsPt9t/fjHJgM
	4XIpGZHUfuXSidvjhNMKq5TIFMDXZ5r6OXRzLToTd1n/baMjgF5sldmUAknacngcqieqq7IVVh6qX
	vp8v+nQfdbXmrdw+G/UcYnOBkMep4vWFcRYWOTHDQPQocbO//MbZcMq5pQnzepUnvS9ST80WPnUyT
	ZbdGWTyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5RZv-00000003xI0-1UO8;
	Wed, 25 Mar 2026 16:59:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5RZq-00000003xHs-19cm
	for linux-nvme@bombadil.infradead.org;
	Wed, 25 Mar 2026 16:59:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gTr1io59iwt2NiW6KRpQ/5XnHwouogrGmgJGgvzYC4A=; b=CLENXN3cU7RNM1CYkyMI4Bz268
	XIsvJoGZN+mZq3v5SoXYM4hIBrt9t0LMCdT9BhYVYSZBhr8HWjoM/AwCekEJr7RyKoI7IwSoETpHY
	Cem30UiHQbGtjYyUS7T4NoW6b5O6807q1719+J9zSBHwYJJs5rB/Cmpa8jQ7qSWtdlE2WloNsL0HM
	sUOqPWJZQYjK9WD6EcKrtJIi3let8zxXIuDYDS/YdWuP0sRVzgRapgsf+A9ulS5VuFJN0Kn7ob1H5
	doFy3xFOZbBMrTnCh+P8XhHPTPNZmQ/YTGS0vlys/x6eJGfYjPs8eim3bFjFy2B2zFLWlSwQXJMRo
	5PMPoFnQ==;
Received: from mgamail.intel.com ([192.198.163.18])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5RZm-00000006hR9-2hFY
	for linux-nvme@lists.infradead.org;
	Wed, 25 Mar 2026 16:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774457967; x=1805993967;
  h=date:from:to:cc:subject:message-id;
  bh=VYfWZ3OuK8GLBiyHu26FAK40pM/JAuz7KRBtmPM/mWk=;
  b=mDHnsX9KP3pGWUu0kjs5vcVBTXlZ/I3F8FHZ9f1rUNCWHDxx30Tmuss1
   /S8UdJ1KX5L+kxs8gn78MPppc533K4Pq2OpZ9E4Qe8PXTKEc/sZ5e0n01
   4yWCeNxOuIjdUyiPf6mao+gq2gqs4n3AadvCxk4yFHI1HNEfHrG4bIBKm
   V4FSH74wARNVWIj8iX0VTbgtpd+N1M9e/tLPXxX5uGdL4ymYsoJftfVrA
   DNudLyop4G/xCxmIUu8P7nP6LZ3+El0nAZR+Bl7xmef5O7pq8uON0c0aj
   nGtXDaHyDcZPTgyKehPLhISm+ckaKv3RTg+CK0/a3FGq6AOq5PHf1ga8i
   Q==;
X-CSE-ConnectionGUID: 0hzHGFxjSJiCa+JBqOdVCw==
X-CSE-MsgGUID: END+bUUEQlKSYhuJ0ukfLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74681944"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="74681944"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 09:59:13 -0700
X-CSE-ConnectionGUID: LM3jE3XjShWr8o/F/OJ1hA==
X-CSE-MsgGUID: 6LLcHOu7QQ65kfsOp0dS+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="219898110"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 Mar 2026 09:59:12 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5RZV-000000007K7-31ex;
	Wed, 25 Mar 2026 16:59:09 +0000
Date: Thu, 26 Mar 2026 00:59:06 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.1] BUILD SUCCESS
 0609e7729363462b1fed1682493323bb23689cc8
Message-ID: <202603260058.ZExsf2dz-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_165927_089896_65A5DF37 
X-CRM114-Status: UNSURE (   5.24  )
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
branch HEAD: 0609e7729363462b1fed1682493323bb23689cc8  nvme: add WQ_PERCPU to alloc_workqueue users

elapsed time: 1289m

configs tested: 155
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260325    gcc-15.2.0
arc                   randconfig-002-20260325    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260325    gcc-8.5.0
arm                   randconfig-002-20260325    clang-23
arm                   randconfig-003-20260325    clang-23
arm                   randconfig-004-20260325    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260325    clang-23
arm64                 randconfig-002-20260325    gcc-11.5.0
arm64                 randconfig-003-20260325    gcc-8.5.0
arm64                 randconfig-004-20260325    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260325    gcc-10.5.0
csky                  randconfig-002-20260325    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260325    clang-19
hexagon               randconfig-002-20260325    clang-23
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20260325    gcc-14
i386        buildonly-randconfig-002-20260325    gcc-14
i386        buildonly-randconfig-003-20260325    clang-20
i386        buildonly-randconfig-004-20260325    clang-20
i386        buildonly-randconfig-005-20260325    clang-20
i386        buildonly-randconfig-006-20260325    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260325    clang-20
i386                  randconfig-002-20260325    clang-20
i386                  randconfig-003-20260325    gcc-14
i386                  randconfig-004-20260325    clang-20
i386                  randconfig-005-20260325    gcc-14
i386                  randconfig-006-20260325    clang-20
i386                  randconfig-007-20260325    clang-20
i386                  randconfig-011-20260325    gcc-14
i386                  randconfig-012-20260325    gcc-14
i386                  randconfig-013-20260325    gcc-14
i386                  randconfig-014-20260325    gcc-14
i386                  randconfig-015-20260325    clang-20
i386                  randconfig-016-20260325    clang-20
i386                  randconfig-017-20260325    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260325    clang-23
loongarch             randconfig-002-20260325    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260325    gcc-8.5.0
nios2                 randconfig-002-20260325    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260325    gcc-8.5.0
parisc                randconfig-002-20260325    gcc-14.3.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260325    clang-23
powerpc               randconfig-002-20260325    clang-23
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20260325    clang-23
powerpc64             randconfig-002-20260325    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260325    clang-20
riscv                 randconfig-002-20260325    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260325    clang-23
s390                  randconfig-002-20260325    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260325    gcc-15.2.0
sh                    randconfig-002-20260325    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260325    gcc-8.5.0
sparc                 randconfig-002-20260325    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260325    clang-23
sparc64               randconfig-002-20260325    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260325    gcc-13
um                    randconfig-002-20260325    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20260325    gcc-14
x86_64      buildonly-randconfig-002-20260325    gcc-14
x86_64      buildonly-randconfig-003-20260325    gcc-14
x86_64      buildonly-randconfig-004-20260325    gcc-14
x86_64      buildonly-randconfig-005-20260325    gcc-14
x86_64      buildonly-randconfig-006-20260325    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260325    gcc-14
x86_64                randconfig-002-20260325    gcc-14
x86_64                randconfig-003-20260325    clang-20
x86_64                randconfig-004-20260325    clang-20
x86_64                randconfig-005-20260325    gcc-14
x86_64                randconfig-006-20260325    gcc-12
x86_64                randconfig-011-20260325    clang-20
x86_64                randconfig-012-20260325    gcc-13
x86_64                randconfig-013-20260325    gcc-14
x86_64                randconfig-014-20260325    gcc-14
x86_64                randconfig-015-20260325    clang-20
x86_64                randconfig-016-20260325    gcc-13
x86_64                randconfig-071-20260325    clang-20
x86_64                randconfig-072-20260325    gcc-14
x86_64                randconfig-073-20260325    clang-20
x86_64                randconfig-074-20260325    gcc-14
x86_64                randconfig-075-20260325    gcc-14
x86_64                randconfig-076-20260325    gcc-14
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260325    gcc-13.4.0
xtensa                randconfig-002-20260325    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

