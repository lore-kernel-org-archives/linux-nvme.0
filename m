Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF1C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13757613C3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13757613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OTH+FRAT/7KSziGV0FwHtln0wgPaQiaUGKENS450mnU=; b=jI08cJT/AF6zDP
	nw6lqSqCyck6n0H3zCDc0Auc6rHYYu1tplBuhUF/nU7RAAjrJQ7aV8vec/nyFFve6kC2sZfOnzv1O
	WUBSX+JNhr/2CSaORfu/1JQc1Fdr1Hz/LXge9HrPzbgwHfeshI0SvRjs1tP0i527vk8WLdi1r2aKB
	xm+x9L7z6slK3sKI2RzQUwVBvhD6wL8k0hteYj35qY2iTg/VQExJ7x7sMjqjUuzWaEhlZPhxczCAG
	kVS+U0Nk6yWdb99zKruTetOpkoolB5RN+x6K5qbt0D0vn14eCAvhZeDSa0xLa72pTFmYihsMKsa+K
	glEsFWF2r/a7PW5rE1lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1lbN-0013ur-Iu; Fri, 09 Jul 2021 08:11:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1lbD-0013pa-2G
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625818262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ae4rwY22KJlGMWYfTdNuML5h3kZw5x2TXcHut6UGzGc=;
 b=WdbloYBM5Vt3yesD1waPqkra7UyVAov6Wt4Ugz7dfJUR3qYvh2nszSuNqlSlJD2XVM4j/H
 v3akiMxy+kUAZeomjB3/v719jogJt00GFHyod+tUt7IPi74qhIn0B2tnL8QSD4dwTTwian
 gMWga395ejUIjSCmtPFcyYeeFFbg4H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-jMNzBXjnNbKEGRrQ4kao1A-1; Fri, 09 Jul 2021 04:10:58 -0400
X-MC-Unique: jMNzBXjnNbKEGRrQ4kao1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51761804302;
 Fri,  9 Jul 2021 08:10:56 +0000 (UTC)
Received: from localhost (ovpn-13-13.pek2.redhat.com [10.72.13.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 349DE189C7;
 Fri,  9 Jul 2021 08:10:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 03/10] blk-mq: pass use managed irq info to
 blk_mq_dev_map_queues
Date: Fri,  9 Jul 2021 16:09:58 +0800
Message-Id: <20210709081005.421340-4-ming.lei@redhat.com>
In-Reply-To: <20210709081005.421340-1-ming.lei@redhat.com>
References: <20210709081005.421340-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_011103_261012_AB81C3A6 
X-CRM114-Status: GOOD (  19.75  )
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

Managed irq is special because genirq core will shut down it when all
cpus in its affinity mask are offline, so blk-mq has to drain requests
and prevent new allocation on the hw queue before its managed irq
is shutdown.

In current implementation, we drain all hctx when the last cpu in
hctx->cpumask is going to be offline. However, we need to avoid the
draining of hw queues which don't use managed irq, one kind of user
is nvme fc/rdma/tcp because these controllers require to submit connection
request successfully even though all cpus in hctx->cpumask are offline.
And we have lots of kernel panic reports on blk_mq_alloc_request_hctx().

Once we know if one qmap uses managed irq or not, we needn't to drain
requests for hctx which doesn't use managed irq, and we can allow to
allocate request on hctx in which all CPUs in hctx->cpumask are offline,
then not only fix kernel panic in blk_mq_alloc_request_hctx(), but also
meet nvme fc/rdma/tcp's requirement.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-map.c     | 6 +++++-
 include/linux/blk-mq.h | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-map.c b/block/blk-mq-map.c
index e3ba2ef1e9e2..6b453f8d7965 100644
--- a/block/blk-mq-map.c
+++ b/block/blk-mq-map.c
@@ -103,6 +103,8 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
  * @dev_data:	Device data passed to get_queue_affinity()
  * @fallback:	If true, fallback to default blk-mq mapping in case of
  * any failure
+ * @managed_irq: If driver is likely to use managed irq, pass @managed_irq
+ * as true.
  *
  * Generic function to setup each queue mapping in @qmap. It will query
  * each queue's affinity via @get_queue_affinity and built queue mapping
@@ -113,7 +115,7 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
  */
 int blk_mq_dev_map_queues(struct blk_mq_queue_map *qmap, void *dev_data,
 		int dev_off, get_queue_affinty_fn *get_queue_affinity,
-		bool fallback)
+		bool fallback, bool managed_irq)
 {
 	const struct cpumask *mask;
 	unsigned int queue, cpu;
@@ -136,6 +138,8 @@ int blk_mq_dev_map_queues(struct blk_mq_queue_map *qmap, void *dev_data,
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 
+	qmap->use_managed_irq = managed_irq;
+
 	return 0;
 
 fallback:
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b6090d691594..a2cd85ac0354 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -192,7 +192,8 @@ struct blk_mq_hw_ctx {
 struct blk_mq_queue_map {
 	unsigned int *mq_map;
 	unsigned int nr_queues;
-	unsigned int queue_offset;
+	unsigned int queue_offset:31;
+	unsigned int use_managed_irq:1;
 };
 
 /**
@@ -558,7 +559,7 @@ typedef const struct cpumask * (get_queue_affinty_fn)(void *dev_data,
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 int blk_mq_dev_map_queues(struct blk_mq_queue_map *qmap, void *dev_data,
 		int dev_off, get_queue_affinty_fn *get_queue_affinity,
-		bool fallback);
+		bool fallback, bool managed_irq);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
