Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B38C43331
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 13:43:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D6822459
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 13:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PAI/P8fs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNkePfQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D6822459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KX2K9UfYsixYpTKG0kDFRyydiOkQ5V05pi21SGgbB0A=; b=PAI/P8fsANQZ/h
	jSmYnPwZt1YpgQGA5ibG5L6Q7JkY+xSKboC5zzkGqKlco91zPhz3A77M5CUnsTvsGEeePAPyJSVw8
	bSNPyOJsGiiHR2NP5KK1ys9PGciMzSchQMVBAcmumro2qjFVdHyWboRcNDUrsFtCe7AaHOWTYfUyF
	hI5lyMzPfCfIcBmSx9S4If/fItABbD231Du4+q3lSWVQ36clGAPeZDulCfN/ZglZv15HwwzomJZ2f
	OnQpeBD5hpxRr39F24TRKh88O4oFFupN4nAmmycQxIPStaS2FHg8WeXMa4OQgpv6mt4HJ1sujkisw
	Tqd5eBAcZWA2bEQivvGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUsvW-0003Ea-2w; Wed, 13 Nov 2019 13:43:18 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUsvQ-00039W-UR
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 13:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573652591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYfOKBMxzeCWKuoOKqRC+m2TUfdzQdVOESFsjLvr+v0=;
 b=JNkePfQLsUuwl/DFPmm0AfsxgiCV+d1m6xqMeVIiNinYPfJ3RUgZi8rPC10butIt/GfS3O
 PUkyy5i9wHK61TFOgtaVIFcYe2zCM1EGT9Zd+87NOIikt8K0mirUDC5CPi4Hf5gOMVp85e
 GfIgoonS7F3/vW1VonrdrpMORJ9QjpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-dzyh-IpKN2qX4MPvjrEo_g-1; Wed, 13 Nov 2019 08:43:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5CDC1005502;
 Wed, 13 Nov 2019 13:43:06 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5C0C8164;
 Wed, 13 Nov 2019 13:43:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] nvme-pci: move sq/cq_poll lock initialization into
 nvme_init_queue
Date: Wed, 13 Nov 2019 21:42:47 +0800
Message-Id: <20191113134248.26022-2-ming.lei@redhat.com>
In-Reply-To: <20191113134248.26022-1-ming.lei@redhat.com>
References: <20191113134248.26022-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dzyh-IpKN2qX4MPvjrEo_g-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_054313_169240_05D7A5E4 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Prepare for adding new cq lock for improving IO performance in case
that device applies aggressive interrupt coalescing, and the new added
cq_lock can share space with cq_poll_lock becasue both are mutually
exclusive.

Move sq/cq_poll lock initialization into nvme_init_queue so that
we may initialize the added cq_lock correctly and lockdep warning
can be avoided.

This way is safe because no IO can be started until nvme_init_queue
is returned.

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Long Li <longli@microsoft.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 869f462e6b6e..01728409a7ea 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1481,8 +1481,6 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 		goto free_cqdma;
 
 	nvmeq->dev = dev;
-	spin_lock_init(&nvmeq->sq_lock);
-	spin_lock_init(&nvmeq->cq_poll_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -1516,6 +1514,9 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
+	spin_lock_init(&nvmeq->sq_lock);
+	spin_lock_init(&nvmeq->cq_poll_lock);
+
 	nvmeq->sq_tail = 0;
 	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
