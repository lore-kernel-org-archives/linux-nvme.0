Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDBAC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qirubjWy4NpcVODIc9rAZROQONujRbVp9oXqOYfiJYE=; b=S3R4JNbr6fFaVXOjCzRApumA36
	f+TTRPB+1UBiST8qX2oZIsYdqp6fUnKqcxf8wk/fN8+1VY3BiqqIXD78nXJiKQT0vbpefe2Q/Qp3q
	x+2eW5he2ME+NIqJKzGnF3V4KaU0nGhoxqbGRxhSnWFMbDJDNrc6vOhH6EbQvQ4glX50zPtmkgpii
	sprpSSiJX9T1oY4M3VJAl8eLaSlQC42TeO7r5+sD+jWaFu9T/QKFMjKCtt7WzG/KqaS4Zh2hlPigI
	vgiVqtJgoi3y0m1OUetZ18mXZkQjOospgeShNNLSG6sWHeTQ1UDCV0fjrENYEvDX0QgMdLJw7rUeK
	WrGuH7fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBENp-00HBN4-F7; Sat, 22 Jan 2022 11:16:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBEKC-00HAKF-Vw
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 11:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642849972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qirubjWy4NpcVODIc9rAZROQONujRbVp9oXqOYfiJYE=;
 b=VuhvC7kqmht3Dj13eNDHz81+2dzVNYBbSn8iMFBjLGjEtpZPH+f/z9iSsGZHAtz9Yfz/cu
 8NP40G1uuk5Wip+j+0f3fWXfNuLynlnH0Fvrk9ek/lunb3Kh/jKrIlusj0Zb+yMAx8vNEf
 W2/A5a6nz6WxYGQBPmLW1K2abWLVYyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-jlWM71YgOaKt1P9L5_8vIQ-1; Sat, 22 Jan 2022 06:12:46 -0500
X-MC-Unique: jlWM71YgOaKt1P9L5_8vIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18906814245;
 Sat, 22 Jan 2022 11:12:45 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 408711081300;
 Sat, 22 Jan 2022 11:12:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 12/13] block: move rq_qos_exit() into disk_release()
Date: Sat, 22 Jan 2022 19:10:53 +0800
Message-Id: <20220122111054.1126146-13-ming.lei@redhat.com>
In-Reply-To: <20220122111054.1126146-1-ming.lei@redhat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220122_031253_145258_37B4166C 
X-CRM114-Status: GOOD (  12.73  )
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

There can't be FS IO in disk_release(), so it is safe to move rq_qos_exit()
there.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index f1aef5d13afa..2f0e92cdcf6d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -622,7 +622,6 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_mq_freeze_queue_wait(q);
 
-	rq_qos_exit(q);
 	blk_sync_queue(q);
 	blk_flush_integrity();
 	/*
@@ -1125,6 +1124,7 @@ static void disk_release_queue(struct gendisk *disk)
 		 */
 		blk_mq_freeze_queue(q);
 		blk_exit_queue(q);
+		rq_qos_exit(q);
 		__blk_mq_unfreeze_queue(q, true);
 	}
 
-- 
2.31.1


