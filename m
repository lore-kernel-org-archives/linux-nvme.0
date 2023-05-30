Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87BAC77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 09:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UbmmNJpTUBx/mhD31ayJAdVovQnAKFyVZmv2TY8GeLI=; b=LwplkuNvT2qMNHR5Npv+HTLNez
	oXKag7LCOPuNCaTOC8vTgt8zW0dvgo86Ap8R5Ka7LebuYHV9AQ13VOg/MZ0Bkhi9s8Yws/dUKPn60
	5OaW61QEZdls1Nt2MzQKMpjTLkIr4JY6leVg+nd2eGOWEOQfu6c4tAYwEo0+dogdJPXMDbZBmdzMl
	8evKNAuAP2HiuX0M8IP25GdF34UIzidXbJ7XBV18JxGNyd1LohFslEITS+gSE7hN+YJtNxj1dSnqA
	EQLb1L2n5KMm2VSm9N9SaYi91Gs+sOdwPS3sV39EZNl3C9Syb/g05vr3uYGqnjEhNGxI1Av4+jyRK
	xXTrXj8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3vtg-00DE25-2d;
	Tue, 30 May 2023 09:44:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3vte-00DE16-25
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 09:44:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685439845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbmmNJpTUBx/mhD31ayJAdVovQnAKFyVZmv2TY8GeLI=;
	b=W1WHGg4o/ANQ+0W5O56SksaC1w8W49e2j3XvVe2N6Elf5m0Bm1AH9LDyAtI3n1lGHlJZV0
	ETk3rx2eQ5y2vU6yhUmXTInZgCeWGih3OOrWCTRmnXTGTbmP2DTi+OEDZ1FDKp7kEcLq/1
	9VmbdS8yr+FurZ8/twwY1cyL/fYsgOA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-kLRZiKxqN9iX-twHfKbEdw-1; Tue, 30 May 2023 05:43:59 -0400
X-MC-Unique: kLRZiKxqN9iX-twHfKbEdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4473C185A7A8;
	Tue, 30 May 2023 09:43:59 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4CF5C2166B2B;
	Tue, 30 May 2023 09:43:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] nvme: rdma/tcp: call nvme_delete_dead_ctrl for handling reconnect failure
Date: Tue, 30 May 2023 17:43:22 +0800
Message-Id: <20230530094322.258090-3-ming.lei@redhat.com>
In-Reply-To: <20230530094322.258090-1-ming.lei@redhat.com>
References: <20230530094322.258090-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_024406_773113_44313E79 
X-CRM114-Status: GOOD (  16.23  )
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

Reconnect failure has been reached after trying enough times, and controller
is actually incapable of handling IO, so it should be marked as dead, so call
nvme_delete_dead_ctrl() to handle the failure for avoiding the following IO
deadlock:

1) writeback IO waits in __bio_queue_enter() because queue is frozen
during error recovery

2) reconnect failure handler removes controller, and del_gendisk() waits
for above writeback IO in fsync/invalidate bdev

Fix the issue by calling nvme_delete_dead_ctrl() which call
nvme_mark_namespaces_dead() before deleting disk, so the above writeback
IO will be failed, and IO deadlock is avoided.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 drivers/nvme/host/tcp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..cdf5855c3009 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1028,7 +1028,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
-		nvme_delete_ctrl(&ctrl->ctrl);
+		nvme_delete_dead_ctrl(&ctrl->ctrl);
 	}
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..2c119bff7010 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2047,7 +2047,7 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->device, "Removing controller...\n");
-		nvme_delete_ctrl(ctrl);
+		nvme_delete_dead_ctrl(ctrl);
 	}
 }
 
-- 
2.40.1


