Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D31C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 02:20:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1258061266
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 02:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1258061266
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zx5b7EyasaE4iBR8eg0o0R2Juu59PwQHw2pizy5wlHs=; b=0q8kIQ8iTlBEFNgnrDCiDUJaok
	aSoJio7jpPjF7SJ7LSboJ0ijPjnyZAuSQBMf5403fLS/P7Nv9Eek2zEMyFC8loGgIwaf6Ft/kaSQn
	1aE88KnymW3lVOUkoCYL35y9R4VGZVULegYA+cF6A/5w+KwtHHDDwmvIU2mIacEVQ2b1eXGh5NuY/
	FNwiXlpLJaodFlwlVI5AQATbswxlwKXRLboBg/M/P8i1gBcZddIh7FnSviyWo8K+OpZYipsoGKj9w
	87MyFsTRdGZQiWGcAFUbGRSOdQtw+gAye1F54afQAnlmKsy4t4C33O1NumI/LV2QGrDRorR83ll1k
	V6ppOz7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mntVY-009EmR-4s; Fri, 19 Nov 2021 02:20:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mntVF-009EgA-2u
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 02:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637288388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx5b7EyasaE4iBR8eg0o0R2Juu59PwQHw2pizy5wlHs=;
 b=hN46Z2uMQh6hABcBnwRx/DcFFksH6MeYCxqn5Rn67ZEoovDNyOvhuw0jUgAXs3GbADdoxK
 bfKUputsOIp2X48DqjzT6XxYdoLDliG+SSiJcEJ44T3hDQZtKTeV6FBVpJMKQIeDk5qdPv
 /REKrNPGQybfd9x+lo4oQm7PXlIWLt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-337-VhXBQGltPMCKpjIZEdpu3w-1; Thu, 18 Nov 2021 21:19:42 -0500
X-MC-Unique: VhXBQGltPMCKpjIZEdpu3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A5FE15723;
 Fri, 19 Nov 2021 02:19:41 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A88BC179B3;
 Fri, 19 Nov 2021 02:19:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Chao Leng <lengchao@huawei.com>
Subject: [PATCH 4/5] nvme: quiesce namespace queue in parallel
Date: Fri, 19 Nov 2021 10:18:48 +0800
Message-Id: <20211119021849.2259254-5-ming.lei@redhat.com>
In-Reply-To: <20211119021849.2259254-1-ming.lei@redhat.com>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_181949_238830_8ED588BF 
X-CRM114-Status: GOOD (  15.21  )
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

Chao Leng reported that in case of lots of namespaces, it may take quite a
while for nvme_stop_queues() to quiesce all namespace queues.

Improve nvme_stop_queues() by running quiesce in parallel, and just wait
once if global quiesce wait is allowed.

Link: https://lore.kernel.org/linux-block/cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com/
Reported-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b5de8f5435a..06741d3ed72b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4517,9 +4517,7 @@ static void nvme_start_ns_queue(struct nvme_ns *ns)
 static void nvme_stop_ns_queue(struct nvme_ns *ns)
 {
 	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
-		blk_mq_quiesce_queue(ns->queue);
-	else
-		blk_mq_wait_quiesce_done(ns->queue);
+		blk_mq_quiesce_queue_nowait(ns->queue);
 }
 
 /*
@@ -4620,6 +4618,11 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_stop_ns_queue(ns);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		blk_mq_wait_quiesce_done(ns->queue);
+		if (blk_mq_global_quiesce_wait(ns->queue))
+			break;
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
-- 
2.31.1


