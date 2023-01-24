Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441EAC25B4E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 05:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bpfs73AH+E78qFmfEMQb3gH3rOcUGJMzs7Dkn5fG7yI=; b=duRVRjFgZalGAZqrT6ACU+yfod
	Nn0vK54zfe5YihY16HdhXZExNL+ixvG9PsA0WXQvx9ELnCGvVzS7jBPJQMZ0EO22nDbVS45DkiRSt
	HVmjvNsJQ5ctKnJimRJgGrqYsOq/KuPT55G8M1fBWjqHP8Rzgn5qE8QQeeIm0cE4Eu7dGOUd8SJzh
	SSb11Fer0fzU/30meEFO90Tkq3i5+N+taHtc/pWx9EWShTpc7XNgRnGjxA0m8Q6qshp0hkenUf94S
	vZZopYPQXfcc9DFwPviFBfSXFTlt8JWvJtvOhuHsr6/A/TxObUuu8mJiZAfgWSwdjw0LUPXCh3A41
	X58ErGEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKBdK-002KVe-6b; Tue, 24 Jan 2023 05:14:10 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKBd6-002KRu-VC
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 05:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674537236; x=1706073236;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xhsLLnFkBeo3YENoP+94UzNs/u8/NVGwlLQQb1uKMpc=;
  b=H53b5SpyZMyTH0T24uOVeKHekiDntdO8BxwXhZ8ofSJQz4VsvlagwDfU
   DY6JXQQmn/EIL9zhPvCliya1JHwyeyHjIsJ2QftHWdzIuzitEI+1rgMO+
   ukZDxO9ECgaZKqlWS2BN2z65xLRAKWW/DdtIMJJ0vwGf4zj0ftBBZyKFC
   +c49Yj1Eoh4ZmuhzV+LbS7SMhi2zMRXHaVOHehzkgkWrcSiKtOZP4T4CR
   6FpyUt+sDgaKEtXGJlx4abToaW/uQUl2rqJ9qvaUIvMc1f4aLHfLMRoPP
   UWYVy1HgdVyQ3iTTTNz3YniS44ADnuAl/uoz6EIx8VbYmWD5UeFvl+ln+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326265221"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="326265221"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 21:13:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="907364280"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="907364280"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jan 2023 21:13:43 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pKBcq-00069n-1W;
	Tue, 24 Jan 2023 05:13:40 +0000
Date: Tue, 24 Jan 2023 13:13:19 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.3] BUILD SUCCESS
 202708ad84639fb8a3ab06322a5117c390afc879
Message-ID: <63cf68ef.a37U5qEbDZA1bGba%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_211357_144006_6AA7AC6B 
X-CRM114-Status: UNSURE (   6.56  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.3
branch HEAD: 202708ad84639fb8a3ab06322a5117c390afc879  nvmet: for nvme admin set_features cmd, call nvmet_check_data_len_lte()

elapsed time: 725m

configs tested: 72
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
sh                               allmodconfig
mips                             allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
x86_64                              defconfig
i386                 randconfig-a001-20230123
arm                                 defconfig
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arm64                            allyesconfig
x86_64               randconfig-a002-20230123
x86_64               randconfig-a004-20230123
arm                              allyesconfig
x86_64               randconfig-a003-20230123
x86_64               randconfig-a001-20230123
x86_64                               rhel-8.3
x86_64               randconfig-a005-20230123
x86_64               randconfig-a006-20230123
i386                             allyesconfig
x86_64                           allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
x86_64               randconfig-a013-20230123
x86_64                          rhel-8.3-rust
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a016-20230123
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-k001-20230123
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

