Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E02C44520
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 22:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iUdoFEVh2UJmGGmxb6nxz2HMY9ccmJ+3mioDRJweu6Q=; b=aVnUm921hP+sfMFmRzDB1IUTsB
	c59QYp5UlN1WyYhj8iFs7ugSOgmVrGGPaXflDDH+HMpWzNuqYDVenU6aRGMBRFvONL2bvFhkb05qc
	dHGmkJqtZuK5WwqRMlSRMqflKdJAXYcBtHM+fvEGXvK0eK1P9vuhRgwszF6dqEjiju6RAJw3Z57fA
	r8b24SfoyDyorJjc1SVayUXCB6Wi8Qpl+D78SwKWOK2Tc1CeaOj0uKj/cQnrvFG5fKUBnYdPcXAx0
	bRyU43hQlwcPbUP+SIyTJRb835EHVBAMCeYZd1cd/B7HX5mLOXZ6UyJGmzYo4AQ/8bh2hCQbEnbOV
	ocHiC+vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlw5K-00000007zzv-2McC;
	Mon, 20 Jul 2026 22:03:38 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlw5I-00000007zzV-0YGE
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 22:03:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784585016; x=1816121016;
  h=date:from:to:cc:subject:message-id;
  bh=j59YDbr7u/aMquvhc41kufed1P5IOCWB09lRzd1FL3E=;
  b=PvJSdo7ZEgjJmbg9ca6L7p7WdzFqjge/zACIXxd7/LWI85ePomrZIuLE
   iqhhohk4nZLR97rAllUO3CwGFOLQFZbmPtsJptdhSFzJuqk+2G0/MHWpd
   TvA8uSU6bYzNmfSEIYvajZgQ4zRMJnf5cVelGv+/eYF07fhrI7Ghyer8j
   b7fwBzUg8ApMUji0mnnJ3TEoNrOQr/CjYVqQWnAC+Z0ChnCwgcdqAqfDM
   SwhAzZotYuz3SVZz4WwYk4EmA6ydOUqTfrLK6mVpv5wKIikiIzDzMfdpn
   Olr2nEAseLTfS0F/4VbEO0dCu6bTZB9KoXRhp+VKkiWLrfQOsZKQSYgN0
   Q==;
X-CSE-ConnectionGUID: rSBTuMSlT2S7Mq7kq6yCAw==
X-CSE-MsgGUID: q7tFuXJfRPyOaOnGUARS9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87716016"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87716016"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:03:35 -0700
X-CSE-ConnectionGUID: fhhwnDqkQAaD59hbhYLEBg==
X-CSE-MsgGUID: PNi0m6koTbuxUxBOZltERw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="259562233"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 15:03:34 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wlw5C-00000000Wqf-3OIE;
	Mon, 20 Jul 2026 22:03:30 +0000
Date: Tue, 21 Jul 2026 06:02:49 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS
 9952f3882ecba709092379b71e02b09762b26f96
Message-ID: <202607210635.CmbtYpLH-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_150336_245270_24E36AA4 
X-CRM114-Status: UNSURE (   4.77  )
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
branch HEAD: 9952f3882ecba709092379b71e02b09762b26f96  nvme: fix cdev lifetime

elapsed time: 5778m

configs tested: 34
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
csky                  allmodconfig    gcc-16.1.0
hexagon             randconfig-001    clang-17
hexagon    randconfig-001-20260717    clang-24
hexagon    randconfig-002-20260717    clang-17
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
loongarch  randconfig-001-20260717    gcc-16.1.0
loongarch  randconfig-002-20260717    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
nios2      randconfig-001-20260717    gcc-8.5.0
nios2      randconfig-002-20260717    gcc-8.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
sh                       defconfig    gcc-16.1.0
x86_64                       kexec    clang-22
x86_64     randconfig-011-20260717    gcc-14
x86_64     randconfig-012-20260717    gcc-14
x86_64     randconfig-013-20260717    clang-22
x86_64     randconfig-014-20260717    gcc-12
x86_64     randconfig-015-20260717    gcc-14
x86_64     randconfig-016-20260717    gcc-14
x86_64     randconfig-071-20260717    gcc-14
x86_64     randconfig-072-20260717    gcc-14
x86_64     randconfig-073-20260717    gcc-14
x86_64     randconfig-074-20260717    gcc-12
x86_64     randconfig-075-20260717    gcc-14
x86_64     randconfig-076-20260717    clang-22
x86_64                rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

