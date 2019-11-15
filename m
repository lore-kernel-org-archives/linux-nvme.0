Return-Path: <SRS0=/3pY=ZH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C9C432C3
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B3520748
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RnhZWZnC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+6/u0xS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B3520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+zyQ0Pfeont3TxLW2gfjD14BVq4TQl0ePTClgg6k+cs=; b=RnhZWZnCHdRQkF
	QKWr9G8bCTpYRK1fvjkkfMpB5PJ+EiPyg5EBslGxHHMrRoUipJ/aQcyr8hU9Chb9TzLJfozaCPaUR
	bbkiVuP3tVar6y1wXCMg6PVPvPkyiXlnk1pfrJ47cuZeN3/Pjq1igVJlUZkMK+2z7R7Lvfx+XgH8j
	lE7R0E7g8JpsuQn449z36FIlLIPgYaPo9CcLB4TIahMTwzYIZjTzdupTF5uNWH1B8xB7JlnpMbTQn
	OFq+NMpP9E5BfnUPik0kMgvPUoQHeGh7F+NDM7mJuQOADWThxSzLeZ1VIaACO+gLp1svNO/XpCmtK
	XTHiO2ljgIS5AKh60WjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iVZ4I-0002KX-F5; Fri, 15 Nov 2019 10:43:10 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVZ4D-0002FF-E8
 for linux-nvme@lists.infradead.org; Fri, 15 Nov 2019 10:43:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573814584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyE0Mjzl0M4TOtYje9evGCsRdibvgbalgYO6kWcw1ng=;
 b=N+6/u0xStVQ7xvodzVrAybTDDOxqCs/X21C2+jlD1nblhZMwaUpC6TyTMz2pfsL0ybwPhV
 x01EnM3agKxMH3o5xKDYUs/K4Yy+vXRxV014TZwRPO6xrLGm2KLHEcprR74hqqVi5ZsYhq
 9CY/VfumpSYIeta4tdZFUHYy42NyOs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-OYGCRsUtN82bLl9nwxGQIw-1; Fri, 15 Nov 2019 05:43:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4B88048ED;
 Fri, 15 Nov 2019 10:43:01 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD7495DC1B;
 Fri, 15 Nov 2019 10:42:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC 1/3] block: reuse one scheduler/flush field for private
 request's data
Date: Fri, 15 Nov 2019 18:42:36 +0800
Message-Id: <20191115104238.15107-2-ming.lei@redhat.com>
In-Reply-To: <20191115104238.15107-1-ming.lei@redhat.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: OYGCRsUtN82bLl9nwxGQIw-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191115_024305_545965_2C3BD45A 
X-CRM114-Status: GOOD (  11.39  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reuse one union shared by elevator and flush request for data of
private request. Private request won't enter IO scheduler and never
be a flush request, so reuse the space for data of private request.

This field is added to pass driver private info for private request
only.

Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6a4f7abbdcf7..ce708dc10bdc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -177,7 +177,8 @@ struct request {
 	 * Three pointers are available for the IO schedulers, if they need
 	 * more they have to dynamically allocate it.  Flush requests are
 	 * never put on the IO scheduler. So let the flush fields share
-	 * space with the elevator data.
+	 * space with the elevator data. Private request are never put on
+	 * IO scheduler, and not be a flush request.
 	 */
 	union {
 		struct {
@@ -190,6 +191,9 @@ struct request {
 			struct list_head	list;
 			rq_end_io_fn		*saved_end_io;
 		} flush;
+
+		/* used for private request only */
+		unsigned long private_rq_data;
 	};
 
 	struct gendisk *rq_disk;
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
