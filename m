Return-Path: <SRS0=C+HF=L2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C0C11F68
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:07:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC0A61420
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC0A61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Oitux8U1MgeyCpY7996bv0gxXUKw+ME4ALOcDoNhx7k=; b=xuSSHAzeEh6kKp
	OjkIbINSz31TBMzgDxaeDpxFwgR+opwVLb/KkR4hU2S93UYcsxGJBknW8ldvp5TmjkdZ9VieZodtY
	FyfAnuK65rHcCWg6fTCB5FachwhGUGzOAEeBFb35qLOWvtNXWW/YtvdiaHg2WdFQB0bjPqHdxetWR
	3jp22iTRGlIIG3grqQC5DwDJUegGYndy8h7K6BTr6jHdS8UZrc2+VDkvjhl611jVG8I5BvMnhlIOe
	p02MIYQquboIhFYrTw/1aHlK2XhdWMpODzpXQCt7prT7pUfGawISkgCnfqK2xaicjZLG0W9vGB+te
	mlEmyBLCHCAej4hPcxDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lzKle-003MS2-Hd; Fri, 02 Jul 2021 15:07:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzKlb-003MQV-JE
 for linux-nvme@lists.infradead.org; Fri, 02 Jul 2021 15:07:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625238462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9znRiot0Er4LvorWe0Rext34xrr/1zUg0AXQOCMp828=;
 b=iKPchkLrHxEoXItf33T4UdGz+e8whmb5PANJIMripN4Cw8oTMNDO2Zv3ywhof8pXJ2B+h0
 qsaFExsOiwv0K54gmEhCMNKfHl5rD+T7xNm7kbpJRtKQdnxIOCenJI6ewuR5Cp9J28jAJH
 SJTIXgbs/SJJt9IjNqTlDCBc3NRUgAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-_w1dB6tLNYuFttS27tWrhw-1; Fri, 02 Jul 2021 11:07:39 -0400
X-MC-Unique: _w1dB6tLNYuFttS27tWrhw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3615310C1ADC;
 Fri,  2 Jul 2021 15:07:37 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B33BC10016F7;
 Fri,  2 Jul 2021 15:07:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/6] nvme: pci: pass BLK_MQ_F_MANAGED_IRQ to blk-mq
Date: Fri,  2 Jul 2021 23:05:51 +0800
Message-Id: <20210702150555.2401722-3-ming.lei@redhat.com>
In-Reply-To: <20210702150555.2401722-1-ming.lei@redhat.com>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210702_080743_749728_1F7DF299 
X-CRM114-Status: GOOD (  14.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk-mq needs to know if the controller allocates managed irq vectors or
not, so pass the info to blk-mq.

The rule is that driver has to tell blk-mq if managed irq is used.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d3c5086673bc..093c56e1428e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2317,7 +2317,8 @@ static void nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.queue_depth = min_t(unsigned int, dev->q_depth,
 						BLK_MQ_MAX_DEPTH) - 1;
 		dev->tagset.cmd_size = sizeof(struct nvme_iod);
-		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
+		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE |
+			BLK_MQ_F_MANAGED_IRQ;
 		dev->tagset.driver_data = dev;
 
 		/*
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
