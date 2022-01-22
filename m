Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A66C433FE
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 11:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7SzlZ2qY9gfx7Y6rCDOZklcwjV2ZnHtReA0zi58Z5r8=; b=uAoOJXMGL59es1fOcwsJRufkxH
	DecfkHBqAd+wHyGTi+f1jDpe02gEoPGbXkK4ZQ4NLeaCCpeMUIEqUSRzY21lT39fUtFzhwme6miJg
	C7rToSvB8DJL1iVdIu4q9rsmpoOBlGTuHUXgM+yKAXySSDA85Q52nvc1VXlBncCHIEcPM/1m3vr+V
	2MpIPGe050mXoQMBLezuPlTrS4oaA08aPBsEc/nlkEx8LJXl1xBslj4XiU1N00nr610jHfrZ+d2lY
	A0TG+b5cphAjBGcPx6BHaAdNxPhzIvCtr6IVC8L/0IVu8A2hHcbz+GhcIQasTKJtGCyz7/959zAp8
	qlkJ+l+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBEKE-00HAL6-Mj; Sat, 22 Jan 2022 11:12:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBEJe-00HA6G-Em
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 11:12:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642849937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SzlZ2qY9gfx7Y6rCDOZklcwjV2ZnHtReA0zi58Z5r8=;
 b=fA4FLMWCNR3FZgSL6q3ekFk1hLqOwyinWqMuILpwcQeqNhlsugOEchsRPWbfaTVA492MMG
 Axnxg5lDAfrpA3kgAa6JrEwgs2ykxSoYT/kkHDVrglY9owysamVAukGDTuVAYh0I6t3nfP
 22EC+EDIMCqnSd+MLiRFtz1hBE3ZEv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-EHdXdVtiO22OobtnEPxh-w-1; Sat, 22 Jan 2022 06:12:11 -0500
X-MC-Unique: EHdXdVtiO22OobtnEPxh-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6036C1006AA3;
 Sat, 22 Jan 2022 11:12:10 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAF4F7B9E1;
 Sat, 22 Jan 2022 11:12:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 06/13] block: don't remove hctx debugfs dir from
 blk_mq_exit_queue
Date: Sat, 22 Jan 2022 19:10:47 +0800
Message-Id: <20220122111054.1126146-7-ming.lei@redhat.com>
In-Reply-To: <20220122111054.1126146-1-ming.lei@redhat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220122_031218_592768_A2AAB1FF 
X-CRM114-Status: GOOD (  12.75  )
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

The queue's top debugfs dir is removed from blk_release_queue(), so all
hctx's debugfs dirs are removed from there. Given blk_mq_exit_queue()
is only called from blk_cleanup_queue(), it isn't necessary to remove
hctx debugfs from blk_mq_exit_queue().

So remove it from blk_mq_exit_queue().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0d25cc5778c9..66cc701921c1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3454,7 +3454,6 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (i == nr_queue)
 			break;
-		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
 	}
 }
-- 
2.31.1


