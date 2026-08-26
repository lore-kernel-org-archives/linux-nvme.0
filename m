Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957BFC61DBD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 01:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H1W3NAUQIRAEiD8X3+kPOV22mKF8BCuyBiZZaEMRvYk=; b=HMrgG9mIqFmviFvna41Q8Fdika
	NCC+A06CPCq3RdDlLMiZSuUIkBw2qIvsXSEtbXnD2OHhJq7UUtu1jJ8xYcwjlq2W2+4w19MSks4wN
	gfEdtuV3U4nopo8zg4I78FJ/Viq7Cs7xZ0Qk0PR+XcWbfmV2Zr6A6MiDPbTWSLwCO6th7KcfrqWK+
	aA0AtM16vj+zhdkztyF/fDnxigLDnomwP4H2SFC3VNYmAOuInbM+MTR6hNvcbSHBo8iWQgzSRxDSO
	k+M91L4akO+oRWMqMDA85hulnQBjEFPw2SyV+p3Zs6boVuSCkGW+4E+jZPwKax1J1WPsVNRBNEOqL
	GfGb8gtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz2H7-00000001kTn-2hfj;
	Wed, 26 Aug 2026 01:17:57 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz2H5-00000001kT0-1smq
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 01:17:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787707075; x=1819243075;
  h=date:from:to:cc:subject:message-id;
  bh=oPNnkHQ3O+KulTm6Blj2nY2SkwC2NnhUJW5Dt9VqPhA=;
  b=VphMF24bcEjVso/7F8rOokLcVrDK3D7b9lCUb+L+8PVNU5Sr0BgY81GH
   Y1x1fGKaWlPurqf4kFFQ4ihg8bMfbmK1jSeovKGFwO6oUfwnZoqfwRvbw
   T2krHCHkid2E/C+0rm/znpvT4JzQriFiDjix68kiagFWnmbTjoDRxOvqd
   6Lpii7tjmxamx/2obE4V3qnwASIgaCon3a7ygnRTMGySUl3tAKussmc1D
   m2h2SPKjipmSmPcHBPF2279wSMe0PgLiI9taCKLgIzhf9LsGaGPamfYva
   YrCZztRwT0BUADc61Hvn3fCKi3FrCegg0ub0RAgC5dLrjfyrhppfBNkzH
   w==;
X-CSE-ConnectionGUID: pcIhPd5pSlaZDw1Ui0n+xA==
X-CSE-MsgGUID: X4YlJjjcRE61MZtjAxYJiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88042139"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88042139"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 18:17:52 -0700
X-CSE-ConnectionGUID: cJbhsZkfSQCC8kS58qrKtw==
X-CSE-MsgGUID: YTDtnUifRVq6KdYCZgxWEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="297339780"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Aug 2026 18:17:52 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wz2Gz-000000006ix-293B;
	Wed, 26 Aug 2026 01:17:49 +0000
Date: Wed, 26 Aug 2026 09:16:55 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS WITH UNVERIFIED WARNING
 9eabc91952f9821824ca0288a76b3aba57961c6b
Message-ID: <202608260939.hLatahW3-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_181755_526524_1821CCE5 
X-CRM114-Status: UNSURE (   4.12  )
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
branch HEAD: 9eabc91952f9821824ca0288a76b3aba57961c6b  nvme-tcp: defer TLS inline send to io_work

Unverified Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202607291634.E5clnaLh-lkp@intel.com

    drivers/nvme/host/multipath.c:249:38: warning: reading variable 'current_path' requires holding __ctx_lock_RCU 'RCU' [-Wthread-safety-analysis]

Warning ids grouped by kconfigs:

recent_errors
`-- loongarch-defconfig
    `-- drivers-nvme-host-multipath.c:warning:reading-variable-current_path-requires-holding-__ctx_lock_RCU-RCU

elapsed time: 810m

configs tested: 17
configs skipped: 1

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
alpha           defconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
arm        mps2_defconfig    clang-24
csky         allmodconfig    gcc-16.1.0
i386         allmodconfig    gcc-14
loongarch       defconfig    clang-24
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
parisc       allmodconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
parisc          defconfig    gcc-16.1.0
sh              defconfig    gcc-16.1.0
x86_64              kexec    clang-22
x86_64       rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

