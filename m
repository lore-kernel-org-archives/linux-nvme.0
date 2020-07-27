Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FECC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 20:04:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942362074F
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vgnTq2/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942362074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A8orip0zOZTnL+5K/xcDd5NG70Dyn1cZdiDirUFV7SY=; b=vgnTq2/ahdCBrmATxTAcbgztHr
	qYqFCoSu61QR7ADoRET0Nvv2xxtN2TQmqspzUWB/HNmA9C5EJ5T+LZ6NLNJIr22vjm/6vblxldNqS
	T8ylVSG9iugPOOhfTattaXLQW9xEAqLObsKaticdCSjWIJ11tqtyC7lnsTJs1IB5Rtry+7Z74XrVO
	/C3iOSPzDKrp2ywNjeq97XiX6N0auddDW+Fk10ZcjALoR6dmmQyGVgCXmMGIuNpv84HHMxUqzx64P
	AAPEeHHhErDC47D6CPUiZEvXSG6A2jg3Ccve3sSDlYwJ8AutGRllWfqJmIp5WouaMLTQkr6S87qx/
	WBzrtGTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k09MR-0001Vn-Tj; Mon, 27 Jul 2020 20:04:35 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k09MP-0001Ud-4d
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 20:04:34 +0000
IronPort-SDR: wp5LLMbmZvavQ7zP7dLULuPVj/b0WGAYFoHmgZf0PyN6BoW5yK0YlD0J/5lVj6N7ure11NfjJE
 9herQWnRNgkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="148972845"
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; d="scan'208";a="148972845"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 13:04:29 -0700
IronPort-SDR: LnrBCLKo20k4RJOgXsR/VLFRySSMj0KZotBzve6ZCKzumuARGrAVtYFp/qVAXd7ZCZ1lv5PryN
 xTVxWmeinPuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; d="scan'208";a="289914175"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 27 Jul 2020 13:04:28 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1k09MJ-000227-8Z; Mon, 27 Jul 2020 20:04:27 +0000
Date: Tue, 28 Jul 2020 04:03:30 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.9] BUILD SUCCESS
 5d6e41c61837fad21016527bdc1a885394f36c28
Message-ID: <5f1f3312.hH77X/4b+zBXzAuV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_160433_338114_501062C5 
X-CRM114-Status: GOOD (  13.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree/branch: git://git.infradead.org/nvme.git  nvme-5.9
branch HEAD: 5d6e41c61837fad21016527bdc1a885394f36c28  nvmet: introduce the passthru Kconfig option

elapsed time: 1698m

configs tested: 50
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
openrisc                            defconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
sparc64                             defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
