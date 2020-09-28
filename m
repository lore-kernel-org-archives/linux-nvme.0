Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33B1C4727F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585802158C
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pPD2rfhQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cpTLR7Wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585802158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E4FMaat8AuN5/OwVNnwghCLXOxfqKoYEzaWmB5v59gE=; b=pPD2rfhQYzZpgXdyE3l7vz01u
	5wlCZujH2c8L5GHdK6Mmhn0nBdsotWXsdghO7MuJRSMGFTW/qgV+veppl0cI7eNbRuL2ycHFgB1k/
	C60jxomQw1skjMSfQmQ7RtebF8vtNmfOjdj2I2TGPycMIEF6kHk0ZJ7nUbFGD9h7TKu2mhvbRno5d
	BQqZ+KbQVL9g1jONSGoxpn8nOCT5+NfYi2N07S/YIdD10ntKOn4hZyg+X1f1z5xK5cFVrKK8Gbq6C
	H1snXDJg1wfbMiiRGJ0YYxkZodbkbdCyiDJHP2SApuCnqsoMGIzfuZtB5nPTQG/PrR5QGDeZTqzQk
	IzW0uytlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsOH-0002vd-Iw; Mon, 28 Sep 2020 12:36:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNT-0002Ts-0c
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=EGoxkdUzlJHHy4NtIAPhZbZRaPp3oo+UUdyY1WbZREw=; b=cpTLR7WmqygCkxmIM/B43Gei/0
 x5v6cdTUOYavbtOGNalTeHzV5HnQX9iMFDHzYwwIYk1QTq3yZtXTogN0OB+4crG6NdWd7XtGL0tw8
 S8cJeBQZ0wn2nGkIN10SpAfD/XnDx5lzEd8+F9te2mOglNo0fqofwQ5cQlmiztBWpYyJjKtb7QeuC
 XUNvOksY6uq0FJk8WPGuEPO02bho3/uWFYn96jN+eGXmGC2lBu6lq+EADPxpr2rKjDNMgsC20+IeZ
 qQs5l7jvtuARKiiCQ9O7QD0eB+hA0RmzH0tgPbkAkmm+H0nrg1HqhnX273S8an6+89GlL3wlIQb5L
 HTRt97fQ==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNR-0004n6-8N; Mon, 28 Sep 2020 12:35:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 20/20] nvme: remove nvme_identify_ns_list
Date: Mon, 28 Sep 2020 14:35:02 +0200
Message-Id: <20200928123502.435373-21-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Just fold it into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0b88a377a47f6e..385b103178737e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1326,17 +1326,6 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 	return status;
 }
 
-static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
-{
-	struct nvme_command c = { };
-
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST;
-	c.identify.nsid = cpu_to_le32(nsid);
-	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list,
-				    NVME_IDENTIFY_DATA_SIZE);
-}
-
 static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 			struct nvme_ns_ids *ids, struct nvme_id_ns **id)
 {
@@ -4042,7 +4031,14 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 		return -ENOMEM;
 
 	for (;;) {
-		ret = nvme_identify_ns_list(ctrl, prev, ns_list);
+		struct nvme_command cmd = {
+			.identify.opcode	= nvme_admin_identify,
+			.identify.cns		= NVME_ID_CNS_NS_ACTIVE_LIST,
+			.identify.nsid		= cpu_to_le32(prev),
+		};
+
+		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
+					    NVME_IDENTIFY_DATA_SIZE);
 		if (ret)
 			goto free;
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
