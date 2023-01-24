Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72CCC38142
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 05:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0LpAp4HKW5b/mMOQc1Yb2JqLVa47AMBILJQyMVUfz1Y=; b=yN6i4YKGoUUerZEMOIJJGeYHqA
	x9WqKRTse8aCIXSECVAs1Qb1Gsrhxd4uZmkbQG3vXpn2uwvg/PfPL2VzG1/76XqpOleT45CwwJ7+q
	8vkd6kR/YDlwFXSVf+stbREnfMc1q3dWjwYgGco5uk83qAZp/URH2vaT1WhzxD1J7VvySqOfVav3k
	cwpxe6qE/G1xwadZPq/rTOemc11jJ4r7S6ozi7sKRZeVz8ydI0D3j9Quxfx4v5aGcTAyQyQzfaG/k
	Bf6gzyjc7WjdOLW4Y4/r95u5CPQWjx/eKr81ko2uRATQo/ta/2wEqNlUIX6nmugac/unc4IDK6Jih
	iQX3Bf7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKBd3-002KPi-0Z; Tue, 24 Jan 2023 05:13:53 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKBcu-002KO5-Sl
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 05:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674537224; x=1706073224;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UB1SPmZ/lJoE5Czl8O7x/FHcE5otYLhBj+z4v4XM/Bc=;
  b=m2mi4wQ6SayLiFstZkoSVe8HDFJesdvOAx0VPczuqlgQPcUFWrW6gMHR
   A4koT4Xe7V8kHrS1Xy5lThIKn1fKDK6iVpy8TwN0gmtR/YnzE7pw1fHtX
   drFFjYVfdpeIPXf89MA8j2uwExe2GYqMSDw2OPgcg9zs7MhXqmEjRn6NJ
   qG0W563k2OmHAuEUnoTz1H8iv8nbvpb7aE7GSAYXpwv6oAUER4/6+wVSJ
   K3YRgqjy2L3yu9IymTjN1nIehqO/TAiOmrV/OEEzDkfg3EMQ32MzZVDT+
   6f2id73vdZqB359U10VwD0C/tcrxd5ShSQ28RCti/UBih1A1SIacPMS6G
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326265206"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="326265206"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 21:13:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="730558078"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="730558078"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jan 2023 21:13:41 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pKBcq-00069p-1d;
	Tue, 24 Jan 2023 05:13:40 +0000
Date: Tue, 24 Jan 2023 13:13:22 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 98e3528012cd571c48bbae7c7c0f868823254b6c
Message-ID: <63cf68f2.MZ+cO9aZQnSpB5zU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_211345_051263_AF9EBA60 
X-CRM114-Status: UNSURE (   7.84  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.2
branch HEAD: 98e3528012cd571c48bbae7c7c0f868823254b6c  nvme-fc: fix initialization order

elapsed time: 725m

configs tested: 72
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
m68k                             allyesconfig
s390                             allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                                defconfig
alpha                            allyesconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
x86_64                           rhel-8.3-syz
i386                 randconfig-a002-20230123
x86_64                         rhel-8.3-kunit
i386                 randconfig-a001-20230123
x86_64                           rhel-8.3-kvm
i386                 randconfig-a005-20230123
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
x86_64                          rhel-8.3-func
i386                 randconfig-a006-20230123
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
i386                                defconfig
ia64                             allmodconfig
x86_64               randconfig-a002-20230123
x86_64               randconfig-a001-20230123
x86_64               randconfig-a004-20230123
x86_64               randconfig-a003-20230123
x86_64               randconfig-a005-20230123
x86_64               randconfig-a006-20230123
arm                                 defconfig
i386                             allyesconfig
x86_64                           allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
hexagon              randconfig-r045-20230123
x86_64               randconfig-a014-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a014-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123
x86_64               randconfig-k001-20230123
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

