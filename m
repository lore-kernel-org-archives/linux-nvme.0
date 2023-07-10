Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA7EEB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zg7w3fQ/DlJ6TBs+1LVVo/JtmkyVshxOmUEKEXvlUS0=; b=Bx+rd0Gj0/+590sZ/RZjG2dGV7
	bjv6XhNdLus+hvSvUQbQdaxQpUVh2ji+cwUdp/kuO3Vm5vPBL3LKGgppCH8RY7/A5Gh1f+Grp7au+
	7j7aPV8Tnu6fSYuhUOGrU43baT4HP8t8QoHitL7F22FEcqAAMbdCmCoIj4QjY8HIGM/FDQDsxQqg7
	WLGhDpMNjAus8+qPRJhmXo+BTsfzEUcKAvfW+Afz0ILcktMfL4XKqdLu7GU/P3meBj4B55kHPd4fw
	tllvz3hwBb9oOk7n3u6ACQ0df1nX1bzIOqNd3YtQQGjCpGV72+hqbQU7ZNRrgeLZHSH/Z91Dyuh9z
	EpNl/rjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIsw2-00C0lu-03;
	Mon, 10 Jul 2023 15:36:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIsvy-00C0ko-1w
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:36:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689003377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zg7w3fQ/DlJ6TBs+1LVVo/JtmkyVshxOmUEKEXvlUS0=;
	b=b7bUNjf30AxAt8gJAVDhvhHeIGWvD7bAsK3GIs0plCS/f1HvQwZ3HoDHTdiH9dewtqoLir
	WxUNlxrOSWfeQjyUjADlq+Y/zXDkXXBtE7dzgg1lqhsvDcy0hgMAmRghLamYsZTA2+fE7c
	bW7RUDtDP/l2U9MSZMTTgHkFql7AJuc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-DOtuRCwkOpiGeYQ3wmU-iA-1; Mon, 10 Jul 2023 11:36:16 -0400
X-MC-Unique: DOtuRCwkOpiGeYQ3wmU-iA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5EF21C0782D;
	Mon, 10 Jul 2023 15:36:15 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E03BC200A7CA;
	Mon, 10 Jul 2023 15:36:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/6] nvme: tcp: remove 'shutdown' parameters from two teardown helpers
Date: Mon, 10 Jul 2023 23:35:51 +0800
Message-Id: <20230710153555.1766438-3-ming.lei@redhat.com>
In-Reply-To: <20230710153555.1766438-1-ming.lei@redhat.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_083618_713077_D200C28E 
X-CRM114-Status: GOOD (  13.10  )
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

'shutdown' is just for unquiescing queues, and we can do that outside
the caller, and turns out more readable given unquiesce isn't needed
in error recovery code path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e7dd6f91832..e414cfb3433f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1962,20 +1962,16 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	return error;
 }
 
-static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
-		bool remove)
+static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl)
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_admin_queue(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
 
-static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
-		bool remove)
+static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
 {
 	if (ctrl->queue_count <= 1)
 		return;
@@ -1985,8 +1981,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	nvme_cancel_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_io_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
@@ -2114,10 +2108,10 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
-	nvme_tcp_teardown_io_queues(ctrl, false);
+	nvme_tcp_teardown_io_queues(ctrl);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
+	nvme_tcp_teardown_admin_queue(ctrl);
 	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
 
@@ -2133,10 +2127,14 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	nvme_tcp_teardown_io_queues(ctrl, shutdown);
+	nvme_tcp_teardown_io_queues(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
 	nvme_disable_ctrl(ctrl, shutdown);
-	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+	nvme_tcp_teardown_admin_queue(ctrl);
+	if (shutdown) {
+		nvme_unquiesce_io_queues(ctrl);
+		nvme_unquiesce_admin_queue(ctrl);
+	}
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
-- 
2.40.1


