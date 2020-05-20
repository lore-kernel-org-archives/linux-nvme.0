Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67365C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 11:58:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2640A207D4
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 11:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DV24eZA4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dvaCV7qV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzDiLroM";
	dkim=neutral (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlbinCUb";
	dkim=neutral (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaYEkpR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2640A207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SvfpbkDDTw2fpcJwjxSmkkSbq9waEF5cFXFQPIfSvVk=; b=DV24eZA4oHi/xp
	2JokFYN7o3JSn8j6JTrNgioKr5r5ZKbmrEgATQaMf6rrMSUg+O6IRiikAN2Gpp42ygGhZdqcvpWvr
	KkE/BkxN95wq9IDaWj5lEa9DP5udKue7dJ+wGThVx8so8MiLVaCsUkEhw2pyfh/I9LgUC5PhM0d8f
	K1JMjdctUHuEYXOr0g634rJta3YEquRae4QCs3DRh1EocCGfJVNxLnGD1juKIH9Oizk5Vexj9kw9H
	57+JnWazFOSj+VPnUeo0+etzH+My4sXAvDSCd9n+7W8nIhhsSeaU55QAtuSNihbSQLZzx0IFR/qiR
	Gx+SCcxgFCGw32khTcsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbNMS-0008PN-CJ; Wed, 20 May 2020 11:58:12 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbNMG-0008Ek-7V
 for linux-nvme@bombadil.infradead.org; Wed, 20 May 2020 11:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=WXlA6iqVOZ8HZCskOLfpH3kSJ9rX1tyyGRi5s9Wu9iw=; b=dvaCV7qV6VRDGfxJH0A4djoVFV
 sXsy1xIDEfq6e1offR8bpf/y/ARNhVCW58SSYH3+tVtKd75iEKrvP0nx6XUKTIJfjANpyqW6zNxId
 R7V152AWynx36HrOzSa2Al7wJ8p1c1f9glr71cVHAjBfnHRWjVrrj7fomzNGIDLJfM+MeEBgELtEE
 AVtdC4Gyh/JEnM5v6aacJ+76DVQCjltwT9DUKM9pOX8lxemN5pAV4+lLp2jUn/ypig0+TOvbW8fE4
 R9/oAZm1k0kb6G+BV1XC/eqMGRmZI8JSnvGf5+J7L7RiJmsBj3CCZNa6HkWVSTBkICI/ibJ4dj012
 jU/MNY4Q==;
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbNME-0007O3-GP
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 11:57:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589975838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXlA6iqVOZ8HZCskOLfpH3kSJ9rX1tyyGRi5s9Wu9iw=;
 b=YzDiLroMyDRiUx+R4nHejsLlp22VOvXstJb5KBbLUOPmrSefz8j2Ld2nvfBcV686RVHqTN
 yDwoC4ruEp1ksfxv/bzqQQkeveKQRdlSPOiAakhOM6iUYjn320nLItnhbig+gN7cOjL3QL
 94CGygoRbVULHqulV6sGLuxONd9Ukg8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589975856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXlA6iqVOZ8HZCskOLfpH3kSJ9rX1tyyGRi5s9Wu9iw=;
 b=MlbinCUbJCCkMwTDZOBWbola4a63Q8jRpOa6GMzK1EIyIT/dE4Eh8f0pBsBl+q6wAmZjub
 0zqrGu9NFgygAvoG/wt7EKaOfiQFSQqNzwRBC/HGtiFhQEAfftoKmHTer8Suv6ouWE+iNg
 dLCxRMNDG39BqKJmhxEX/Aj15Xzdb0A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589975878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXlA6iqVOZ8HZCskOLfpH3kSJ9rX1tyyGRi5s9Wu9iw=;
 b=PaYEkpR5BCFFYglnIkPPaF4slxor62hplHouTsyq3PEUg2Qb0T5/0rJiaMSIu9RDEeYWHO
 6VMbEm9wVsaGrx7W8AzzLEQHbrcycxHlR4NuE7fiOrZY9pssN4TbAPgWhALU0MQQLhk0co
 2EUkjvgyipgtrDEg9+/VcAD9/EGctyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-g_-QqIjAO2yX27Jj5FiJ3Q-1; Wed, 20 May 2020 07:57:15 -0400
X-MC-Unique: g_-QqIjAO2yX27Jj5FiJ3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E5AA461;
 Wed, 20 May 2020 11:57:13 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20EB1579A5;
 Wed, 20 May 2020 11:57:08 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] blk-mq: add API of blk_mq_queue_frozen
Date: Wed, 20 May 2020 19:56:53 +0800
Message-Id: <20200520115655.729705-2-ming.lei@redhat.com>
In-Reply-To: <20200520115655.729705-1-ming.lei@redhat.com>
References: <20200520115655.729705-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Alan Adamson <alan.adamson@oracle.com>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk_mq_freeze_queue_wait() isn't very flexible for some case, such as
error recovery: when blk_mq_freeze_queue_wait is called in error
recovery handler, new problem may be triggered on this controller, so
in-flight IO may not complete when blk_mq_freeze_queue_wait() is called.

And error recovery is often run in single context, so dead lock is
triggered, because error recover handler can't move on.

Add one new API of blk_mq_queue_frozen(), error recovery handler may
use this helper to query if the queue has been frozen completely.
Meantime, the error recovery handler can check if there is hardware
failure happened. If yes, error recovery handler can break from current
handling, and run a fresh new recovery, so deadlock can be avoided.

This API will be used to improve error handling of nvme-pci's timeout
handler.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cac11945f602..e595951bcdae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -148,6 +148,12 @@ void blk_mq_freeze_queue_wait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
+bool blk_mq_queue_frozen(struct request_queue *q)
+{
+	return percpu_ref_is_zero(&q->q_usage_counter);
+}
+EXPORT_SYMBOL_GPL(blk_mq_queue_frozen);
+
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d7307795439a..e1d57202d526 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -518,6 +518,7 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+bool blk_mq_queue_frozen(struct request_queue *q);
 
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.25.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
