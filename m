Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3C2C001DF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k/XiItvuETzuFaV0q2/0Ml9SkHL0l2Lbxykjfon98Ww=; b=oKnXnHgxdF2fv1DNWFW0vu4gMW
	18nG1wN0pXbbON3Y375QsUwbCvoH6xgKFxP+3m6BgRDU761H7vc5MpXjxO7OEDaNU+6C8ECvOHXt+
	2wo0durgXfiXNhj2gu/1Ctd1iQao/X999NqJ9MCVhQm2IKljlRfL+IqZr40+eYc+PrxEf2oOB8CY7
	NEGQxIHaYa+bG+4tXDaqNW7vP83YMSv5yAkfAvZjU5qkpPaEo4gC1mQbtoH1paRgeFCxw1xSBUMyI
	b3Y6DYLd2qkWE8y+KEH0m1jtalDfEoBezpJwNO4w+A1mbGs9hFcclBStS4NCgZlkk+2/h0Xal7drj
	c5Eun6YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKB6-002JJa-1B;
	Tue, 08 Aug 2023 10:43:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKB3-002JH3-2p
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691491381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/XiItvuETzuFaV0q2/0Ml9SkHL0l2Lbxykjfon98Ww=;
	b=NGAGWyI57r5wps7a3rIgJEDmAZ8otE7DU9QkMIVQHY7F9UJAG9Z7RGo/65O0JjC3ROiJ9H
	3Fm9+CZ30IKFikswE4xoLoNsbNIeCNZcgiajfxd/B7UJ/nzJxfxnNio6mTIiG5PxNOnBNN
	FkknaEikQ1tV46A30L/O0SDellRFhwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-dHf5P5j1NCCY04pi7Cukww-1; Tue, 08 Aug 2023 06:42:55 -0400
X-MC-Unique: dHf5P5j1NCCY04pi7Cukww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A89B85CCE0;
	Tue,  8 Aug 2023 10:42:55 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 65E124E3D1;
	Tue,  8 Aug 2023 10:42:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 02/14] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate io queues
Date: Tue,  8 Aug 2023 18:42:27 +0800
Message-Id: <20230808104239.146085-3-ming.lei@redhat.com>
In-Reply-To: <20230808104239.146085-1-ming.lei@redhat.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_034301_986915_87F09099 
X-CRM114-Status: GOOD (  16.11  )
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

Take blk-mq's knowledge into account for calculating io queues.

Fix wrong queue mapping in case of kdump kernel.

On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
`Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
still returns all CPUs because 'maxcpus=1' just bring up one single
cpu core during booting.

blk-mq sees single queue in kdump kernel, and in driver's viewpoint
there are still multiple queues, this inconsistency causes driver to apply
wrong queue mapping for handling IO, and IO timeout is triggered.

Meantime, single queue makes much less resource utilization, and reduce
risk of kernel failure.

Reported-by: Wen Xiong <wenxiong@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index baf69af7ea78..a1227ae7eb39 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2251,7 +2251,7 @@ static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		return 1;
-	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
+	return blk_mq_max_nr_hw_queues() + dev->nr_write_queues + dev->nr_poll_queues;
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
-- 
2.40.1


