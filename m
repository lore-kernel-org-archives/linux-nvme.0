Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919A2C6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 06:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9H34DQE0u7juNp5pCDo4aOTJ7DH9P+BK+orV5xeC2ws=; b=NvZAQ76n9AqQM47T1yuIo+J3A9
	NpDb/fgYG3j19eirAvICOPye1zgOAf0mN5K/7xgu9eDpDqzOoDcwgt1VfwrrxGcF+bQWSBPdOSfcJ
	Es/G44EwNul9KDUptIQR1isHnvaV0/V4cjRWSNfCOjTRwxLnxDC/5IxdLeZyUdXaDmE8YMUvk0hXI
	/3gFxt+e7ki1Ria8C3cEagD4zpC2pfxAgf3zdfGgJzhu95SwDyrTx+OqXXigqC0Zno/8d7uyZM1L3
	TPBW5R3KAPbwI6XcEeZaX7e8MnHaINbZ/ewHuo8thTMix4F2CK75sjIYOblkHES3VhtGOxycbXwSb
	QnsEYQ5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pch0t-00FLMY-1J;
	Thu, 16 Mar 2023 06:22:59 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pch0p-00FLLU-2B
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 06:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678947775; x=1710483775;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FKBeVgN14sYuS0f9kQfumNGucfUWSN6r7BU4GqDVRFQ=;
  b=HMePYSLpu7YaUxQIJ7Kku0vED/tHwXiFW/tZj61TOBD+PeQOniWh5zop
   SY1ttLrNME1z83nHc+WfZfuzT8im+zmg3WkuAULOyhH7zYyIw/jX+ZMWD
   Ub2IxQqm3jWgOfDQCB+DKjWx1TNjHy+9l2JygTaFuOW+4pnO1YN3sAcMu
   gMCSkfKAyRttrKeloICXQOdPc4X37KtDFPbPVdVHIH82POpGbqTEGgPUy
   WE4vxENwza6NBOu+505TuRKinbLo3zIbx1cGkk3gnfZG/0OlCeGbq4CUo
   79dEtvSIz6EJqkruQM0eVwQMns+MKUTyCi5FeykD799PxsYJPecd9e7nS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339433680"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339433680"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 23:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="629741911"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="629741911"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2023 23:22:23 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pch0I-0008ML-2j;
	Thu, 16 Mar 2023 06:22:22 +0000
Date: Thu, 16 Mar 2023 14:22:11 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.4] BUILD SUCCESS
 2ac5d39f23db707997ab35cd050964fa1a9c19e3
Message-ID: <6412b593.02ocjNDVKjBTz2pP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_232255_756721_22A9DD10 
X-CRM114-Status: UNSURE (   7.51  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-6.4
branch HEAD: 2ac5d39f23db707997ab35cd050964fa1a9c19e3  nvmet: cleanup nvmet_execute_identify()

elapsed time: 756m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230313   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r036-20230312   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230312   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230313   gcc  
arm64        buildonly-randconfig-r006-20230313   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
i386                 randconfig-r032-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230313   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230313   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230312   gcc  
microblaze   buildonly-randconfig-r006-20230312   gcc  
microblaze           randconfig-r035-20230313   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r001-20230313   gcc  
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r003-20230312   gcc  
openrisc     buildonly-randconfig-r005-20230313   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r036-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230312   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r034-20230312   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r034-20230313   gcc  
sparc                randconfig-r035-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64               randconfig-k001-20230313   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230312   gcc  
xtensa               randconfig-r031-20230312   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

