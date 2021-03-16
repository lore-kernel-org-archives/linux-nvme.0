Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDD8C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:53:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5458964F91
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5458964F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XgG0rNm/emDr66NfXqH4XY+/XQamDzDQGOpE6ogJvGI=; b=IR210oER/DIc6b+HhW/pUDIAoC
	SUkfjX431d7G/Our+KbocXygBnoWeXs2URBcDXmt7BuqmZ6Ax8XB7b0e60tjBO2RG9afX1skgIUhY
	EiDpqD/ye0b8w1S8d3s7RFzi2AQU/xHXqASlgVS9cRMP7SQwJsPYac/LQL3xkcZChbBt7uS0M7u0q
	Z8w7Jv+oTsSFoV9q0kPagNJjQwa6oohHqDqexXF2y56UAxMxISoj3vbWvkv/3K1FOTZwTyWZasYJG
	UMn5dMAtpqhYIe57aVVjFrSXcW83nPUw/X1B1He7N7E4Vn4ac+TqZ+G3kYS1QHCWfjw55KPVx3NhZ
	h5sHM4gw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM0m3-00HMId-Bc; Tue, 16 Mar 2021 03:53:39 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM0lx-00HMHe-Rq
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 03:53:36 +0000
IronPort-SDR: 7uTNCAuTz19jOY7XTtwqiI/pFomaxNLq63I03pufyH4eo/fxe+6syBsqgvPLgoAMSv9ZMXahKh
 Vljgtln1sMfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="185834479"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="185834479"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 20:53:30 -0700
IronPort-SDR: kcXxWuQQ8so1p5SmkgqHIifq9eWqHPK+I8b0UR6DGzJu8O+xTzM8Dud3W76j6jwpBiWbMTf6e5
 SkxPCLBsKlVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="601681409"
Received: from ceph01.sh.intel.com ([10.239.81.165])
 by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2021 20:53:29 -0700
From: Zheng Wu <wu.zheng@intel.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, Wu Zheng <wu.zheng@intel.com>,
 Ye Jinhe <jinhe.ye@intel.com>
Subject: [PATCH] nvme-pci: add another device ID with stripe quirk
Date: Mon, 15 Mar 2021 23:22:18 -0400
Message-Id: <1615864938-6757-1-git-send-email-wu.zheng@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_035334_749010_72D084A9 
X-CRM114-Status: GOOD (  10.24  )
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
