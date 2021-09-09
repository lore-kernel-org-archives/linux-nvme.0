Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EC8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 11:58:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B596323E
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 11:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4B596323E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gkcc2ORdCc17yrYLH/JSaJVbSuqS0bGgrfme0HXSBAg=; b=aQLtpjoSLZVPh/
	t0psZiaZ0u/n4n123ufYJ0uTg4axq37NK58vZdiNankZ1rtoBVySUoBEQdvbddl2r/y72lrT/Lmbx
	GdGa0stRBxQi3TqmsegerWbqpvfawv/wDDTUmr36NSPdEem20FRI+zST7jr+cD/kP/+7TARkt3XAw
	djSi7iJu3tSfYez7Y5CgidLfiYJYzDi+ItplQhV9CQ9ina7tdytKnAirKWZSapZ89eEpLauAuDaNX
	sANZcgwZnwsdJuJZ/uWOZZvNncwKuiYulTo1+GMld8ZERpUYx6HL5QmaJnFceFMmUmIgKbPrie6UN
	kzXVZwZ1wdKXYk/sWP5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOIgl-009CSm-PK; Thu, 09 Sep 2021 11:57:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOITn-0094vj-Tv
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 11:44:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E496361362;
 Thu,  9 Sep 2021 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631187871;
 bh=6oZCUpyxr2EJT7JalbSNKJm7FX02wo6SvZ2McfbqLOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YX6SpFo425SHwRrvqTZLrGSgY+Fl80Oa4MHkxKSbzK8T7j+2a4W4pM1xaNGozamLc
 dGkNy5KX6Dg7PRab+B/ALgGBj4a2kIbDicPW9//LD2MTipE6j4OhElkj3ENCuMtV2q
 KStzxjUJqi4927wklMsVLTsRCvsHEqmxtZ4JI3P/GYhFxbCO0gCGFZm7VDionLik/8
 BnQg3UyMIAPkJ3f0YUExb+BTsn/FBUe02GZem/0ZCIIGYJrXsVM/hfSAA2pENyKcyW
 QPSSZRRW9Qhc37oJHnZtJcJBRpUYATlWz/3Gv9fX7u4yOe7RaszckHDe8NxJVsxpG/
 4RRYnyPvDMKSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.14 157/252] nvme-tcp: don't check blk_mq_tag_to_rq
 when receiving pdu data
Date: Thu,  9 Sep 2021 07:39:31 -0400
Message-Id: <20210909114106.141462-157-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114106.141462-1-sashal@kernel.org>
References: <20210909114106.141462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_044432_024248_933C2F5F 
X-CRM114-Status: GOOD (  11.66  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 3b01a9d0caa8276d9ce314e09610f7fb70f49a00 ]

We already validate it when receiving the c2hdata pdu header
and this is not changing so this is a redundant check.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8cb15ee5b249..d649b446da66 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -702,17 +702,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			      unsigned int *offset, size_t *len)
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
-	struct nvme_tcp_request *req;
-	struct request *rq;
-
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
-		return -ENOENT;
-	}
-	req = blk_mq_rq_to_pdu(rq);
+	struct request *rq =
+		blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 	while (true) {
 		int recv_len, ret;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
