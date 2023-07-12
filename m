Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3A8EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YJ4imw3iHzN6mbjqWrKiopdQuaapVjZy4MvSNpK4PGw=; b=W3IYOZJgYeT/r2NkzMcO5uFpnU
	BAfD5Lv1EZqTzJn4T5+pyNURFQri3ioNF3YdP0vnoVI2CW+OlZwR2CJaOWtQEacr9WqT8cLcmwGO0
	BEDLTVOU890JmtgBMnnFoydwwlaxnWCBLWUg45R9xHn9Ohui5m2CJHLlnX1r2ajEDVZH3TMaQ5e/E
	7qhhIH1hrpRJcm9MsMxnO7QsuzVqsYmezNGGthrR9FYo1zS9YIWd+aNxAZ2oW6cpBUzBuAgsjoBlE
	PZsAtA/2nf/fxOxjlFQ8gMjqVk06p5qn9yp2w8RbV87hffX8cCno+1tHdzfUSMELdZ76zXA0GMc1P
	uuy1HK7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZNL-00HaGQ-2S;
	Wed, 12 Jul 2023 12:55:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZNI-00HaEr-0B
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 12:55:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689166518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ4imw3iHzN6mbjqWrKiopdQuaapVjZy4MvSNpK4PGw=;
	b=Zrtac84Bfb/mVVEC1dilDpK4vvypzzqrA3skzGIUIWeekc+o2n8ju5JjzYDVPE7aoNy/HC
	wOTZtg2QD4Ex7YEumCXnmCOLOuS6SjCaidqizZOOLFKxi0NZTRpa576jSLye/yE18a03Ys
	fqsYufUh1Gu1F9KG3EjEeGZMHYS4FwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-V3DQFlR7NK6gTouM1E1UAg-1; Wed, 12 Jul 2023 08:55:15 -0400
X-MC-Unique: V3DQFlR7NK6gTouM1E1UAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB5AC10504AA;
	Wed, 12 Jul 2023 12:55:14 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0338A1454142;
	Wed, 12 Jul 2023 12:55:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH 3/8] scsi: lpfc: use blk_mq_max_nr_hw_queues() to calculate io vectors
Date: Wed, 12 Jul 2023 20:54:50 +0800
Message-Id: <20230712125455.1986455-4-ming.lei@redhat.com>
In-Reply-To: <20230712125455.1986455-1-ming.lei@redhat.com>
References: <20230712125455.1986455-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_055520_171456_7E5613F0 
X-CRM114-Status: GOOD (  13.78  )
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

On arm and ppc64, 'maxcpus=1' is passed to kdump kernel command line,
see `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
still returns all CPUs because 'maxcpus=1' just bring up one single
cpu core during booting.

blk-mq sees single queue in kdump kernel, and in driver's viewpoint
there are still multiple queues, this inconsistency causes driver to apply
wrong queue mapping for handling IO, and IO timeout is triggered.

Meantime, single queue makes much less resource utilization, and reduce
risk of kernel failure.

Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 3221a934066b..88314c3f1dc1 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13012,6 +13012,7 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 	if (phba->irq_chann_mode != NORMAL_MODE)
 		aff_mask = &phba->sli4_hba.irq_aff_mask;
 
+	vectors = min_t(unsigned int, vectors, blk_mq_max_nr_hw_queues());
 	if (aff_mask) {
 		cpu_cnt = cpumask_weight(aff_mask);
 		vectors = min(phba->cfg_irq_chann, cpu_cnt);
-- 
2.40.1


