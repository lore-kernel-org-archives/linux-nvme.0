Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7035FC0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 09:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QvKrmms9fUHhxbhcGxDz7QDKl8B/hBW7QeIiIj8phvY=; b=Tryxi231d/ty0IpVBv9NzOxAXE
	LVk18ODUtdAuB38kl9GEdpsXJVWzPOYUhO24enwUca9xj3ZYZn8UOx0Psy9R6fh10C3jk2dDqavoT
	fH7LyLwwBG1/J75hArwi35GCC0AyknpdHsA8athFl6tUSmolFalW3l/8e2Rl/pBUEGn/I9/o/wx1D
	W5gFqDCF1v6ld8wa9mhDtehqbp/cqg1ucVO6obyAZiM3oIEWcmg10A5FSYn1MGgnD4is6H4Te6/Az
	kq/+0nC2NFFvmyrGP8BWXbhF2rev9DyAUhpFzkr629OFPCk8k0yshjnzxJdXJT+qE6OrKLmzOlJNs
	uKsj70eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0m-009lgZ-0r;
	Wed, 26 Jul 2023 09:40:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0j-009lfd-1P
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 09:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690364448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvKrmms9fUHhxbhcGxDz7QDKl8B/hBW7QeIiIj8phvY=;
	b=Y7RZ9Ayep9AmtREhbTT6GI7uRQ0oz10pJZEM7nf4OhnV2Wc/ICvANjJ3WJIZTCOgl1AMsn
	m1NWCualjgp5YqRHNw/UAaqtjftm/nCnl93GQgPQovJkih/x6/qMCfe5Y1PgzCiHyr0GzY
	5mudkZu9l8VYjmJzxQwapWNOfRw+8ao=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-vtSBVKQAMs6GQr_RlH85qQ-1; Wed, 26 Jul 2023 05:40:40 -0400
X-MC-Unique: vtSBVKQAMs6GQr_RlH85qQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 773753C01BA1;
	Wed, 26 Jul 2023 09:40:39 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB50740C2063;
	Wed, 26 Jul 2023 09:40:38 +0000 (UTC)
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
Subject: [PATCH V2 1/9] blk-mq: add blk_mq_max_nr_hw_queues()
Date: Wed, 26 Jul 2023 17:40:19 +0800
Message-Id: <20230726094027.535126-2-ming.lei@redhat.com>
In-Reply-To: <20230726094027.535126-1-ming.lei@redhat.com>
References: <20230726094027.535126-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_024049_549030_AF001443 
X-CRM114-Status: GOOD (  16.07  )
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

blk_mq_alloc_tag_set() may override set->nr_hw_queues as 1 in case of kdump
kernel. This way causes trouble for driver, because blk-mq and driver see
different queue mapping. Especially the only online CPU may not be 1 for
kdump kernel, in which 'maxcpus=1' is passed from kernel command line,
then driver may map hctx0 into one inactive real hw queue which cpu
affinity is 0(offline).

The issue exists on all drivers which use managed irq and support
multiple hw queue.

Prepare for fixing this kind of issue by applying the added helper, so
driver can take blk-mq max nr_hw_queues knowledge into account when
calculating io queues.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 16 ++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b04ff6f56926..617d6f849a7b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -140,6 +140,22 @@ void blk_mq_freeze_queue_wait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
+/*
+ * Return the max supported nr_hw_queues for each hw queue type
+ *
+ * blk_mq_alloc_tag_set() may change nr_hw_queues for kdump kernel, so
+ * driver has to take blk-mq max supported nr_hw_queues into account
+ * when figuring out nr_hw_queues from hardware info, for avoiding
+ * inconsistency between driver and blk-mq.
+ */
+unsigned int blk_mq_max_nr_hw_queues(void)
+{
+	if (is_kdump_kernel())
+		return 1;
+	return nr_cpu_ids;
+}
+EXPORT_SYMBOL_GPL(blk_mq_max_nr_hw_queues);
+
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 495ca198775f..4c0cfd1f9e52 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -711,6 +711,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int queue_depth,
 		unsigned int set_flags);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
+unsigned int blk_mq_max_nr_hw_queues(void);
 
 void blk_mq_free_request(struct request *rq);
 int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
-- 
2.40.1


