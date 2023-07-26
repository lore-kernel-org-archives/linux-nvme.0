Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E70C001DE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJmMz6GY1NqtDQ+LEnNxukeD0cgVej3lcgCePHgOvCg=; b=ZVNI6pJzbnpIOV1pgjyqPti4XN
	/L1q4rhWV5/Pr4/iblcLL4hCVMU3OJj5ePU5yDFQbS8zwUrm2nNh1bJuSTPq8S6jmmpro9CXvMyXY
	ILFSO1U/8tWa5QlSRnjZl6MZ82MYSQQheFJGm8+nnMINlfDgmvpZqEaudeMapxvgsWJO5F47J17b/
	EcVo4GQHNRwkjTk1N0EbcgTbwdVLzsjH2y9a/DbHZ4M/OJa07n+h7euuUS3LZLBFwNtFuuuKI/fkh
	83PZYDMk913GQsNEZ7uitqjqocCCEEi3XX+Vq9bCyqa+ugKzwKRGeX/b/f1gW502jRs4x9Dc0Hzf0
	x3wCIQuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0u-009llC-0c;
	Wed, 26 Jul 2023 09:41:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0q-009liT-2N
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 09:40:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690364455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJmMz6GY1NqtDQ+LEnNxukeD0cgVej3lcgCePHgOvCg=;
	b=XsCAkWGcqT7JXt80aSxXcDSTscK3FqB9l92nJJGfLPE5792utl0re4S/NVqrU961FozZ3z
	pZkCYLEcBd9q7ZkbgOxbD2yCPwgZyFJSoe8bis8WTHBvFo+FEj8Hp7hfnp89WtFvLwjdBL
	vnckQ7ITyBWL2oVVKUfNKMk8exzDVhM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-bqkQtEHjOTuEnIH8CcLJ7g-1; Wed, 26 Jul 2023 05:40:50 -0400
X-MC-Unique: bqkQtEHjOTuEnIH8CcLJ7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BADB129AB3E6;
	Wed, 26 Jul 2023 09:40:49 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0041A40C2063;
	Wed, 26 Jul 2023 09:40:48 +0000 (UTC)
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
	Justin Tee <justintee8345@gmail.com>,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH V2 4/9] scsi: lpfc: use blk_mq_max_nr_hw_queues() to calculate io vectors
Date: Wed, 26 Jul 2023 17:40:22 +0800
Message-Id: <20230726094027.535126-5-ming.lei@redhat.com>
In-Reply-To: <20230726094027.535126-1-ming.lei@redhat.com>
References: <20230726094027.535126-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_024056_844666_FC2391E7 
X-CRM114-Status: GOOD (  14.12  )
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

Cc: Justin Tee <justintee8345@gmail.com>
Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 3221a934066b..c546e5275108 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13022,6 +13022,8 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 		cpu = cpumask_first(aff_mask);
 		cpu_select = lpfc_next_online_cpu(aff_mask, cpu);
 	} else {
+		vectors = min_t(unsigned int, vectors,
+				scsi_max_nr_hw_queues());
 		flags |= PCI_IRQ_AFFINITY;
 	}
 
-- 
2.40.1


