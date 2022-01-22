Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE7DC433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qxxh2m6PuB2dHP6HEE7eZbZqAl8fy6fCQ0SrIpnMil4=; b=aKsblwpKTAPuGTCYTNkpj1klm1
	eY+Njk2VKxonG/Yo+IIfka1iZctXrY2i08p2E2X97iUaOhVKfQ/lLcP7ZLVvjWLiswv2qdQY2KAzp
	av85tS5GkGyfxhyXMUfPLkzy1sKmEinx9JUU8p+j/GiInQe+1lZg2H4Xu8tDWNRNDRYAh3IaSOHFe
	TZw5uk4SxM00Cig34kbg9EYkl+CkyZhHM0id1SUYW/dRMqLFiEybFzwLymGMbFIJb8yBpyvI/pn8p
	xMtO1VBPBbCRbwEUBXUhXV9WfbyFIcZER2y1gwv05c449bD8VCqeuphw3tHbVUykpNmc3j9FkUI1b
	UZt+kVxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBELW-00HAjU-Mn; Sat, 22 Jan 2022 11:14:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBEJy-00HADu-Nz
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 11:12:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642849957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qxxh2m6PuB2dHP6HEE7eZbZqAl8fy6fCQ0SrIpnMil4=;
 b=DJOQbgmex7aVv3/572Q3Df3/vuu8mWUBmDmjsNNQMHyUI+xubtL/yYAgP+zBfOQucBzsyg
 i6BLKPo+j/7G/uFZAWeSCNAiV1bQt4NeoBdto0MW0ZxiYDPacl7n6b9o2B96chJqWWbrXs
 F5T7CJfMpJs3ejB0dYAwtGs/M9pwmJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-3_Ai3tyWNYGEhkRQpEXpnA-1; Sat, 22 Jan 2022 06:12:32 -0500
X-MC-Unique: 3_Ai3tyWNYGEhkRQpEXpnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D0C814243;
 Sat, 22 Jan 2022 11:12:31 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C92847B9D3;
 Sat, 22 Jan 2022 11:12:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 09/13] scsi: force unfreezing queue into atomic mode
Date: Sat, 22 Jan 2022 19:10:50 +0800
Message-Id: <20220122111054.1126146-10-ming.lei@redhat.com>
In-Reply-To: <20220122111054.1126146-1-ming.lei@redhat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220122_031238_905324_1FA7E1DB 
X-CRM114-Status: GOOD (  14.01  )
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

In scsi_disk_release() request queue is frozen for clearing
disk->private_data, and there can't be any FS IO issued to
this queue, and only private passthrough request will be handled, so
force unfreezing queue into atomic mode.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0e73c3f2f381..27f04c860f00 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3670,7 +3670,7 @@ static void scsi_disk_release(struct device *dev)
 	 * in case multiple processes open a /dev/sd... node concurrently.
 	 */
 	blk_mq_freeze_queue(q);
-	blk_mq_unfreeze_queue(q);
+	__blk_mq_unfreeze_queue(q, true);
 
 	disk->private_data = NULL;
 	put_disk(disk);
-- 
2.31.1


