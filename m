Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1681DC04A94
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmDg+NZ+45CiVZsrcRhVlp7iBoS4n+VtLARyxp0/jeQ=; b=zjFcJoHnOGiBgUFt0SlQkRRDzB
	P5RxNT/qDPtO/XwCVxHMJolTNw81X/tivZIZEyYqJjbKtx8HlGpvWfjyOdgxzXZBgS/0wsfne1K+n
	DfCJeLXWzuf7QvLsWZ0FCwcRo9MpY5YwUpy/tBZ5kGkdj7iG2U9erUwQYsOIC6d6BIN0aWdIZb+Wy
	qt0tX0YWa9Tdvcz5eSTEEVBU9KvbKARxNeDDSOxuvWMFm2l3npDWGerd4cRCk85GQCXjf1NGO+HKN
	VWi1+t8Jw0Ey54R7PPEqPlTLHu1YYuH1VK6YypCrSyzj95GdYUWDTyY6TYOF9q2Rasd1hQU1lQi4V
	n0cUHIaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKBL-002JYO-0j;
	Tue, 08 Aug 2023 10:43:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKBH-002JUS-2K
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691491394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmDg+NZ+45CiVZsrcRhVlp7iBoS4n+VtLARyxp0/jeQ=;
	b=AEdcCZfDTzz3VKm2rBlS6nsAjp0FMmp+coLPASQlCbI6rhH7dQS5MTqxQAW+t+7X+U7Dlt
	bc/sFHITtvDspwJg6edI8nHQr4LHRkOiDf37jTpskDIplzqFxozLSTLzUMiXSkEWNXePkZ
	2VB1xq6kYMjc2tZClCcA/MlyXD44gqQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-p5xl1a_TOn6Td8XWkcJAXw-1; Tue, 08 Aug 2023 06:43:09 -0400
X-MC-Unique: p5xl1a_TOn6Td8XWkcJAXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDE4C280FEC7;
	Tue,  8 Aug 2023 10:43:08 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3417A2166B25;
	Tue,  8 Aug 2023 10:43:07 +0000 (UTC)
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
	Justin Tee <justin.tee@broadcom.com>,
	Justin Tee <justintee8345@gmail.com>,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH V3 06/14] scsi: lpfc: use blk_mq_max_nr_hw_queues() to calculate io vectors
Date: Tue,  8 Aug 2023 18:42:31 +0800
Message-Id: <20230808104239.146085-7-ming.lei@redhat.com>
In-Reply-To: <20230808104239.146085-1-ming.lei@redhat.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_034315_848958_9439D65A 
X-CRM114-Status: GOOD (  13.91  )
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

Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Cc: Justin Tee <justintee8345@gmail.com>
Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 3221a934066b..961ff392f1c5 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13025,6 +13025,8 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 		flags |= PCI_IRQ_AFFINITY;
 	}
 
+	vectors = min_t(unsigned int, vectors, scsi_max_nr_hw_queues());
+
 	rc = pci_alloc_irq_vectors(phba->pcidev, 1, vectors, flags);
 	if (rc < 0) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
-- 
2.40.1


