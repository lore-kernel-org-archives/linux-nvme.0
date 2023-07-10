Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B67EB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qKNyu66Mfv0R79E2A6KR/GksH6uk56ebjLZq2cQY3fk=; b=b3+NxWmPpuXa84IvnMrs8XqY3u
	5JKF2GCVDJegT83Eluf5Hn1xbR/XqztyG0UoMPSqHcKDw2mgi68/dOtNov7zkX0nGOXH6w0saHjqZ
	VJJ1js/8ViCltBdqKfibbvBq5lt0/JOkkN5DPZqq9fQ0msDrgGZBYV5VlfzCU8i8pqhAAY5FUKBgT
	YZFYwsbsp6jDoMV4cN/FMABzBLm34a1iWhX5dKbVOwLBj7AB0eJnISAW4BLCS1NQCU0FefJIny7lA
	Vh3ti0UVmGxiRLMcXfuYxB8dokcgD71X9e0lkHhlXFfUX/8zKCZlpkX0ExxJv2AlwC14DzkOMpYvF
	wsabvuaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIswF-00C0si-1s;
	Mon, 10 Jul 2023 15:36:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIswD-00C0rH-0t
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:36:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689003392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKNyu66Mfv0R79E2A6KR/GksH6uk56ebjLZq2cQY3fk=;
	b=dyFosDK87m2u5JrSv0CWWOP/hBqSJ8qfg1nS5FzUQcNQXQGIsnGJQhghZHlyWqzZpR5k96
	gV9AkPd95FjkE202fdK4x2jmfIHp3wFgpwFq8fjUDsduc8vEdl9Qok/8sAhiXeU0EHOHe7
	L6iB36UN46Uwn7kS+ZKfK2H+nklmQY4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-PDKxZqOQMKadURRSn3ZH6g-1; Mon, 10 Jul 2023 11:36:29 -0400
X-MC-Unique: PDKxZqOQMKadURRSn3ZH6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96D4B8DBB45;
	Mon, 10 Jul 2023 15:36:28 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A3643F66A4;
	Mon, 10 Jul 2023 15:36:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/6] nvme: rdma: unquiesce queues until ctrl state is changed
Date: Mon, 10 Jul 2023 23:35:53 +0800
Message-Id: <20230710153555.1766438-5-ming.lei@redhat.com>
In-Reply-To: <20230710153555.1766438-1-ming.lei@redhat.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_083633_413842_DF945580 
X-CRM114-Status: GOOD (  14.34  )
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

Unquiesce queues until controller state is changed successfully.

Prepare for moving start freeze into reconnect work for preventing new
request from entering queue in LIVE state.

Before removing namespace, unquiescing queues is done unconditionally, so
it is safe to do this way in case of state change failure.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d433b2ec07a6..cdfa93d67b80 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1117,9 +1117,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
-	nvme_unquiesce_io_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 	nvme_auth_stop(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
@@ -1129,6 +1127,8 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
+	nvme_unquiesce_io_queues(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
-- 
2.40.1


