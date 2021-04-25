Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32025C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:59:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CD0613B2
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CD0613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4G6uXn51y1cFyG8tTwYBW+XwGPvq2JK/bc8VNCttDss=; b=jK19+vIbzhkXr+2qpva8UWfSe
	OUG1a7vpMNm9c5ALmLZ0OSQdwWNOgQX1xj49IfhCYPVUCUIQ75T62hA17SzyUJlL+O3LsOX3AG1j7
	7K+vIfrBZkNDIBe0xu/hoGDVvynkWayC0v1Vkvbl9+rtJLhzCaEni1K+WL5I5t8gR2Oc9tBPo6RE6
	a4eTuLrJfU+86yaIR0aW7VklUI/6G6GdD5yeZEB4aLsbLGK/W7ft5DwK87+gDFoct/jZv5mB5gdZs
	ax7sa/lCDy5Vjf971p4tVUkOn1/aaLZd5hogn21P9WyEdr0t+K0bN0NGLdpO5GJyHD5WZiIstQC7v
	YtoB1r2Ug==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laacD-005K0k-Bc; Sun, 25 Apr 2021 08:59:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laabC-005JsA-6G
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 08:58:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=9XMNgph7pfp6Sn4gR+e9FqJfKyDwk7Q14I9+0tXapEU=; b=MGh7ICs8bjeHeR6MT8xi3LKQVm
 WKiAK9b8PRXCbzcbdJofJGBwwPQJbPVOSKCCoL6oULkzOs4tCfMax/884XDID4vGXEqQXhtcmQG1b
 j1X6zP0GbKhs3tGk6DlKNAE58YsRnnAQlQ1FMbWaBxN0OEp3tRxUSxPz1fbuWpt5nRN3y4KDj8fzw
 ptwcrji0kDkwZtzKxw14wfY22xY8Qo2yTcL5RE6veigth3M4tIcCngAd650b/EjFc1TNbwwg+jZzH
 lV+wSDh/19NdckN/HSIkViAqQUWXpc68pJ1xmMQRiadaTLrx1oRRtQAzqRu3apV6X7TTNf56YubGk
 LxDkadFA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laab9-00FMZR-Kg
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 08:58:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619341118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XMNgph7pfp6Sn4gR+e9FqJfKyDwk7Q14I9+0tXapEU=;
 b=K9lAwFyOrlEB8NbqvlNUWlmahJgdejC333siaDcF+CIhQt7XNVieh35MC8yqOV0vS8jjJ0
 7BDAC5vxY2jt/S60s5DePmLTYt8l4+DeVK6E2Xf9Zbase5ya0qRQoP43c0YjsHpIFCXCsB
 pj5ASpvk92+d85U8KUckYT8CLXkwNd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-s3okdzmXPgazHHveUS35cw-1; Sun, 25 Apr 2021 04:58:36 -0400
X-MC-Unique: s3okdzmXPgazHHveUS35cw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38F581898296;
 Sun, 25 Apr 2021 08:58:35 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B812177CE;
 Sun, 25 Apr 2021 08:58:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/8] block: drivers: complete request locally from
 blk_mq_tagset_busy_iter
Date: Sun, 25 Apr 2021 16:57:51 +0800
Message-Id: <20210425085753.2617424-7-ming.lei@redhat.com>
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_015839_770416_6D023FFA 
X-CRM114-Status: GOOD (  14.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

It can be a bit hard for driver to avoid request UAF between normal
completion and completion via blk_mq_tagset_busy_iter() if async
completion is done in blk_mq_tagset_busy_iter(). Cause request->tag
is only freed after .mq_ops->complete() is called, and rquest->tag
may still be valid after blk_mq_complete_request() is returned from
normal completion path, so this request is still visible in
blk_mq_tagset_busy_iter().

This patch itself can't avoid such request UAF completely. We will
grab a request reference in next patch when walking request via
blk_mq_tagset_busy_iter() for fixing such race, that is why we have
to convert to blk_mq_complete_request_locally() first.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 drivers/block/nbd.c               | 2 +-
 drivers/nvme/host/core.c          | 2 +-
 drivers/scsi/scsi_lib.c           | 6 +++++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 3be0dbc674bd..05f5e36ee608 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3748,7 +3748,7 @@ static bool mtip_no_dev_cleanup(struct request *rq, void *data, bool reserv)
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
 	cmd->status = BLK_STS_IOERR;
-	blk_mq_complete_request(rq);
+	blk_mq_complete_request_locally(rq);
 	return true;
 }
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4ff71b579cfc..3dcf3288efa8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -809,7 +809,7 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
 	cmd->status = BLK_STS_IOERR;
 	mutex_unlock(&cmd->lock);
 
-	blk_mq_complete_request(req);
+	blk_mq_complete_request_locally(req);
 	return true;
 }
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0896e21642be..a605954477da 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -381,7 +381,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
 	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-	blk_mq_complete_request(req);
+	blk_mq_complete_request_locally(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c289991ffaed..7cbaee282b6d 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1568,7 +1568,11 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
 	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
 		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(cmd->request);
+
+	if (unlikely(host_byte(cmd->result) != DID_OK))
+		blk_mq_complete_request_locally(cmd->request);
+	else
+		blk_mq_complete_request(cmd->request);
 }
 
 static void scsi_mq_put_budget(struct request_queue *q)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
