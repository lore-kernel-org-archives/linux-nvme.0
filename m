Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE71C3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 20:09:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8C021883
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 20:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mMRV9KrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8C021883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wLoFhCFAwyKZgymqaFOn+jkZP1s1pikf0cT7buYtJUM=; b=mMRV9KrBL0Vg45
	uHzq+aq3iirqZ2tkt/BP747GcqW4xkWnBT/R2HbQ20snB/QgNK928veneKmsvLDlI8dofGbtZrutz
	7Fhja5v83xn7UPMFvXZ2a9jwi97ycAjY5LzcB3IGQ9jUPFBsLS8iozxdMN8VCoWhTWiwVfaagmS7k
	81JK8wwMnUp0glnfoxxrLEQmwKdywTDE2elKEA+1Te9BcVr+kH9uW8S5zpUaMAapToVA7tz63QQm8
	2TdXqZsDuy2VMdZ7LqwcZyAQd+FM+Zc7efCLPpQDMAid1uSLbYktNU3+lCI1nFTP5FMzyMqbBFmQ3
	WlyCgbb7GFtRgknLy2GA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5F7F-00079Q-Bs; Tue, 03 Sep 2019 20:09:25 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5F7D-000793-Dh
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 20:09:24 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 13:09:15 -0700
X-IronPort-AV: E=Sophos;i="5.64,464,1559545200"; d="scan'208";a="187375428"
Received: from caliente.lm.intel.com ([10.232.116.25])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 13:09:15 -0700
From: Edmund Nadolski <edmund.nadolski@intel.com>
To: linux-nvme@lists.infradead.org,
	keith.busch@intel.com
Subject: [PATCH] nvme: include admin_q sync with nvme_sync_queues
Date: Tue,  3 Sep 2019 14:08:47 -0600
Message-Id: <20190903200847.3378-1-edmund.nadolski@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_130923_506176_C81BE21B 
X-CRM114-Status: UNSURE (   7.03  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_sync_queues currently syncs all namespace queues, but should
also sync the admin queue, if present.

Signed-off-by: Edmund Nadolski <edmund.nadolski@intel.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4660505eded9..43c12f8c030f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3974,6 +3974,9 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_sync_queue(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
+
+	if (ctrl->admin_q)
+		blk_sync_queue(ctrl->admin_q);
 }
 EXPORT_SYMBOL_GPL(nvme_sync_queues);
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
