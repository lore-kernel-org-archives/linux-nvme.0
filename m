Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2CBC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 08:18:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C688460E96
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 08:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C688460E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6EPpWJMM1oEudtfCAFWs0O0JIxg1Z+CB9nptxSUO/I=; b=dxIqfaA+IVQCYMy6KvOs7Ojn4r
	GTHip3DP4ojvXkotIfcQCqzuvSydIXkBlHt7Xh3xkqD8DFamkYilN/fJHUirfyq3bnLhXfT/PVPYG
	OYNKy+5aecpWsPKXKgRgXzgNYbPN7+JOy0gjogv68A7JYmZQVy7rJBgjGObTkjfJZADON2vkOdpP3
	awjcKlKOBNFV/js2gH/1kfjQVsoNyKcDb+C63mFDDkCZ4xusR1kGJegIX4DE1KGU+9a+phB4a8S2i
	wEg9GnG9Rp1heqkc76fhN7yi2S6ZBOSf+O3GS9aKsYhCzFv/LdPKV7tKvbO1kiF/3P8CCSQbYxbO+
	fnAvAYBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mavvt-00291b-Nb; Thu, 14 Oct 2021 08:17:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mavvi-0028ye-N6
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 08:17:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634199453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6EPpWJMM1oEudtfCAFWs0O0JIxg1Z+CB9nptxSUO/I=;
 b=GN5Kisa1f3/raNPEAyI2VYSEF5SeoV7FWZDQj48yYkEiuh7VE6juRuaEMImcM2QcE95FJx
 pOEcBk1xaxAoCyuHu+LC2S2WW3flR4W6JWJ39UcJE1GybYB/ILTq7vfdPsJv+ho74z4mYz
 b7IksfdQ5SeuZkZA+q40Q0VuaWL7Ims=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-I3dEUDg2OWWkGqOAdG4_jw-1; Thu, 14 Oct 2021 04:17:29 -0400
X-MC-Unique: I3dEUDg2OWWkGqOAdG4_jw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27BFF10168C4;
 Thu, 14 Oct 2021 08:17:28 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63BAD100164A;
 Thu, 14 Oct 2021 08:17:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/6] nvme: add APIs for stopping/starting admin queue
Date: Thu, 14 Oct 2021 16:17:05 +0800
Message-Id: <20211014081710.1871747-2-ming.lei@redhat.com>
In-Reply-To: <20211014081710.1871747-1-ming.lei@redhat.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_011734_846012_0A30340B 
X-CRM114-Status: GOOD (  12.10  )
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

Add two APIs for stopping and starting admin queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7fa75433c036..c675eef70a63 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4563,6 +4563,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
+{
+	blk_mq_quiesce_queue(ctrl->admin_q);
+}
+EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
+
+void nvme_start_admin_queue(struct nvme_ctrl *ctrl)
+{
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+}
+EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
+
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9871c0c9374c..47877a5f1515 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -659,6 +659,8 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
+void nvme_stop_admin_queue(struct nvme_ctrl *ctrl);
+void nvme_start_admin_queue(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
-- 
2.31.1


