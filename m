Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFF9EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9O4Mk9Es/M/LGlPRs/86sp/XpXPEGvlI06VZFJA6vNE=; b=TFx6vNQYZAhWtlzL0wQwz2kzMn
	Kfb5M/zY2grAoiQidFcBxNGtAuEu47t8cIsz5QmXk2CCLhBMmRCr+9gHxwjIX7YmU9TYBFxh4xc0P
	b4eeDx8HGskOGWFdhEFzfUR8KEYzpu6vu8JkHdLMOsIZ/RPwpoxUCwMRqjyI8hKwXr5tuLmn+NDLZ
	rvaMxuqV3KJKxKFdZ++WQuo5bocqMx3uZa6WccdzYlrZf762BfzDMHz7mAe5gjg5Ap0aMkrkodXRQ
	MwKF2Ud9oAQYMB4e8ZyBn4uzsYSLqnVMQMFWBhMckYhrhgjZxMyQC4V4H5CKUvOqOeMGGIqRiVA1d
	RckVSmFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIswJ-00C0vM-1o;
	Mon, 10 Jul 2023 15:36:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIswG-00C0t5-22
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689003395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9O4Mk9Es/M/LGlPRs/86sp/XpXPEGvlI06VZFJA6vNE=;
	b=Q2ZpSrurSJcfaFSZsRiqYcpIYpeub61Dmrw8ZmFyWajNNbdTCtD0kawN3RWYjAZgBfYzur
	CBXohNGt0/vrmp2FgonwXX2CrP5Ot1SVnEcGVeg72UOoeWMjrPVPYS2qHFCY+bpoqQ3TVv
	8S0/huzPg2nAqbfIA+pFBEgoFFZ0mm8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-ooPt3QrdMIqLw3Rvk0I7Pg-1; Mon, 10 Jul 2023 11:36:32 -0400
X-MC-Unique: ooPt3QrdMIqLw3Rvk0I7Pg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 235343C13503;
	Mon, 10 Jul 2023 15:36:32 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 463AE492C13;
	Mon, 10 Jul 2023 15:36:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/6] nvem: tcp: move start freeze into nvme_tcp_configure_io_queues
Date: Mon, 10 Jul 2023 23:35:54 +0800
Message-Id: <20230710153555.1766438-6-ming.lei@redhat.com>
In-Reply-To: <20230710153555.1766438-1-ming.lei@redhat.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_083636_746052_05FA7890 
X-CRM114-Status: GOOD (  13.80  )
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

Move start_freeze into nvme_tcp_configure_io_queues(), and there is
at least two benefits:

1) freeze and unfreeze are done in pair

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e68bf21af348..798bfc29bc88 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1868,6 +1868,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1876,6 +1877,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -1976,7 +1978,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_quiesce_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.40.1


