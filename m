Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACFDEB64DB
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 01:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ikczhd6nnU0AFQRVGRfBcA4iWBBki9GNxTX/jhJO73E=; b=M68+rxqMO49qhUBUiYkglvh19n
	Tac7qwXRGah6+zDhuh3oiRgyvDR5mxLJYRvxbqIOoAXqiZlqiuypcESklbCyOCa0BYuIHVlsLpKTw
	ymTuQb38JUdrlFNkFFqat9ZRLotlTRBtUHIDGJ3kGewXnuO4QiavWBWfm1HOXZOIhIx+9NB5lbDqt
	u8e3aPSqYLns9PZK5dfN8PKYrfn9Ol2TLaLESKstfzJGbOYio1xjQonXe3KTcU/WTQk3Nfdjim+rA
	N0kkt9KQHpfjGS2CmgoiOXGePyBdW5r1ivRom1O1no8VhSNvA7aPEphuInl9VnZD74YMb9caSGJ08
	n9Q9pwyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBQGQ-009tFb-3B;
	Tue, 20 Jun 2023 01:34:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBQGO-009tEO-2F
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 01:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687224871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikczhd6nnU0AFQRVGRfBcA4iWBBki9GNxTX/jhJO73E=;
	b=PodDKwRejKuOS243/s4EX4vMZPhKdSo83LwLcUI/H+76eHeMNULVx4gU6dxGSHDsIwUECN
	WSSf8odmNM/fMgFi1x2YwJUubadsChFxhFbSqFZITYz6wYYiHIJRoQgA6aYS6mwre2IvWY
	9j3WsOu5PZro+bWbnhwatt8hK99ztdU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-B72X3qVrOi-g8Skv5OvAiQ-1; Mon, 19 Jun 2023 21:34:30 -0400
X-MC-Unique: B72X3qVrOi-g8Skv5OvAiQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E56CE1C08DA3;
	Tue, 20 Jun 2023 01:34:29 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 219DB492C1B;
	Tue, 20 Jun 2023 01:34:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/4] nvme: unfreeze queues before removing namespaces
Date: Tue, 20 Jun 2023 09:33:48 +0800
Message-Id: <20230620013349.906601-4-ming.lei@redhat.com>
In-Reply-To: <20230620013349.906601-1-ming.lei@redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_183432_813459_62DDBF53 
X-CRM114-Status: GOOD (  13.72  )
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

If removal is from breaking error recovery, queues may be frozen, and
there may be pending IOs in bio_queue_enter(), and the following
del_gendisk() may wait for these IOs, especially from writeback.

Similar IO hang exists in flushing scan work too if there are pending
IO in scan work context.

Fix the kind of issue by unfreezing queues before removing namespace,
so that all pending IOs can be handled.

Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6b3f12368196..7d8ff58660ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4002,6 +4002,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/* unfreeze queues which may be frozen from error recovery */
+	nvme_unfreeze_force(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
-- 
2.40.1


