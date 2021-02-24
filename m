Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAED2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 12:53:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A0464F57
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 12:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A0464F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5oKIuK9cY9eZSjBVyU2UOAvUaJfNbBZhMla4NkevbVk=; b=oj62iQTRzLyMZz9bCyduWX/Wk
	Ho0l27ipTM61cfux2KBYFH7WdSEGOKjy9PUz6M98GIUpdqxKgHq/eW3ZwuRWhqBMkTts7FO5tOiyt
	7lQqdIOWb+Gi5hSr45MsAJXQz2TyVnkQp95jGl4qXj/VFnkHb6QiRqUa6AIrmcdmk3+DpAByhkOKK
	qWMdN/A2B6gbZAVuBZ1GLdiLbV45r7vARbb2AYVQnh3q5t7S5bJ+B8YNWRPYqsn+G84xukm/JVawe
	D9D7kwd7b+RwV+LXyJMzOAs4YyBWMfsTdfde3LwMNPjRY6u3q/I52eyNfna+Y91+3EVEVt3zWO43M
	G50RBO7rA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEtf9-0002yt-Fl; Wed, 24 Feb 2021 12:53:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEtf4-0002wj-Iw
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 12:53:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 154FA64F55;
 Wed, 24 Feb 2021 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614171181;
 bh=K8dwfFm/TdUYzwZc+jo9YtmQHmUkC5qz03JyYqKPZ94=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lT0XhP2xdt/Gg7tIeFSX5iOURqlutHPEEKs3gfLnXxkllvYGa54Kiag3/aGIH+HhS
 MEAgSz13XwZ2gHcRgIRo+5MtwumOYdNZ5Xa6XBvD88JuimE90NFDz/SRJ4DFOyYpo1
 RQLQufqAdWbw6CvCdegx/X0KLoZQvYxJOQgerdx7qLXsDfqejtoWhr9YKOkxo0Uyje
 wZFqJsChW0fQ6L1Gs0lRZjHYZqGX/OPZM0WV/shOMxusMd+3rbHiNuY8agcbkxMWa+
 T0aJ206T7R2B1SFDOu1VvbZMPlq4gERfE2ZbemQsxNtAm7XGF2fgbCpvyKASpWNNAl
 V5rqQCLZwMR4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 37/56] nvme-rdma: add clean action for failed
 reconnection
Date: Wed, 24 Feb 2021 07:51:53 -0500
Message-Id: <20210224125212.482485-37-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125212.482485-1-sashal@kernel.org>
References: <20210224125212.482485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_075303_052010_E02E57B3 
X-CRM114-Status: GOOD (  13.99  )
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
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

[ Upstream commit 958dc1d32c80566f58d18f05ef1f05bd32d172c1 ]

A crash happens when inject failed reconnection.
If reconnect failed after start io queues, the queues will be unquiesced
and new requests continue to be delivered. Reconnection error handling
process directly free queues without cancel suspend requests. The
suppend request will time out, and then crash due to use the queue
after free.

Add sync queues and cancel suppend requests for reconnection error
handling.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 493ed7ba86ed2..fd2b4dbe9d160 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -919,12 +919,16 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-		goto out_stop_queue;
+		goto out_quiesce_queue;
 
 	return 0;
 
+out_quiesce_queue:
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 out_stop_queue:
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
 out_cleanup_queue:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
@@ -1001,8 +1005,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 out_wait_freeze_timed_out:
 	nvme_stop_queues(&ctrl->ctrl);
+	nvme_sync_io_queues(&ctrl->ctrl);
 	nvme_rdma_stop_io_queues(ctrl);
 out_cleanup_connect_q:
+	nvme_cancel_tagset(&ctrl->ctrl);
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
@@ -1144,10 +1150,18 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	return 0;
 
 destroy_io:
-	if (ctrl->ctrl.queue_count > 1)
+	if (ctrl->ctrl.queue_count > 1) {
+		nvme_stop_queues(&ctrl->ctrl);
+		nvme_sync_io_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
+		nvme_cancel_tagset(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, new);
+	}
 destroy_admin:
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, new);
 	return ret;
 }
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
