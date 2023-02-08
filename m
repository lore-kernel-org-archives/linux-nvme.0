Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76404C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fHMvhYuTtLs7ScAdHBNTj3xLNtKWd1wFTHeBvetH/2U=; b=1MQpb0TjCZarHyQM8wqnbmw63+
	1ZiRuVAMjzj5ksGcws059CEHdXqDWKhvzlGGpn7aascptCDQ0Gp7TqVL1a4z4/HdS6LNgbuOqmmZw
	emFEMnHojp/qO6AD1RnCDbAkYGs8eDd6M0Q2GAspRXM6GU4gIT4Ddvtp/AHylurNcqFvauaAYha3Y
	AvjiOZYN0rAN9te9MK+9qFvWPw+fZ3GKOiAvtlpLvJqGQ4oG04Iwv/cWfC6QKdez/xsqSfe2NRRGv
	hA3JZWN2fHUiCoxf/EnoUXytnoZfXkhcY9sTqGJZ9uOOk1QtHLOEZ8ERfgVf9A6K1A9XoEZcMB8r/
	ekvXjRnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPpTo-00Gf6e-BE; Wed, 08 Feb 2023 18:47:40 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPpTl-00Gf5r-5r
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 18:47:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675882057; x=1707418057;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tWU/q4cFiEmJoTnZ3UKetd8/4etWJ5suwQh8HCjM8es=;
  b=mccdOH/Bs2rYQEOGK+xkAIHi0ZK8p2p9/Svrqr1JXnNCsjCWUFhLHDr8
   sAxrWIcVf9H58T+QQewzGo5GMtR0Fzl+jvilCGVj7IeSlovsJgbU+jlge
   n3G78vZA0aNuHpFkasIoiL1baz56Lm++AMAHZh1fqvquZWFGb0ZSgi8Kc
   xdYlYx3ExOfSdcgcdBHddqcKZ9ec9q6TKIEu80a+w3hOMOneewE2NsPgc
   nxJqh1mFhC3Nq+JKdv11sMfiqMVy0kzUsVY13z31wcAb20AII7NY/0Ua+
   jhlLuLpq35OT1YEU4xqkKTXa8hvielGjWT8XeRTG9JVtIoiMAbBRTg8Eh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="328543317"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="328543317"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 10:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="736036814"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="736036814"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 10:45:11 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pPpRO-0004ak-20;
	Wed, 08 Feb 2023 18:45:10 +0000
Date: Thu, 09 Feb 2023 02:44:51 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.2] BUILD SUCCESS
 70daa5c8f001e351af174c40ac21eb0a25600483
Message-ID: <63e3eda3.7UIlmf6dJqozjh98%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_104737_316945_ABC012EC 
X-CRM114-Status: UNSURE (   7.71  )
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
branch HEAD: 70daa5c8f001e351af174c40ac21eb0a25600483  nvme-auth: mark nvme_auth_wq static

elapsed time: 730m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
x86_64                           rhel-8.3-bpf
um                             i386_defconfig
s390                                defconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20230205
i386                                defconfig
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
x86_64                              defconfig
riscv                randconfig-r042-20230206
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
powerpc                           allnoconfig
s390                 randconfig-r044-20230206
arm                                 defconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a014-20230206
x86_64                           rhel-8.3-syz
sh                               allmodconfig
i386                 randconfig-a012-20230206
x86_64                         rhel-8.3-kunit
i386                 randconfig-a016-20230206
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
ia64                             allmodconfig
x86_64               randconfig-a015-20230206
x86_64               randconfig-a012-20230206
i386                 randconfig-a013-20230206
x86_64               randconfig-a016-20230206
i386                 randconfig-a015-20230206
arm                              allyesconfig
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
i386                             allyesconfig
powerpc                     stx_gp3_defconfig
sh                          r7785rp_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                  nommu_kc705_defconfig

clang tested configs:
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
arm                  randconfig-r046-20230206
hexagon              randconfig-r045-20230205
s390                 randconfig-r044-20230205
x86_64               randconfig-a001-20230206
x86_64                          rhel-8.3-rust
i386                 randconfig-a002-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
x86_64               randconfig-a003-20230206
i386                 randconfig-a006-20230206
x86_64               randconfig-a005-20230206
i386                 randconfig-a005-20230206
x86_64               randconfig-a006-20230206
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

