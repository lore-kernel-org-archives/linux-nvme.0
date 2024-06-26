Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28F7C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 18:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FjSOYrgfoFIo8jSjRIhDD/fPJg/leJw7/q8d1Axdb/w=; b=c052peTVI8zSZmlwckoIs1glWf
	g8JXRJVKNKlJjq69d1QnYHQMJ4uDSiTmjtxMkhNGmwWvtF2LzOlKD9xBy4OEgXSn4kRjlzS0Kby/a
	RGBX4FeQ2mW7NgvPz62Nf6TucpwTOTr6pWOfv9UlDPR7oSlNiPU5ClaZqRyFhzHqrFYCc/URLafJb
	oEjJ8eWV/pGbGSIL42exsK9NgvSNeL1IrmfZOs4BKBMIBZg5sfVR60m5oL1WrxuV90pP+TAGsuNWd
	p3B1ig123aeiqmfxWjChr+bcl28WnOcEE3t6EiDmt7omKa4G+pU+e4fYmtf/hht1Hu84OdVCMcCTz
	33t7+h2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMXXQ-00000007wGT-3TyL;
	Wed, 26 Jun 2024 18:38:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMXXN-00000007wFc-44Z6
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 18:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719427108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjSOYrgfoFIo8jSjRIhDD/fPJg/leJw7/q8d1Axdb/w=;
	b=YFTOqVyvUTYI9G/pihkpUhUvUORH5or4+KFf4lViifKeSO+L4Rmt/SowAYb6YYOPQB3Zlf
	9Vq2Op2r1FtnZ7Of6EhchdJ+nR1MWvL9CFIFG5AtNJAQRrQ/6Bfo41wJ8HVvMNmIDlavHf
	wsj8B6l253Uzbu7rsn73cH61Ya8uCy8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-v_p0UT84NxaZGTx5BmgOhQ-1; Wed,
 26 Jun 2024 14:38:25 -0400
X-MC-Unique: v_p0UT84NxaZGTx5BmgOhQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FC3F19560AD;
	Wed, 26 Jun 2024 18:38:24 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.17.122])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05A01300021A;
	Wed, 26 Jun 2024 18:38:22 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: sagi@grimberg.me
Cc: emilne@redhat.com,
	hare@kernel.org,
	jmeneghi@redhat.com,
	kbusch@meta.com,
	linux-nvme@lists.infradead.org,
	mlombard@redhat.com
Subject: [PATCH v2 7/7] nvme: add reserved ioq tags for cancel
Date: Wed, 26 Jun 2024 14:38:19 -0400
Message-ID: <20240626183819.23960-1-jmeneghi@redhat.com>
In-Reply-To: <50a62d8e-b45e-4ae0-81dc-f12c46a5a65b@grimberg.me>
References: <50a62d8e-b45e-4ae0-81dc-f12c46a5a65b@grimberg.me>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_113834_338411_DAEA976D 
X-CRM114-Status: GOOD (  11.16  )
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

If the nvme Cancel command is supported, we need to reserve 2 tags for
each IO queue. Note that one addition tag is reserved to account for
the case where this is a fabrics controller.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 691dd6ee6dc3..76554fb373a3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4570,6 +4570,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		unsigned int cmd_size)
 {
 	int ret;
+	u32 effects = le32_to_cpu(ctrl->effects->iocs[nvme_cmd_cancel]);
 
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
@@ -4580,9 +4581,13 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	 */
 	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
 		set->reserved_tags = NVME_AQ_DEPTH;
+	else if  (effects & NVME_CMD_EFFECTS_CSUPP)
+		/* Reserve 2 X io_queue count for NVMe Cancel */
+		set->reserved_tags = (2 * ctrl->queue_count);
 	else if (ctrl->ops->flags & NVME_F_FABRICS)
 		/* Reserved for fabric connect */
 		set->reserved_tags = 1;
+
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
-- 
2.45.2


