Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095C1C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 06:38:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FFC64EC0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 06:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FFC64EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fm6PbpAyHPCfYSIjp5UnJmipFi9YNtXtXy5CvEeUHwA=; b=RrWMWVcUrYHRlJAPOltivbCZBG
	jpUtSb84ReAQZVRpRUo4G4JgjM3ARyPlfvsoaTkm4Y6m3aMql5Rm11G91csi1KGJIJLaZ3yd9DyQg
	Wc2zueOxJNNFG55z1QPufFWBQeQjEF2V0t9D5MLWpK8qVtY46F9mDDtaWIk25svG3KdqBrx381UV5
	btvlZDhNIsWjvakDtV0MNJseLRetH+PbWED5jn9tNl4qW4lStYn8dlAVTqIu5zJEwLsrfnXZmmaRd
	8FH1jhwbAinJAErcpr5IND8PXbzulsiXX8BSwYVnD6OHAH/7tNMOSGgGhMD8Io5sC2wfMupKS0vV+
	axZSG87g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCzQ0-0000z3-OL; Fri, 19 Feb 2021 06:37:36 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCzPy-0000yf-0J
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 06:37:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613716653; x=1645252653;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ld1bH6SZEQJUWsUmQX7MzLhfTSfx+6fOqXlGYgmbIbo=;
 b=geHzNsCwzDlBGEKDoeHhL5qkGQRl6cvaZ9TABrSKD35KCWIFLYtLiSwh
 QewJ4GCM1E9PVGo0KrD00hW6VYYQRw9FiG45h0bkm+w8fYsbt/HKdJlHa
 30KK9htOCng2/GfgndoAZ2fIon1AF1ya8+2B8ZCAR7yp8eruTefkDyI2h
 C+cjR3NOCVTNFBRnxS/UDFNpfUHb9W1654cK/vc9EddcgOQDddwsJDuhE
 9uQR0kElLOBzQGR6f0vjBqzA5hl3dbSONDZV8/NxNedcF5cKtF0SP6gJG
 2Ur+xsN8lcjHYhMv89zyQaaa6vQaAWtmUTuYA05wilZBibymLzyhSOo5g w==;
IronPort-SDR: SEWNx/fkaNhPQY3ndjla0ZSuMUoXFtuRbL/HraxNS7OYep5tOuxXc4BTSyFkWAOdsOJpcFURn3
 +vjDOkElAD4618KoIt5iqYNMIBuFwfhzj0L5obj8cAmsNCaBZJMRwgu/lUAATntY6BkNpWwYFw
 tCLuluFOtUYDpwdlZcfSIcOWOCdlyhlCVmgBCjKhsb8HLja5G0c2vXC7MQQu8tJOy62V30n/EZ
 sYjuZRu7Kuz8HivLC8q2njQibxL/kR8Enr+DD+wj9YRH3dYK+WBYwr8s5bunvH2HiAob47cwj7
 qLA=
X-IronPort-AV: E=Sophos;i="5.81,189,1610380800"; d="scan'208";a="270863829"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2021 14:37:27 +0800
IronPort-SDR: imu+QPGBMJJRqmEVSJpeVNMhvxXkSw4oMd1yWFLruJhBuTmJurCJu33r3imtq+AFbRv8QXrknC
 G885QPbKFQb9aW5onWiaN1PC5GlkwSc/n6TKhPbC8TC2ama5zIAgyD+DEL1w7WyHf5CdzuepFt
 IxVdd+qkWPaq0t6sbX1glYajzmDw/MD1Mzbo86M6yHHTvHZcztEEd3a2cAvW+pnewWLIgah4lr
 uFOTrHWUu+MzLkVfRsQIzwPyApNZN4G0wAUwdnkjZ4LWlzUT6sPoQqAvDDfUf30aTVVOg53IfU
 QEICPrkoAhPIjnk07TxsR6nC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 22:19:06 -0800
IronPort-SDR: GSxGFBDy2td2h9SyE1JU5e9nbuogSv7SowFK7VlUmLuzlVud5xNHuv4qg3aLSHSZRG/LMn9HLE
 UpPIomxRTz1Wbs+OG3VNnuSxrd2Yy7jjc6j68jdAhDWeAtpbLEJGbSTfIaK2AGkdpPuibqWgxl
 XxdxnCCYMw044OSSTPIMcs8kpuQClxTWgEsZ3QF3Jx/3JeDapTgrRH4Z+tsa24EVRXcLrWijqT
 xHgJYPV2gDyJVr47He1mDM/X5ZnBHmMz2X7ayFqeioCH75J5EV+a7hQULUS4lj+RqDyddceuKT
 Rqw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Feb 2021 22:37:27 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-pci; remove the barriers nvme_irq()
Date: Thu, 18 Feb 2021 22:37:26 -0800
Message-Id: <20210219063726.63728-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_013734_785944_70C81E71 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The barriers were added to the nvme_irq() in the
commit 3a7afd8ee42a ("nvme-pci: remove the CQ lock for interrupt driven queues")
to prevent compiler from doing memory optimization for the variabes that
were protected previously by spinlock in nvme_irq() at completion queue
processing and with queue head check condition..

The variable nvmeq->last_cq_head from those checks was removed in the
commit f6c4d97b0d82 ("nvme/pci: Remove last_cq_head")") that was
preventing  poll queues from mistakenly triggering the spurious
interrupt detection.

Remove the barriers which were protecting the updates to the variables.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0045c5edf629..3729775f6a8a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1062,14 +1062,8 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	struct nvme_queue *nvmeq = data;
 	irqreturn_t ret = IRQ_NONE;
 
-	/*
-	 * The rmb/wmb pair ensures we see all updates from a previous run of
-	 * the irq handler, even if that was on another CPU.
-	 */
-	rmb();
 	if (nvme_process_cq(nvmeq))
 		ret = IRQ_HANDLED;
-	wmb();
 
 	return ret;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
