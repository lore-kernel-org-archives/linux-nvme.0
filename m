Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 07:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qP5lgzlSfPS1WcUPtQFjVSSj/qUXqQzGqLQNL0G+rkE=; b=3zWt6hEvLZgdZpxs87RnjNxEHJ
	4v2H5Weh+vwVnNTQgiGN6BD4s7LATdRZe5OBt4c0paTF/yy2W0UL/4V4QsyqDYD6AAW0xfV+UbXES
	OpGQD4uTP5gUKAGV/fyWhzI01yqq6FNwLss7CJY6r0BuJeHWv2Buo0UybuQAHqGHoHdwsGIvx0w3E
	hyZHmbguhTCbGpqlAtZX7DNJLTY6BOkwk7vxVh+n6NsOtZvabWF7LzJ8RwD3uoTz2XokbqiNQT6Jg
	rEc8/P1f7tQlkpdTytCZdDgKtJcfVCgjzHXDJ3axZq+e8r5mO1alr3jwI97FxPfPTgUqIyk3JL+15
	syBlFYnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrxjH-003vDk-2s; Tue, 30 Nov 2021 07:39:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrxiy-003v76-A9
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 07:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638257927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qP5lgzlSfPS1WcUPtQFjVSSj/qUXqQzGqLQNL0G+rkE=;
 b=TjiUOSZ6NA38hNh/Z8Y3sE5KMANSqPTorAIrc4+E2SzSfCM2LOidrPWwhQJMSvqvMAQIRf
 bWW7Xw/R5m0KwPPlmehoPs/sac7d3s7QcWi51Wyr810PyS1UKqozWKVsZjujtxoGpGGQ/Z
 D6/BDlXjE/zhN6jPtP0lb/xO8qyUWvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-QyGI1VKwPbepzAfNy_X2bg-1; Tue, 30 Nov 2021 02:38:46 -0500
X-MC-Unique: QyGI1VKwPbepzAfNy_X2bg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1F2580DDFE;
 Tue, 30 Nov 2021 07:38:44 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C935E5D6BA;
 Tue, 30 Nov 2021 07:38:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/5] scsi: use blk-mq quiesce APIs to implement
 scsi_host_block
Date: Tue, 30 Nov 2021 15:37:52 +0800
Message-Id: <20211130073752.3005936-6-ming.lei@redhat.com>
In-Reply-To: <20211130073752.3005936-1-ming.lei@redhat.com>
References: <20211130073752.3005936-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_233848_456158_D80D741C 
X-CRM114-Status: GOOD (  14.51  )
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
blk_mq_shared_quiesce_wait() for scsi_host_block().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5e8b5ecb3245..d93bfc08bc1a 100644
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
+			if (blk_mq_shared_quiesce_wait(q))
+				break;
+		}
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(scsi_host_block);
-- 
2.31.1


