Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FEFC38142
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Jan 2023 01:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NgNUCQBrJQBWoNVLW4QZpB32eLzfxZoTxPPgLNdKUck=; b=4R9N6Cv2aqr7xKsrDFTGtOSeeG
	aecoUalrr3YDijbvmg8z5kxYaMpNk5/hsgPKG9cMMZXRjmc4N5+iMUVKTzc8ICZ29F7F8cX3IZtMK
	eaBGjYN4W/mTI3zY9lJtSyix9BSII1y+009fXS4wtQxa9B/vOfKut2Zigt4ZNoVt+sIPyeoNBP3AU
	bu+KAF9w8XQt9sH77LvkvDrmTyvWTLbrAeeSVp2boIRNQRLtoK+QuKK2KW3lW7blVO5UPWWQf+Lun
	3GiWt4erGFqdpfgN4os1OdCRp1hlyLIgoQbd6aWI0Jt026mUAp1tD/mBXY+pFZpuPLTov4hdAooZp
	8nVimvoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLZhd-00GzNQ-L8; Sat, 28 Jan 2023 01:08:21 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLZhU-00GzKX-4y
	for linux-nvme@lists.infradead.org; Sat, 28 Jan 2023 01:08:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674868092; x=1706404092;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TrRs+s/AT0su1tfAyv2Bm0P5oGj5vIy8OvVvdrXtBj4=;
  b=kKgAiLbhSre+0QzIBdP1jqiWc4lyUpM4ghtPjRNiiYtSHuxpJKQra3Jj
   nadtidLA/bOV7A8GYThRI6oyZkiT3iZj8+qOBaw4xlFnpGB5tKeRahuJ4
   h4e9Cazrf9Z43d02mooCcz0NRjWt+5OaUQba5RGQRe7KeCWoi6upBswhA
   b2bgBxNJhS12UQ4F23pue9BDWF/FH+rFIl/6PIongZEY0auQzQecWR/5L
   wSZ5j/byy2pvFM1qgfGpZXyZLc8nk2kJjWqADrGNK/26AEEFxD/AJronV
   /uDHEd2yi5Nl63UZpRo9lQPuVyTSWg65jxDEQ28n9al2wEPVnW0vaeXyb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="389618944"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="389618944"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:08:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656805281"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="656805281"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2023 17:08:10 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pLZhR-00008q-0p;
	Sat, 28 Jan 2023 01:08:09 +0000
Date: Sat, 28 Jan 2023 09:07:08 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 85eee6341abb81ac6a35062ffd5c3029eb53be6b
Message-ID: <63d4753c.Tyh8Niiu9roDjJA0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230127_170812_280592_BBB709CA 
X-CRM114-Status: UNSURE (   5.95  )
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
branch HEAD: 85eee6341abb81ac6a35062ffd5c3029eb53be6b  nvme: fix passthrough csi check

elapsed time: 3986m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
x86_64                              defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
x86_64               randconfig-a002-20230123
i386                 randconfig-a001-20230123
alpha                            allyesconfig
x86_64                           allyesconfig
m68k                             allyesconfig
i386                 randconfig-a004-20230123
i386                                defconfig
x86_64               randconfig-a001-20230123
i386                 randconfig-a005-20230123
m68k                             allmodconfig
arm                                 defconfig
s390                             allyesconfig
i386                 randconfig-a006-20230123
x86_64               randconfig-a006-20230123
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a004-20230123
i386                             allyesconfig
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a003-20230123
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a005-20230123
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
x86_64                    rhel-8.3-kselftests
arm                              allyesconfig
x86_64                          rhel-8.3-func
arm64                            allyesconfig

clang tested configs:
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
x86_64                          rhel-8.3-rust
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a016-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

