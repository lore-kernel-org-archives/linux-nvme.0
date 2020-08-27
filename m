Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6BDC433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 22:52:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6235420848
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 22:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ynKyO89W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6235420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i8XE43A2YBXIcMNAkoNGRiIudUxhe+sQ2FYo1CFUAMg=; b=ynKyO89Wpl0+tmyf9OiQMwMe3K
	MI55UGYH29cQouUsMZJfHXC8pmym256iuPP9NJSI80tZG/E7y6ZAsrz50zyYfcIUTW/kQ5pmLC+X6
	wP56rLZY3a5IS5Z6wP9xW7Dpl9UkNEfaLN+8eDlnpEUffKjWRuTWorTRel8JAMqfv97lQNVuV7Ue4
	YNfHlC1Ew9ZaryzCHa2y98Lst3mFgcqo44+OcRRCBgN7WduWOoQK+EctBlibSY9H1kVQw0CRAlckG
	Gtb2qTbh4fqTsE7j5aFbatpW1AKGlcrF9uRxayBIANC/l9RlJfWqPAUM9TO/smvYh/ybpI5EqeuJ4
	U82pAsyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBQko-0002le-5T; Thu, 27 Aug 2020 22:52:22 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBQkk-0002kg-DY
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 22:52:19 +0000
IronPort-SDR: FHPRGsLGJr9g/0jgF/Sg29f8mXce+biStMwv1b8zejbb49YmBfWHEG3yY9vks4QzB7j4bQZcH+
 nsQWQj1Sc7Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="218129916"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="218129916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 15:52:13 -0700
IronPort-SDR: RD4G/iYuDMhevdVmNl4TiFK9OQa+78HTPeKhdECI6eaheUJnxncngMPxBLBMv/X2v3lb7d2X3e
 NBvwETNr0ylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; d="scan'208";a="403557969"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2020 15:52:12 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kBQkd-0002Lt-DZ; Thu, 27 Aug 2020 22:52:11 +0000
Date: Fri, 28 Aug 2020 06:51:54 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.9-rc 14/14] drivers/nvme/host/zns.c:170:46:
 warning: Uninitialized variable: buflen
Message-ID: <202008280649.9cVOp4Mh%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_185218_592295_2DDC1EBA 
X-CRM114-Status: GOOD (  14.77  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, kbuild-all@lists.01.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree:   git://git.infradead.org/nvme.git nvme-5.9-rc
head:   cd83b396e350d2f13bd2ad81565255f77a13aa3a
commit: cd83b396e350d2f13bd2ad81565255f77a13aa3a [14/14] nvme: fix error handling in nvme_ns_report_zones
compiler: sparc64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/nvme/host/zns.c:170:46: warning: Uninitialized variable: buflen [uninitvar]
    c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
                                                ^
>> drivers/nvme/host/nvme.h:523:10: warning: Uninitialized variable: len [uninitvar]
    return (len >> 2) - 1;
            ^

git remote add linux-nvme git://git.infradead.org/nvme.git
git fetch --no-tags linux-nvme nvme-5.9-rc
git checkout cd83b396e350d2f13bd2ad81565255f77a13aa3a
vim +170 drivers/nvme/host/zns.c

   158	
   159	static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
   160				unsigned int nr_zones, report_zones_cb cb, void *data)
   161	{
   162		struct nvme_zone_report *report;
   163		struct nvme_command c = { };
   164		int ret, zone_idx = 0;
   165		unsigned int nz, i;
   166		size_t buflen;
   167	
   168		c.zmr.opcode = nvme_cmd_zone_mgmt_recv;
   169		c.zmr.nsid = cpu_to_le32(ns->head->ns_id);
 > 170		c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
   171		c.zmr.zra = NVME_ZRA_ZONE_REPORT;
   172		c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
   173		c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
   174	
   175		report = nvme_zns_alloc_report_buffer(ns, nr_zones, &buflen);
   176		if (!report)
   177			return -ENOMEM;
   178	
   179		sector &= ~(ns->zsze - 1);
   180		while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
   181			memset(report, 0, buflen);
   182	
   183			c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
   184			ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
   185			if (ret)
   186				goto out_free;
   187	
   188			nz = min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
   189			if (!nz)
   190				break;
   191	
   192			for (i = 0; i < nz && zone_idx < nr_zones; i++) {
   193				ret = nvme_zone_parse_entry(ns, &report->entries[i],
   194							    zone_idx, cb, data);
   195				if (ret)
   196					goto out_free;
   197				zone_idx++;
   198			}
   199	
   200			sector += ns->zsze * nz;
   201		}
   202	
   203		if (zone_idx > 0)
   204			ret = zone_idx;
   205		else
   206			ret = -EINVAL;
   207	out_free:
   208		kvfree(report);
   209		return ret;
   210	}
   211	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
