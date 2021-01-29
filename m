Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE693C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 06:55:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B66364DD9
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 06:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B66364DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+9kyUN2kQQvTnyC6RymOspoz+gwR3peFtqEHRIJsGag=; b=q9ERlJ7ZdGD5UCWqfDFuh65GTr
	1VQ/GC60Cbs64PRdref8F42+Oz1FVN1UfwczWRFjrNnhh3ayTodQGsE0ZxMYSH7JdczVDacgo7080
	PT1Ka3sugPCfLbCaYekflOST+KRndZw7uiXjse1q8bDs6XZWCfVilV7zIgNnUrHDwNoFb6I+VIIaz
	ZNdc5lKWVP8i6B7SygAeVv6tEzi460l2goD7h0jbWSKW84kSdzxt+fMzzcOelI/Vts/g/TdKywI58
	3WqQViJstwMcyZHMydgj/mebhJ/z9o54h0bEUNcKVrmN/vn6haV5ppqF0y8KrdTj1iKn9hYbrilx4
	P2RWnUYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Ngy-0006te-Q8; Fri, 29 Jan 2021 06:55:40 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Ngv-0006sV-7C
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 06:55:38 +0000
IronPort-SDR: j6qQtc/fI3EdH+3PygLvZINCwKa99w6FKWXzCOkhm0b+yuirBNbXv2bNrt3udJcKIRXKOwpt/V
 3ZSl1mLw+dEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="180518265"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; d="scan'208";a="180518265"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2021 22:55:33 -0800
IronPort-SDR: RVgQjewOBYEzrwpovvMaW0JqC6szwjeVMRQw9wHo1aqmvvfBGRE9NJMBzl5gbnPUAbzktO3RS3
 Jy6cTz8iP9wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; d="scan'208";a="370247938"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 28 Jan 2021 22:55:32 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l5Ngp-0003dA-HG; Fri, 29 Jan 2021 06:55:31 +0000
Date: Fri, 29 Jan 2021 14:55:26 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.11] BUILD SUCCESS
 772ea326a4a00b6b4b2c8f3606ad10c31f46c511
Message-ID: <6013b15e.kDD7qEw96xUK70Cx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_015537_409538_908B02E9 
X-CRM114-Status: GOOD (  10.57  )
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

tree/branch: git://git.infradead.org/nvme.git nvme-5.11
branch HEAD: 772ea326a4a00b6b4b2c8f3606ad10c31f46c511  nvme-core: use list_add_tail_rcu instead of list_add_tail for nvme_init_ns_head

elapsed time: 722m

configs tested: 25
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210128
x86_64               randconfig-a003-20210128
x86_64               randconfig-a001-20210128
x86_64               randconfig-a005-20210128
x86_64               randconfig-a006-20210128
x86_64               randconfig-a004-20210128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
