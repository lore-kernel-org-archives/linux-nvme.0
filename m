Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E082C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 15:05:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C439205CB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 15:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ftjCguxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C439205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NxuXMUE0ANNe0oVCCXPYnORM4qE1y4SIfeSVZ0U66d4=; b=ftjCguxFGGQYjY
	iiD6FqqsOwJRTnYtdiylkaKRK7JqdkNyOJYakVaNefHlMMHHt4HnsFH7+8qN/Zrpl+fIJuYaFonAj
	x76KoSETsvPTont6E/2oIhNW8P2bYL4SkMg3b8Ve+EEjM6dlKtrfr0k4cAQuDr1eng+aia0XqA9bq
	Q1sixInFCtd7pk+zGInpY0m/6T65nZ3HX0bkE9LXkfSEDhOLaKKec8Dp6eJDLDEpgeF1e4pvTM5s8
	3rdlC677NqKQ+roVkf0UWQ5qlljO277Zkzbx7OriX3t07O9C1r57Dk6iXP3fbritWYrNNXCBRzyll
	3WNc+62BMnk4Ec5wCc5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZFQX-0003Kf-OH; Thu, 14 May 2020 15:05:37 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jZFQV-0003KB-JG; Thu, 14 May 2020 15:05:35 +0000
Date: Thu, 14 May 2020 08:05:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH] nvmet: nvmet_async_events_process always free async
 event to avoid memleak
Message-ID: <20200514150535.GA10740@infradead.org>
References: <1589382492-9811-1-git-send-email-dmilburn@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1589382492-9811-1-git-send-email-dmilburn@redhat.com>
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
Cc: hch@infradead.org, dwagner@suse.de, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I don't think we should take the aen off the list if there is no
command slot available.  So probably something like this instead:

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b685f99d56a1f..0df9300d717d6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -134,15 +134,10 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 	struct nvmet_async_event *aen;
 	struct nvmet_req *req;
 
-	while (1) {
-		mutex_lock(&ctrl->lock);
-		aen = list_first_entry_or_null(&ctrl->async_events,
+	mutex_lock(&ctrl->lock);
+	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
+		aen = list_first_entry(&ctrl->async_events,
 				struct nvmet_async_event, entry);
-		if (!aen || !ctrl->nr_async_event_cmds) {
-			mutex_unlock(&ctrl->lock);
-			break;
-		}
-
 		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
 		if (status == 0)
 			nvmet_set_result(req, nvmet_async_event_result(aen));
@@ -152,7 +147,9 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 
 		mutex_unlock(&ctrl->lock);
 		nvmet_req_complete(req, status);
+		mutex_lock(&ctrl->lock);
 	}
+	mutex_unlock(&ctrl->lock);
 }
 
 static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
