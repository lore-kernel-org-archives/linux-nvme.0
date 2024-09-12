Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80FAEEB560
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQuXIMz64/MWV4cW2CSVZo96iMiWv3mNTd6vZf420MA=; b=gUCOef1ld9sN+Ze3rDOBqHcsuI
	zIeZ+8Q7pGAHPipron4TFlpqC44owxjpn/qzL7fRVWrjNiWebnMQtCCEr67vNP8anwXA3HsWVMctI
	KiT7feVWXLqzF6F6QYCUZ0+re2p5ZKCJNJxNFmrvDJR5410LmqG81kM7JNUtcnM6wCXFYzUxuVloD
	PStDzJURC4HFwt5pvppPz4Z2/rWRlX/tNfzvs3CQuox698NEY9OmM3pmvkjYR0QECtofvk26d8z9J
	nGv0wGa0jT/LnQbHHf2lDxHqn7QgUeWRlW41GbDbLUx5oxZPwDu9sYkkxZWfxk0INgbUbMFTnToV7
	rWHE5JeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof1P-0000000CKuh-19Cb;
	Thu, 12 Sep 2024 08:17:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof0f-0000000CKlO-2WAG
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 08:17:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726129020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQuXIMz64/MWV4cW2CSVZo96iMiWv3mNTd6vZf420MA=;
	b=ghZn5HviJUfNcnyHuXhaUuCQsJQKJPn0uVlf2Gcru9TWWhSF+8T98/hClmvGaCNmOMq3Yy
	qQ6VFj/4roMfX32BPX2xWyWK47pUAStBrJujRD7exeEug0Pv/nf/QrXMxqfyceNsU1e+9U
	9j39oomHJn8L9AzS9mNwbRX8veeZ2no=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-PmFLI99uMpampTTvxUz1Ig-1; Thu,
 12 Sep 2024 04:15:24 -0400
X-MC-Unique: PmFLI99uMpampTTvxUz1Ig-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 752081955BF7;
	Thu, 12 Sep 2024 08:15:22 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4570519560AA;
	Thu, 12 Sep 2024 08:15:20 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH RFC V2 3/7] nvme-core: reserve tags for cancel commands
Date: Thu, 12 Sep 2024 10:15:06 +0200
Message-ID: <20240912081510.171857-4-mlombard@redhat.com>
In-Reply-To: <20240912081510.171857-1-mlombard@redhat.com>
References: <20240912081510.171857-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_011701_733280_357B9C43 
X-CRM114-Status: GOOD (  11.28  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the controller supports cancel commands, reserve
NVME_RSV_CANCEL_MAX tags for them.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d1e87d74c48b..60b56404d3fb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4569,9 +4569,14 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	 */
 	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
 		set->reserved_tags = NVME_AQ_DEPTH;
-	else if (ctrl->ops->flags & NVME_F_FABRICS)
+	else if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/* Reserved for fabric connect */
 		set->reserved_tags = 1;
+		if (nvme_io_command_supported(ctrl, nvme_cmd_cancel)) {
+			/* Reserved for cancel commands */
+			set->reserved_tags += NVME_RSV_CANCEL_MAX;
+		}
+	}
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
-- 
2.43.5


