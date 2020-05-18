Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBCFC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2E820758
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kjePG+N6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9K1/vU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2E820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=twxASZzs35xgf7OoBzwlLgpnYTYtK/65rSAOmV+JGu4=; b=kjePG+N6AYpbtH6Q0qWUrM/ASn
	Gj5CLmUIvbtDLh/jNtyCEwRnytrTGG8289zKGuys9qJF1+EwVKZ1m6ZXARnZDhHYKpKVmCitcR71z
	ZHC1YqWSYJ7RVcpbP8rtwD20F2hfsfi6KruT0MEllWf5aBGeimObQCg6U5QTijv0UXVYIA6c6yo70
	QbbAtfzm6tPlkhFDxZ92Fe/U1BFTDysVDk4vZ+yzdLu33cdaKjryMDlGDuOttQl65yIQtsQdwm8qg
	jso01naj+8P8w/iP6fWFs6S9+QRSmhVnzxcdOjlYwhHMNATz2fO/koqNxxEIAEpPwKlyGomUAgJQg
	W/Oeb9ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jajAn-0001G3-2B; Mon, 18 May 2020 17:03:29 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jajAZ-000100-EB
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 17:03:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589821394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=pCYkf7/YOMBBFNkeMdmRC34UV7elhOUM5FPLgbBLTFY=;
 b=A9K1/vU8DwrcCF2JaNKo9Hh4eFYQ675o7aADSNlvF9yQCvhCwuO/+BvASb4Q9KI7SYIBLA
 qCr/NqEydQVIVzolbIkJ0V9OcZAll5hVT6bw7HUtRw/6lOlgAVGLCb+o+5aIn+hdHbAjbQ
 TUfb4fN77BKSDcA7uAGGjIAGXrbO0N8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-57ZSu3v2MdKa1-d14-EKkA-1; Mon, 18 May 2020 13:03:08 -0400
X-MC-Unique: 57ZSu3v2MdKa1-d14-EKkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C59E818B6423;
 Mon, 18 May 2020 17:03:07 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BFDD60BE1;
 Mon, 18 May 2020 17:03:07 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvmet: check command slot before pulling and freeing aen
Date: Mon, 18 May 2020 12:03:05 -0500
Message-Id: <1589821386-43424-2-git-send-email-dmilburn@redhat.com>
In-Reply-To: <1589821386-43424-1-git-send-email-dmilburn@redhat.com>
References: <1589821386-43424-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_100315_560925_17A2E9F9 
X-CRM114-Status: GOOD (  10.66  )
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
Cc: hch@infradead.org, chaitanya.kulkarni@wdc.com, dwagner@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Free aens while completing requests in nvmet_async_events_process() and
nvmet_async_events_free().

Based-on-a-patch-by: Christoph Hellwig <hch@infradead.org>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/nvme/target/core.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b685f99d56a1..c9d74ebeaa7d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -134,15 +134,10 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 	struct nvmet_async_event *aen;
 	struct nvmet_req *req;
 
-	while (1) {
-		mutex_lock(&ctrl->lock);
-		aen = list_first_entry_or_null(&ctrl->async_events,
-				struct nvmet_async_event, entry);
-		if (!aen || !ctrl->nr_async_event_cmds) {
-			mutex_unlock(&ctrl->lock);
-			break;
-		}
-
+	mutex_lock(&ctrl->lock);
+	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
+		aen = list_first_entry(&ctrl->async_events,
+				       struct nvmet_async_event, entry);
 		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
 		if (status == 0)
 			nvmet_set_result(req, nvmet_async_event_result(aen));
@@ -152,15 +147,23 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 
 		mutex_unlock(&ctrl->lock);
 		nvmet_req_complete(req, status);
+		mutex_lock(&ctrl->lock);
 	}
+	mutex_unlock(&ctrl->lock);
 }
 
 static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
 {
+	struct nvmet_async_event *aen;
 	struct nvmet_req *req;
 
 	mutex_lock(&ctrl->lock);
-	while (ctrl->nr_async_event_cmds) {
+	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
+		aen = list_first_entry(&ctrl->async_events,
+				       struct nvmet_async_event, entry);
+		list_del(&aen->entry);
+		kfree(aen);
+	  
 		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
 		mutex_unlock(&ctrl->lock);
 		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
-- 
2.18.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
