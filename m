Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E714C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 04:12:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366EA650DE
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 04:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366EA650DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XgG0rNm/emDr66NfXqH4XY+/XQamDzDQGOpE6ogJvGI=; b=UkhW5NM+oybH6RiVrkEvizBVyg
	WQyx3jKUAi9d/2CZZpCr3p/jVBjTuu4wJkqE46f0wlXE4D3P4JahgFltPY0MuNlcLOuAvhHpMluwC
	8QbIFnV6pu4yJg6ni+CPqLsRI6897cArId/1q1+uhlINS8sIKFaRaTINQkO3B3i7+DC7f2qNmN3vG
	OKcOa26lJliAAX7BMBBjXel8XMmrfl1AuQ6pgnV1k6sokCQZVr9P8ONePKaBOnxEweKJaubRa0j9j
	tRuOWhSqLFTd24h5xzVYUgq5ftGqMhFqOrEtXoobH/N6wpw/LXOsVxAtj+B2CmEbPRBYXKY+TiFK+
	pd/nArfw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM14O-00HNSZ-Ox; Tue, 16 Mar 2021 04:12:36 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM14I-00HNRR-6q
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 04:12:33 +0000
IronPort-SDR: QLX9N9r9kkYXWPmJLwGP+g5/4gsHax1IGmivSeHd/hRMgiUvABpBaic5erwn+K7LPKHOuKsy/v
 1lYqgrdxMHbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="169111531"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="169111531"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 21:12:25 -0700
IronPort-SDR: RTILn4w76eHbNR7/buv8dUtse7FnWlgEphXlUnXCHf2/yIoYPfy55B54hZJ0ZXIkXWJ9SwCub1
 Mm/DMPKF16Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="601684994"
Received: from ceph01.sh.intel.com ([10.239.81.165])
 by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2021 21:12:24 -0700
From: Zheng Wu <wu.zheng@intel.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, Wu Zheng <wu.zheng@intel.com>,
 Ye Jinhe <jinhe.ye@intel.com>
Subject: [PATCH] nvme-pci: add another device ID with stripe quirk
Date: Tue, 16 Mar 2021 12:12:05 -0400
Message-Id: <1615911125-7947-1-git-send-email-wu.zheng@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_041230_756477_F75354D8 
X-CRM114-Status: UNSURE (   8.94  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Wu Zheng <wu.zheng@intel.com>

Adds the Intel controller of P5510 which has the "stripe" quirk.

Signed-off-by: Zheng Wu <wu.zheng@intel.com>
Signed-off-by: Ye Jinhe <jinhe.ye@intel.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7249ae7..46b872d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3221,6 +3221,9 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
+	{ PCI_VDEVICE(INTEL, 0x0b60),   /* Intel P5510 */
+		.driver_data = NVME_QUIRK_STRIPE_SIZE |
+				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_MEDIUM_PRIO_SQ |
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
