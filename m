Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49600C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:28:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F9B60F36
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17F9B60F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E/yilPpySpdAeUu9ZYQ/pFjxuUf20yOpWq9NJPiLpEA=; b=XwLE2U/TR8OZGm
	aqcD0Nwj0TkAmBmifgCYEXtwLh3o/W9nG6C7fWNxptxsFjRzXYhJf5A+PNPPBZLOm6hlWqLl8MQCS
	+akWH/crt21b+rd9g77XdqJY/JrOqZEXNA+RH3/3k9ZbYKz+qyvHk091ovdHMYGg4bFLjzDx2KNhS
	Tvkizhcd01FCLg4SdaeQc7I6E2nn3fhHTCwKNgK/9D7X9P/dJJJTfDzMS7nN9oGf+43nY+pRrQjXF
	SjNcptp0SIcB8gJRffJRpwoglGbBkOdntSk0PT/SGF17ksS5uwohTuXVUA64byiiIJLCBWDho4XYE
	3pvjQE2vtZT7aw5vbOCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAW6r-00FvxJ-F5; Mon, 02 Aug 2021 11:27:53 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAW6B-00FvfH-LI
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 11:27:15 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0F9A01FF78;
 Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627903628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjJI5ui+lBKS/7eBpcH/R0Ll/x+qjOPveqmd5g+MLNM=;
 b=pmc7yMXNZHzNxQM7hWeIfeCrTV5J9weTsC74c16kx5+kswdc1GaPgkxwNGldY815Nq7Ndp
 pQlu+V+k8SAN5h55bv0MSMCy3CrpnI11moyx1p4Z0QaWFZLGJ5YpvEFfqyf6uxAI5IKg6S
 MO1HBAbNRa/gbdktb6Ir3XJkPjqlfDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627903628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjJI5ui+lBKS/7eBpcH/R0Ll/x+qjOPveqmd5g+MLNM=;
 b=+HHyyclvZT9XLW/jlkq9yHca4+G68e0IuzCh2moB5zkZ6mrzICxLb30EycZs9dcIL6wPIi
 zks4sBsE5H6edEDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 00BAFA3BC7;
 Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id E1568518C0AC; Mon,  2 Aug 2021 13:27:07 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, Daniel Wagner <dwagner@suse.de>,
 James Smart <jsmart2021@gmail.com>
Subject: [PATCH v4 4/8] nvme-fc: Wait with a timeout for queue to freeze
Date: Mon,  2 Aug 2021 13:26:54 +0200
Message-Id: <20210802112658.75875-5-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802112658.75875-1-dwagner@suse.de>
References: <20210802112658.75875-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_042711_895646_2E838432 
X-CRM114-Status: GOOD (  11.35  )
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

Do not wait indifinitly for all queues to freeze. Instead use a
timeout and abort the operation if we get stuck.

Reviewed-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8a903769364f..dbb8ad816df8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		dev_info(ctrl->ctrl.device,
 			"reconnect: revising io queue count from %d to %d\n",
 			prior_ioq_cnt, nr_io_queues);
-		nvme_wait_freeze(&ctrl->ctrl);
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+			/*
+			 * If we timed out waiting for freeze we are likely to
+			 * be stuck.  Fail the controller initialization just
+			 * to be safe.
+			 */
+			return -ENODEV;
+		}
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
 		nvme_unfreeze(&ctrl->ctrl);
 	}
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
