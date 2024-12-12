Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587C6E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 23:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o4YxdGlNpn3u5sVgod/AmzSffnWn2aY+dsQEVJ2blgI=; b=PluMHMMr5nHhhMMvn/TyzV1LM+
	UeL9NEz5G4M3hkWycmb6/Kx8EWUqL8TCWE1hHelW0AoIT7g19vXQOG0y7piJbNSWVflHSLEHkN3Qg
	Bl/AfoPIWru0AIAo0tIf6Zore66HJTXNaaamE2JqsuxlP3k3+mr2Sh97ZIhms+GW+L8BNnWYKiifN
	VWktS8rqL9H57IvZQEH1RYYxfOSpoha+eVja/gnE5J6kS3qzmTeaq4Bx9V51WG6qcBO56NdQj7wpw
	zOdWBn/Q6UcwZnGCq7rx7rnGVf+CzjGNdro/FMvB4lBa0BPZt+AAHYo2UDp1sI7hgeVwcvPs8s3Jn
	EOfuQlNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLszi-00000002EXt-1g7Z;
	Thu, 12 Dec 2024 23:53:22 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLszg-00000002EXU-0d4U
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 23:53:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734047600; x=1765583600;
  h=date:from:to:cc:subject:message-id;
  bh=c0jQTLLzV01KZwFUmV//g+/Z/MaGglqmfRw1rifOEaU=;
  b=H8Mp9EeXe3ewxVDeNRwCHRP1n3HJss9nmTBCgZK6ocDtv/vHacYMPXii
   2eypw97OsJKnRAxGjW0zaEWsaY1q++s62ti5VOY1h5sLZzhloEgb9PgeZ
   d97/TxxqnIz6fTQy8nCz1DvFB8gCU5iozbsbf0R4/UiczmmOTjxplJWWG
   kfcYkiCQAPo7hf4OgfYtC8QGQj2CjvPOF0/loQV4bgd7TVjwB3inoP9eH
   JNFs6OvJKkXvKETbCWPfqYC6NT7k/l0E2cq7zhJ7BKBEotNRSAjjTHTmc
   KgrQ8aeNgYtNsjFN6gLrjAwaWwGCuNP9r6TNvjQba6kq8GVPr/bPYBsik
   g==;
X-CSE-ConnectionGUID: us2p8HoSRqiOr1tS+mhuSQ==
X-CSE-MsgGUID: q/sC/1gVRIamRF9WuJ42yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="59887160"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="59887160"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 15:51:05 -0800
X-CSE-ConnectionGUID: BBtmjen2SQSEHoexaTRsHw==
X-CSE-MsgGUID: ts0apCxFQNKDQDEsoDbY1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96272743"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 12 Dec 2024 15:51:03 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLsxR-000BUS-0P;
	Thu, 12 Dec 2024 23:51:01 +0000
Date: Fri, 13 Dec 2024 07:50:57 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.13] BUILD SUCCESS
 ebefac5647968679f6ef5803e5d35a71997d20fa
Message-ID: <202412130751.tsvTc9Ua-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_155320_208881_E40CD0FC 
X-CRM114-Status: UNSURE (   4.47  )
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
branch HEAD: ebefac5647968679f6ef5803e5d35a71997d20fa  nvme-pci: 512 byte aligned dma pool segment quirk

elapsed time: 1445m

configs tested: 41
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                randconfig-001-20241212    gcc-13.2.0
arc                randconfig-002-20241212    gcc-13.2.0
arm                randconfig-001-20241212    gcc-14.2.0
arm                randconfig-002-20241212    clang-20
arm                randconfig-003-20241212    clang-19
arm                randconfig-004-20241212    clang-20
arm64              randconfig-001-20241212    clang-20
arm64              randconfig-002-20241212    clang-15
arm64              randconfig-003-20241212    clang-20
arm64              randconfig-004-20241212    gcc-14.2.0
i386     buildonly-randconfig-001-20241212    clang-19
i386     buildonly-randconfig-002-20241212    clang-19
i386     buildonly-randconfig-003-20241212    clang-19
i386     buildonly-randconfig-004-20241212    clang-19
i386     buildonly-randconfig-005-20241212    clang-19
i386     buildonly-randconfig-006-20241212    gcc-12
riscv              randconfig-001-20241212    clang-17
riscv              randconfig-002-20241212    clang-20
s390                          allmodconfig    clang-19
s390                          allyesconfig    gcc-14.2.0
s390               randconfig-001-20241212    clang-18
s390               randconfig-002-20241212    clang-20
sh                            allmodconfig    gcc-14.2.0
sh                            allyesconfig    gcc-14.2.0
sh                 randconfig-001-20241212    gcc-14.2.0
sh                 randconfig-002-20241212    gcc-14.2.0
sparc                         allmodconfig    gcc-14.2.0
sparc              randconfig-001-20241212    gcc-14.2.0
sparc              randconfig-002-20241212    gcc-14.2.0
sparc64            randconfig-001-20241212    gcc-14.2.0
sparc64            randconfig-002-20241212    gcc-14.2.0
um                 randconfig-001-20241212    gcc-12
um                 randconfig-002-20241212    clang-20
x86_64   buildonly-randconfig-001-20241212    clang-19
x86_64   buildonly-randconfig-002-20241212    gcc-12
x86_64   buildonly-randconfig-003-20241212    clang-19
x86_64   buildonly-randconfig-004-20241212    clang-19
x86_64   buildonly-randconfig-005-20241212    gcc-11
x86_64   buildonly-randconfig-006-20241212    clang-19
xtensa             randconfig-001-20241212    gcc-14.2.0
xtensa             randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

