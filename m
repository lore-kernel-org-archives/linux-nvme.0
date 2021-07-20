Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EE8C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 12:45:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A20860FF2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 12:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A20860FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cyUL27+isbk15oD+6yNlbLp2XVgscY2//Vwh5WxdOj4=; b=lMcAAPKX8EV1XC
	cjYx+ldXGOgRFVuuGB80DPfURFNjCU7Mot1eCujpKXkx7MpezPQdLvLgQE+Vl4Uv6p7m/4zRTv7sV
	d2tk4/C2XSbKotKpZilpHoRSdu0Cwsj5TbkHhhBGZsBqykYjed+eOvxJjLuL/JieflNU7eo6Xur9T
	ewaejtpSjYby/TeoOQiXEw/7Vg3KyUQ3ZDStcOhhhBt56QK5Jf8JqF9ta3ekLvzlGRyicYYZFRaPC
	cvvSvL2oGo97MFxnphs9YjkORPHPyXrsRkF3LIV3+oN6+S828OhZ4OJaIC/vzH7BAz51MkxjCb2B+
	p1075Ls1pQPYsLm2WTtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5p7O-00Coae-6i; Tue, 20 Jul 2021 12:45:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5p6Q-00CoHM-3L
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 12:44:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DB7091FE1C;
 Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626785038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9h9VUW/VW1HZ0CZDwi95Zg4JDfQW7vgW/62R93T77qI=;
 b=MvWVNCyXRiFhCGA8Ic0JIEEiSzgzmA3VplZKUCX/5niyOS4zTrOl5VsY/3NgoX3jFnostQ
 4zy2UlA3YvnB35nFDLMB5HGXb5jt1HXy8o7gxv7Mer2uvjzYhs9fVC8R3hgx6P3uImIZdD
 zCFyRKakSyyS7wPi1vIvduf9bnQCRq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626785038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9h9VUW/VW1HZ0CZDwi95Zg4JDfQW7vgW/62R93T77qI=;
 b=eC535NMQBb/KsViAk2HbYOm5Vm2YiY8Utr2LtjzG9URW7weFsmi+BKr7TQLPN6FvpAGuSh
 KG3VIoX9TL1QQDDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0DF5CA3B8E;
 Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id EE91F5171928; Tue, 20 Jul 2021 14:43:57 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 James Smart <jsmart2021@gmail.com>
Subject: [PATCH v3 1/6] nvme-fc: Update hardware queues before using them
Date: Tue, 20 Jul 2021 14:43:48 +0200
Message-Id: <20210720124353.127959-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210720124353.127959-1-dwagner@suse.de>
References: <20210720124353.127959-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_054402_375646_F6C38E72 
X-CRM114-Status: GOOD (  12.06  )
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

In case the number of hardware queues changes, do the update the
tagset and ctx to hctx first before using the mapping to recreate and
connnect the IO queues.

Reviewed-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 053b0f94859f..8d742a6c82c1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2952,14 +2952,6 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ctrl->ctrl.queue_count == 1)
 		return 0;
 
-	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
-	if (ret)
-		goto out_free_io_queues;
-
-	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
-	if (ret)
-		goto out_delete_hw_queues;
-
 	if (prior_ioq_cnt != nr_io_queues) {
 		dev_info(ctrl->ctrl.device,
 			"reconnect: revising io queue count from %d to %d\n",
@@ -2969,6 +2961,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		nvme_unfreeze(&ctrl->ctrl);
 	}
 
+	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	if (ret)
+		goto out_free_io_queues;
+
+	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	if (ret)
+		goto out_delete_hw_queues;
+
 	return 0;
 
 out_delete_hw_queues:
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
