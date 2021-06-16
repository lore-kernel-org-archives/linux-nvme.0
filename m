Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9350BC48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 03:23:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5049561246
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 03:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5049561246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UGafXtq+HZ5d2G8Aq7nnqMKeuLhF4WfXldDCl7OdVKY=; b=S1AAOcghkgMhf9
	FvWOjSooFmz7UQjlCyi6vrkF00L5ALGHi7b8HabTpMBl75aJ9/BdErah+jwrzaQwVXb6cJPZC7OTX
	c7G4EbhJGVaQ8MTlSVuc5cv9bSmDbRPbyM/5OylQ9WBJFYPBty/aXDA/fmRm5/cK7HprXXVPSTwZC
	6vefMtKXqzJND/yg533ak/D1MpNCJlatlr7BTesenuZTHoFMR4uz+WzCSEZHTBxaGUgbsI0IBBh2Z
	Web1IBJBGRXmkH35ec+mR2VYKqsngR+AooylAM4/ob1aEa/vAUAXpmPCDmQHxqk6rO3fEyq/F+ROM
	+1KJqCY7mECZEMWYRK7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltM8v-004Ymi-2F; Wed, 16 Jun 2021 03:23:05 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltM8s-004Yky-Cf
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 03:23:03 +0000
IronPort-SDR: skir3DqoQ/XTtlDbWRstW0EH57a9GzgnEcdjORaPQ/t7P/9vbhvSXSVc8y1KJQ4N4U4VfFLbSn
 I12/Ylwexz+w==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="186482934"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; d="scan'208";a="186482934"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2021 20:23:01 -0700
IronPort-SDR: 5AV5tpTpjU95tJUq2fcAIdGUqGPaBixoklIM8aQ8JaXeffthZS6CN0PyQ51itLFjRhmZfdjNmN
 wPkzdqjbcu4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; d="scan'208";a="553897769"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 15 Jun 2021 20:23:00 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1ltM8p-0000mS-DH; Wed, 16 Jun 2021 03:22:59 +0000
Date: Wed, 16 Jun 2021 11:22:19 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH linux-nvme] ACPI: storage_d3_cpu_ids[] can be static
Message-ID: <20210616032219.GA70875@d00c18f5cb94>
References: <202106161145.HdBOaJkF-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202106161145.HdBOaJkF-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_202302_468588_2FA6E4EE 
X-CRM114-Status: GOOD (  12.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

drivers/acpi/x86/utils.c:153:25: warning: symbol 'storage_d3_cpu_ids' was not declared. Should it be static?

Fixes: 7c20093d34bc ("ACPI: Add quirks for AMD Renoir/Lucienne CPUs to force the D3 hint")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 utils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 5298bb4d81fea..f22f23933063b 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -150,7 +150,7 @@ bool acpi_device_always_present(struct acpi_device *adev)
  *
  * This allows quirking on Linux in a similar fashion.
  */
-const struct x86_cpu_id storage_d3_cpu_ids[] = {
+static const struct x86_cpu_id storage_d3_cpu_ids[] = {
 	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
 	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
 	{}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
