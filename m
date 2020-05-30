Return-Path: <SRS0=AYOd=7M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C78DC433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 30 May 2020 13:53:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EEA20715
	for <linux-nvme@archiver.kernel.org>; Sat, 30 May 2020 13:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HSZ1Hr7w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c18sGq5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EEA20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YN15uEjQquUo1xhNFtZik77OE7lS/VStrSVlFBYhzEs=; b=HSZ1Hr7w0EpXDv
	7SuiwNfTeIq5FEfEqSL3ITq1iP44iaFc4QMPL7uQtBxw5KNIt6in1Z90EW8YST6Db/i/VxLfTgR2W
	OlYx4verSQ30EZJFabJP7vjpd55nOVhA7xw3nzLx6PF/2icoY8xV5njXk+xqVTvik8NeuYBh++4P7
	iuerVSo/JDV/5dDu19klJpn+D80/liQojnhlAYLSz6VCGdiMYh8f2BvlVQBr6Z9IiaP7VwwjPYulm
	X0Kz/42CtsX4dSy/w6sCarPtRxB8pDPVigCqD3cRaOe/7u97TW1+P077W6UFYkxPtqOP/gol0FkLy
	Sg3ykyS5v6EYBTBaK4Mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jf1uz-0006Lp-AH; Sat, 30 May 2020 13:52:57 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jf1uv-0006I0-D2
 for linux-nvme@lists.infradead.org; Sat, 30 May 2020 13:52:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590846771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wxFB+oeJxY2LikvP01WxSw60v3LNNOG3VBVBlKjXSU=;
 b=c18sGq5rjEoHSyu9cHS1ySG7b3IDx5mf1tSNRf6uJFz78JmyJQf9nstXhaZB74Tg9+Z/g4
 oQSHUcRDDkBdNz287sJVqkV1Xh171t8HBQqnOzS+JIL7A+WXdcHjeO4NUvxO3Vu7x7OkIl
 ZMMUQ8jJuS3VRd9T9yiuNNpq+TcCGpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-HVVnf0XjPXiN6vtyHw4RfA-1; Sat, 30 May 2020 09:52:44 -0400
X-MC-Unique: HVVnf0XjPXiN6vtyHw4RfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF2B38735C0;
 Sat, 30 May 2020 13:52:42 +0000 (UTC)
Received: from localhost (ovpn-12-60.pek2.redhat.com [10.72.12.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 747252DE81;
 Sat, 30 May 2020 13:52:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 2/3] nvme: add nvme_frozen
Date: Sat, 30 May 2020 21:52:20 +0800
Message-Id: <20200530135221.1152749-3-ming.lei@redhat.com>
In-Reply-To: <20200530135221.1152749-1-ming.lei@redhat.com>
References: <20200530135221.1152749-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200530_065253_519185_9C1D198D 
X-CRM114-Status: GOOD (  11.46  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Dongli Zhang <dongli.zhang@oracle.com>,
 Ming Lei <ming.lei@redhat.com>, Alan Adamson <alan.adamson@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add one new API of nvme_frozen(), reset handler may use this helper to
query if all ns queues have been frozen completely. Meantime, the reset
handler can check if there is new hardware failure happened. If yes, reset
handler can break from current handling, and schedule a fresh new recovery,
so deadlock or deleting controller & fail all IOs can be avoided.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3c037f5a9ba..469010607383 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4243,6 +4243,20 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
 
+bool nvme_frozen(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+	int ret = 0;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		ret += !blk_mq_queue_frozen(ns->queue);
+	up_read(&ctrl->namespaces_rwsem);
+
+	return ret == 0;
+}
+EXPORT_SYMBOL_GPL(nvme_frozen);
+
 void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2e04a36296d9..459e5952ff5f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -508,6 +508,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+bool nvme_frozen(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
-- 
2.25.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
