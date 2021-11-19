Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB95C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 02:20:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8B161AA7
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 02:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E8B161AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kVmDn8fHlf4GXS6Ok/pt7q9KsTTX1i/7O5l8UCEX6+c=; b=i/433JEyExejFF1oZDofkjMpfe
	Sh3XktZP5atY8ej3KwvNz/Z4BYqGJ0GWZZjggZmosM0HWtV41aQxgFbUUvdphUn2WePp7jE2GnlTJ
	4jPjPJGIhgGZ+ueePE/sZwb4vXyrAWOMiGEDdew4o2vfm3yzxNy2aN0N79Ife/Vq1DS/62KKnGMnU
	c/4+eU5z+IIiql2pijJEh+3b5Xn9JaY6+RNecDzuCwOwBUeYAmOywpndyCHUVzDCk1yVJaklUF0Xw
	p/KaSJTRSHB39zSrZbjsHL7FnRfLX4H0rHO7nzWhukc4h3hQr7cmruJluFmGodtiuoHIzBFa6vZh7
	12Tm9qiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mntVo-009EsG-TQ; Fri, 19 Nov 2021 02:20:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mntVP-009Eio-Fh
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 02:20:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637288396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kVmDn8fHlf4GXS6Ok/pt7q9KsTTX1i/7O5l8UCEX6+c=;
 b=a1x5P/XQ0q6SEGFWbbjIwabAbJMjufjGYvWyxRmSZJMB2kbDQ2eOhKMy1vIksHuOX6+WeJ
 /vYsLba8Y3dw5LiP9scOypYXYnqq+FUaZcCuDTTuj0vQZf3xCdJjfagaT/1I0vdgaxW4l0
 7KEPXZgNOQzPQJjcXlxxRTdmZkLkR3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-ueS-ZQ7CPi6veN9qdj_HDQ-1; Thu, 18 Nov 2021 21:19:51 -0500
X-MC-Unique: ueS-ZQ7CPi6veN9qdj_HDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE2E91808312;
 Fri, 19 Nov 2021 02:19:49 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84D115F4ED;
 Fri, 19 Nov 2021 02:19:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/5] scsi: use blk-mq quiesce APIs to implement scsi_host_block
Date: Fri, 19 Nov 2021 10:18:49 +0800
Message-Id: <20211119021849.2259254-6-ming.lei@redhat.com>
In-Reply-To: <20211119021849.2259254-1-ming.lei@redhat.com>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_181959_635891_47F2AF9E 
X-CRM114-Status: GOOD (  14.63  )
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

scsi_host_block() calls synchronize_rcu() directly to wait for
quiesce done, this way is ugly since it exposes blk-mq quiesce's
implementation details.

Instead apply blk_mq_wait_quiesce_done() and
blk_mq_global_quiesce_wait() for scsi_host_block().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5e8b5ecb3245..b0da6a4a1784 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2952,15 +2952,15 @@ scsi_host_block(struct Scsi_Host *shost)
 		}
 	}
 
-	/*
-	 * SCSI never enables blk-mq's BLK_MQ_F_BLOCKING flag so
-	 * calling synchronize_rcu() once is enough.
-	 */
-	WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);
-
-	if (!ret)
-		synchronize_rcu();
+	if (!ret) {
+		shost_for_each_device(sdev, shost) {
+			struct request_queue *q = sdev->request_queue;
 
+			blk_mq_wait_quiesce_done(q);
+			if (blk_mq_global_quiesce_wait(q))
+				break;
+		}
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(scsi_host_block);
-- 
2.31.1


