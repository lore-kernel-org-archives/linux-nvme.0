Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B135C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 08:48:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C8764E28
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 08:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C8764E28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xEYaHqUro8oFBvLNvDVU5dRMkd8FwA2li2pWlwFhzno=; b=kqDF39KC/n2QLqVJesz7WCyF7
	yD1Et5hp2w+sUIuzQgBBxA+8ZxzCCoN5VXalagp0w3lvcA4Xhj5XPliPiRafbZTc1+ocf1PNBqflW
	HCBfJUd8SzecJ4or/ekPw9CU2jNbwg74J3cUllVoaNWt/9w4Hc4FpgGh9/sJf59QkM1JIpBGsXgZ2
	no7gBGdYo2cnVTEaCVFKvezVKtjc/N5DrNynAHyNEFVQ+HQw/n8TLoSJzCZTjYzLiJ4xn1rMd8cpM
	+RF5HKylEKhQIw75PifWqZQcIlY2/Hpl/I4VnAvutx2kPMAwxwT9VIdyM6jgFaxuulUrNccymmZcW
	uSDrOdMdg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFXNe-0007K4-Cz; Fri, 26 Feb 2021 07:17:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFXNW-0007Gj-6w
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 07:17:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B9356AD57;
 Fri, 26 Feb 2021 07:17:32 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] nvme-fc: set NVME_REQ_CANCELLED in
 nvme_fc_terminate_exchange()
Date: Fri, 26 Feb 2021 08:17:27 +0100
Message-Id: <20210226071728.106923-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210226071728.106923-1-hare@suse.de>
References: <20210226071728.106923-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_021734_500401_02C6F9BF 
X-CRM114-Status: GOOD (  13.04  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_fc_terminate_exchange() is being called when exchanges are
being deleted, and as such we should be setting the NVME_REQ_CANCELLED
flag to have identical behaviour on all transports.

Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 20dadd86e981..ef12a619daec 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2443,6 +2443,7 @@ nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
 
+	op->nreq.flags |= NVME_REQ_CANCELLED;
 	__nvme_fc_abort_op(ctrl, op);
 	return true;
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
