Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C369D79770
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Jan 2026 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UX3qYGjU4jdpSGNp/Xjte1MBPB66mVoz2MOtkG5CUsw=; b=aPNEgfurY5Jr5EWwHHlOidV4z2
	YkymcDP02/nnCH2WH8stm+S7Dsp0GufuwRqBdLoBu4O353NjVJO928ZRDE6MoOGz2npBQL4ox1ZVG
	4IJbZYkjTlGByrQOdj6/QD9+4LTSePBcr1onaPH4IG56WsLFt5zwprRfzb77tksvR8bJiIKtXI6Id
	nYf0vcY9j5qTmufnZn7+N1UJO4qPBZHQZTAcb9hfLxLDSAQLtletTA9O5ti1+hDtIOr7Lu2yZNNSW
	WZFb5UIPSEPNfhw+0n7U6fSRHM9xE+wMDoXQQqSOutwsHZxxyWUMWQHHrk+kYjht5dOFdXEbp0ib3
	xxEvPmRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmCGz-00000002ib5-3ZEH;
	Sat, 31 Jan 2026 14:48:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmCGw-00000002iai-3bFc
	for linux-nvme@lists.infradead.org;
	Sat, 31 Jan 2026 14:48:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769870903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UX3qYGjU4jdpSGNp/Xjte1MBPB66mVoz2MOtkG5CUsw=;
	b=ElqRgLyVmGrBNnYWMY6Di+WEVyJdYEOLbMqzOreW6LuqA+1t7MccAZZy5afrLORt9xbE3F
	C5xSxNZe7uCEKaXKw2UEwj9xQrWGaQqKQy5L8Pw4HqFjfgHGF09D9wPbfGyOu2D/lz9MlC
	2moEil06u9LIeEGMuxnaa8WVaz3Y0+c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-lc4K7k75OP2I0akuCY3_Ug-1; Sat,
 31 Jan 2026 09:48:19 -0500
X-MC-Unique: lc4K7k75OP2I0akuCY3_Ug-1
X-Mimecast-MFC-AGG-ID: lc4K7k75OP2I0akuCY3_Ug_1769870898
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67CBB18003FD;
	Sat, 31 Jan 2026 14:48:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27AE01956056;
	Sat, 31 Jan 2026 14:48:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] nvme: fix admin queue leak on controller reset
Date: Sat, 31 Jan 2026 22:48:08 +0800
Message-ID: <20260131144808.4173338-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ndA2gik5yobs98I7bq5x4PLzglIhjdUa-xs15U6dthE_1769870898
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260131_064827_093952_1506006C 
X-CRM114-Status: GOOD (  11.97  )
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

When nvme_alloc_admin_tag_set() is called during a controller reset,
a previous admin queue may still exist. Release it properly before
allocating a new one to avoid orphaning the old queue.

This fixes a regression introduced by commit 03b3bcd319b3 ("nvme: fix
admin request_queue lifetime").

Cc: Keith Busch <kbusch@kernel.org>
Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime").
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19b67cf5d550..4f1f460a6c11 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4865,6 +4865,15 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (ctrl->admin_q) {
+		blk_put_queue(ctrl->admin_q);
+		ctrl->admin_q = NULL;
+	}
+
 	ctrl->admin_q = blk_mq_alloc_queue(set, &lim, NULL);
 	if (IS_ERR(ctrl->admin_q)) {
 		ret = PTR_ERR(ctrl->admin_q);
-- 
2.47.1


