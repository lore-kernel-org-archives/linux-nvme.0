Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB8FC00A5A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 05:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F5VcMgW41RveZ5NnAq+v5r9arAcH73/XMBuZYVwycI4=; b=JooYJKE/rQuXjajeXuVAGDVxHr
	OYiza5V0UnWIEe4iDKdP2cLIG+MGfEH1HKO9x+JRwUTt8lc7m62K1SbS2LWwU2PO7Z7nn57YYTBi/
	WPYURgtlepHUtU4A7CPGLe54GQy0Va1esWupBLiM324EWJsNHDjddY4zl9GGUz0pXZbR9Ytv/zMq+
	o/HHLAew5f0nWqONk3yBm3nRF1PJOpSgoiaKMAEwixVlXO6sEv5VSymQwhJfDwf1uzWNwWZ16EuOA
	YrpYEUDiZE8YJD86OcOnwBkzif8nUb9Vp/mtJGgDoJDyP+p6sn8ClyWJK/t6yKG5v2JAbE2u3EepF
	ckjcK20g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIN5y-003d2L-6e; Thu, 19 Jan 2023 05:04:14 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIN5v-003d1T-VY
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 05:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674104651; x=1705640651;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=enlbCRlg6zwacngzPUNGowRfn0PQjWTgsDy9rtYZHi4=;
  b=Gch0C5MaoowdOj05vOk8SOHr3d8SnmlRmAGMI2KGlFHv+RGCe/PVYR9r
   XMNT+JBuHs7oAy5nR4YO+KLaxa6EYwsiCUWT07KCD9t8Zm58k7wXLoKqn
   I8/BdKYWfzcIfVC6Y6mQTfWpNy6MkV1oXeDQ9ECN00UtMKH9DrTHhIS31
   XprsGvDkUBwo05uPdYjyYKELqqmtdxW2bquNMOHc464UMvXH5jn9P1Uob
   Wfox3xljJmc5Qgv0B+I0FtZKyuVTxWfQ+ouYm3DGdb5GtQpKTe67YpyP1
   7E8m7smjPR+1+CqgkZme+WjAcCmwaqMqfIsJgvPObzgYkQprq25OCOQbi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308753649"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="308753649"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="728514436"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="728514436"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jan 2023 21:00:33 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pIN2O-00016o-2P;
	Thu, 19 Jan 2023 05:00:32 +0000
Date: Thu, 19 Jan 2023 12:59:54 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: [linux-nvme:nvme-6.3] BUILD SUCCESS
 41b9cdf87cabe07490dfb149eb904c199972a49a
Message-ID: <63c8ce4a.rRHBKxuyWnUfZ8KW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_210412_097734_C09DBF9E 
X-CRM114-Status: UNSURE (   9.33  )
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
branch HEAD: 41b9cdf87cabe07490dfb149eb904c199972a49a  nvme: remove nvme_execute_passthru_rq

elapsed time: 729m

configs tested: 76
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                       omap2plus_defconfig
sparc                             allnoconfig
arm                           tegra_defconfig
arm                         assabet_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-c001
powerpc                      mgcoge_defconfig
sh                        dreamcast_defconfig
sh                           se7722_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
m68k                            q40_defconfig
mips                     loongson1b_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                 xes_mpc85xx_defconfig
mips                     cu1830-neo_defconfig
mips                       lemote2f_defconfig
arm                         socfpga_defconfig
arm                         orion5x_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                        spear3xx_defconfig
arm                        neponset_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

