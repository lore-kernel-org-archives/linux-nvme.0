Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6007C5517A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:55:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E5C221E9
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lGwNw/Ne";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zeHVmAih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E5C221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ShX6Rnu9R97HdcMwO4U7JJ/h6GCm4oe5mzeyAOTqxCs=; b=lGwNw/NeL51RWkByty7fyXgpj
	o9LbKFjLTYPyr6DbemlVUdDxYiuXqMoXXoPiPRFg6hUD0h9jIeJ7DCM/i5B55gs2JWZvx8u5A6zey
	easQsSOJ7NhiS0+zsxAi46hoxo2TK5KfwZNaT4XJiPqzaeHHZ4J33MF3ZDUFdx75u8a5V0eVL8Z8c
	6PqWm/2chKZJ2uabK5LaevOSkQGYhX5sNJS24aDusF8PE7NwMFooOCGRImiYIe0MUvUz+jiVMuFE3
	xBOoJgMdYdAa+pyMmPTUKJCqP91e0M556WlZNHrJWw0dvI7/TTnEOwYiGz3I5hX/0kyy/nsY4v0ry
	qYXTdJLcw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcKkb-0002Tk-Hk; Tue, 10 Nov 2020 03:55:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcKkV-0002Ps-Pr
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 03:55:17 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 28FDB20E65;
 Tue, 10 Nov 2020 03:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604980515;
 bh=6v7vjvx3pumIafrE0S/YCmKzzDJSNkFrZ2yWisEe3jo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zeHVmAihcuAFS2cFTk6hMBaiaVJhoq+MJ6Tr/0dHfifJ2CC3q9z2MQZ+QsRt4sB8t
 Z/d01DgLUNJjC4QP1Qp/InWTZAAWdtBKyWXyO6YscZSlfoAYCZv8Ma8L8FVF/+mze6
 Yl+tQVj3eork75V2onxaOf+beVWXQrGtpWIAuaAk=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 24/42] nvme: introduce nvme_sync_io_queues
Date: Mon,  9 Nov 2020 22:54:22 -0500
Message-Id: <20201110035440.424258-24-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201110035440.424258-1-sashal@kernel.org>
References: <20201110035440.424258-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_225515_984977_B0804BAE 
X-CRM114-Status: GOOD (  13.69  )
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
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

[ Upstream commit 04800fbff4764ab7b32c49d19628605a5d4cb85c ]

Introduce sync io queues for some scenarios which just only need sync
io queues not sync all queues.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 8 ++++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce69aaea581a5..7a964271959d8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4226,8 +4226,7 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
-
-void nvme_sync_queues(struct nvme_ctrl *ctrl)
+void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
@@ -4235,7 +4234,12 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_sync_queue(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
 
+void nvme_sync_queues(struct nvme_ctrl *ctrl)
+{
+	nvme_sync_io_queues(ctrl);
 	if (ctrl->admin_q)
 		blk_sync_queue(ctrl->admin_q);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d7132d8cb7c5d..e392d6cd92ced 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -494,6 +494,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
+void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
