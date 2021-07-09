Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED902C07E9B
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:11:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F85613C3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F85613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yl8hah6qIvSEyWEtcLArGMsjB6EfFZ+Rj1JamV+x3lo=; b=xQXnGfkUir1v8R
	7kfo+OS5u3VyMdWy1CPZATrVm9TtsadoBhxQzSQpvrBYhVb0ieWL2PHhtj4oPcGhY5oaDJMJzNAGV
	0+2aNmr9gtufOzZbQ16zgvwoEFKC8umlRXF2EpDaDBS0UAsPsFdrdeF3ahzDUhnGNE/7St1F5QAR7
	f/goCdbOr3nEgfjje/6Oq1kWMs1alT4B8y6qP8geZ8AkjZlenRJxnPDbOibSqzFCAeaiVUED+KX5B
	0z9dLdvXnKmAqxQz5UbRtSwzIaCM15fIz8CAK5G0YKaJYcSlbEOkhyWMFXAHVrwM+7LNV/MQPTXKJ
	thriZxMp7FlojAD6SoTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1lbA-0013oP-7Z; Fri, 09 Jul 2021 08:11:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1lb3-0013mu-7f
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:10:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625818252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTFmuCN1nhaQls6kJgr9OGlbYp4H896z+x88MfyTwr8=;
 b=SK8mApN4IEuQx0lP6miJWywiijc5aCyNZtRXBGDbUjC7JgbPCxKNDzHGTAMVXmWJq8kXxz
 1XHIf0IfVDPz1lrHgzmNYTlwWx+NoVnC3UN88WrC1iJpAOww0ZiyE4+VvKnuC9Eunu+AgP
 oqyLKUM/1zhM5dWNnivVnKJZiQkh4fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-bX2_Ubk3MfGti4POoUDefg-1; Fri, 09 Jul 2021 04:10:51 -0400
X-MC-Unique: bX2_Ubk3MfGti4POoUDefg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139871084F40;
 Fri,  9 Jul 2021 08:10:49 +0000 (UTC)
Received: from localhost (ovpn-13-13.pek2.redhat.com [10.72.13.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C14EB5C1D5;
 Fri,  9 Jul 2021 08:10:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 02/10] blk-mq: Introduce blk_mq_dev_map_queues
Date: Fri,  9 Jul 2021 16:09:57 +0800
Message-Id: <20210709081005.421340-3-ming.lei@redhat.com>
In-Reply-To: <20210709081005.421340-1-ming.lei@redhat.com>
References: <20210709081005.421340-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_011053_410158_4A208436 
X-CRM114-Status: GOOD (  17.97  )
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

Introduce blk_mq_dev_map_queues so that we can remove all kinds of
map_queues implementation(pci, virtio, rdma, ...) out of block layer.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-map.c     | 53 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  5 ++++
 2 files changed, 58 insertions(+)

diff --git a/block/blk-mq-map.c b/block/blk-mq-map.c
index 3db84d3197f1..e3ba2ef1e9e2 100644
--- a/block/blk-mq-map.c
+++ b/block/blk-mq-map.c
@@ -94,3 +94,56 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
 
 	return NUMA_NO_NODE;
 }
+
+/**
+ * blk_mq_dev_map_queues - provide generic queue mapping
+ * @qmap:	CPU to hardware queue map.
+ * @dev_off:	Offset to use for the device
+ * @get_queue_affinity:	Callback to retrieve queue affinity
+ * @dev_data:	Device data passed to get_queue_affinity()
+ * @fallback:	If true, fallback to default blk-mq mapping in case of
+ * any failure
+ *
+ * Generic function to setup each queue mapping in @qmap. It will query
+ * each queue's affinity via @get_queue_affinity and built queue mapping
+ * that maps a queue to the CPUs in the queue affinity.
+ *
+ * Driver has to set correct @dev_data, so that the driver callback
+ * of @get_queue_affinity can work correctly.
+ */
+int blk_mq_dev_map_queues(struct blk_mq_queue_map *qmap, void *dev_data,
+		int dev_off, get_queue_affinty_fn *get_queue_affinity,
+		bool fallback)
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	/*
+	 * fallback to default mapping if driver doesn't provide
+	 * get_queue_affinity callback
+	 */
+	if (!get_queue_affinity) {
+		fallback = true;
+		goto fallback;
+	}
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		mask = get_queue_affinity(dev_data, dev_off, queue);
+		if (!mask)
+			goto fallback;
+
+		for_each_cpu(cpu, mask)
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+	}
+
+	return 0;
+
+fallback:
+	if (!fallback) {
+		WARN_ON_ONCE(qmap->nr_queues > 1);
+		blk_mq_clear_mq_map(qmap);
+		return 0;
+	}
+	return blk_mq_map_queues(qmap);
+}
+EXPORT_SYMBOL_GPL(blk_mq_dev_map_queues);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fd2de2b422ed..b6090d691594 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -553,7 +553,12 @@ void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 
+typedef const struct cpumask * (get_queue_affinty_fn)(void *dev_data,
+		int dev_off, int queue_idx);
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+int blk_mq_dev_map_queues(struct blk_mq_queue_map *qmap, void *dev_data,
+		int dev_off, get_queue_affinty_fn *get_queue_affinity,
+		bool fallback);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
