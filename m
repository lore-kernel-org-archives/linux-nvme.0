Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A21C5517A
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 07:56:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCF920709
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 07:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="urAtTZAs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uxt4bYm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCF920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k3N0WEroCwjqY9av04JFQ69gyVfEVJml/xblG2x6Tus=; b=urAtTZAsTWg1nGEyaNK4iIM80
	57R34kfarjLIdKC2QLx8PiroNLfmbfZNSEMc2bjDSrnEKXYi5sIjTxeOeQsr0RTPdZC+Tk5R+DZ4G
	oI723iYmiExTmPKIcRX4YjulCT/aGraNCGQODvGhXh9U+ccrlDt5MkfTlLS7AxWnP+4rllMwk9srh
	aTPg29+aIVtcGgeItbOViotd14xywhvXAMdQkORvrAqlx2Eyux8NShcINAgl1enI7Sj83moC0e1Zh
	S6S7om5ktjBWJ/KffbU7oerp8KieLSJ5Z93BZSkFJQY0l3oreWH6B9bvZU8pwROtNEVivkrPOt2BX
	04yMOlh2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kd7Sg-0007eY-RE; Thu, 12 Nov 2020 07:56:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kd7SX-0007bV-29
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 07:56:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605167756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jsAotUmAOeJ+J67Hd+8VkNC2AHSQC76cxUm+/CDDsK0=;
 b=Uxt4bYm+me3u7dWsxdZoXkhFS0DBOoZY3CW+QdTkytKcXpy+iygIvsReXVSBSl16Yz1g0G
 sG0K0gAZG4nesk5PvR0IRLoZnYJuA9JvDj+m9peQFUYKxnY/tYu4fDHE6XwBK2JUXwgqLm
 QRvfWOl1SSyKON0XQvOGIcF5sTo7Tm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-bJRgz6FvMfiLKET8DRTB5g-1; Thu, 12 Nov 2020 02:55:52 -0500
X-MC-Unique: bJRgz6FvMfiLKET8DRTB5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B41EB8015B1;
 Thu, 12 Nov 2020 07:55:50 +0000 (UTC)
Received: from localhost (ovpn-12-132.pek2.redhat.com [10.72.12.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E64EA55766;
 Thu, 12 Nov 2020 07:55:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] nvme-loop: use blk_mq_hctx_set_fq_lock_class to set
 loop's lock class
Date: Thu, 12 Nov 2020 15:55:25 +0800
Message-Id: <20201112075526.947079-3-ming.lei@redhat.com>
In-Reply-To: <20201112075526.947079-1-ming.lei@redhat.com>
References: <20201112075526.947079-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_025557_210300_FB5B94E9 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: Bart Van Assche <bvanassche@acm.org>, Qian Cai <cai@redhat.com>,
 John Garry <john.garry@huawei.com>, Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Set nvme-loop's lock class via blk_mq_hctx_set_fq_lock_class for avoiding
lockdep possible recursive locking, then we can remove the dynamically
allocated lock class for each flush queue, finally we can avoid horrible
SCSI probe delay.

This way may not address situation in which one nvme-loop is backed on
another nvme-loop. However, in reality, people seldom uses this way
for test. Even though someone played in this way, it is just one
recursive locking false positive, no real deadlock issue.

Reported-by: Qian Cai <cai@redhat.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/target/loop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f6d81239be21..07806016c09d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -211,6 +211,8 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
 			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
 }
 
+static struct lock_class_key loop_hctx_fq_lock_key;
+
 static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
@@ -219,6 +221,14 @@ static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 	BUG_ON(hctx_idx >= ctrl->ctrl.queue_count);
 
+	/*
+	 * flush_end_io() can be called recursively for us, so use our own
+	 * lock class key for avoiding lockdep possible recursive locking,
+	 * then we can remove the dynamically allocated lock class for each
+	 * flush queue, that way may cause horrible boot delay.
+	 */
+	blk_mq_hctx_set_fq_lock_class(hctx, &loop_hctx_fq_lock_key);
+
 	hctx->driver_data = queue;
 	return 0;
 }
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
