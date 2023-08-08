Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3208C04A94
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ketWVMOak+Jss00Ni7DMSRSVvfoPSxigoCA6y+QxH1E=; b=31/dlpqI6JshNlNpLQxD1G9N/u
	Wt7UNGD1SHL8a/ADbJqFg47/Mp+WdjQfhvOcGphl5jQLn9G9ZIPRvxyRBkLKflaD1FzEOj2tsZMR1
	5Te788QTzQzxX9a2i+rQX6qfFsbHFYdIWfQiZs+O5h3BYjqX+vuyXnVlvtV/AM4gClaPg4I09Jy9G
	UuxH8O6QLkflulVhtoKB8yHcM8ngfAImKPb7CIf1FMv/C6CChYbYP3ojwFhP/PyRDkqguw7DOwF0I
	K9v0LokCF0VLiVbcv6F+pwbCwwVm+c1p2a7e6Sq5ILH4jKbyoEZGLdzAl4Hf0p00sD6fOV8kd/Kku
	zKvzsX+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKBQ-002Jdy-12;
	Tue, 08 Aug 2023 10:43:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKBM-002JZZ-2D
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:43:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691491399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ketWVMOak+Jss00Ni7DMSRSVvfoPSxigoCA6y+QxH1E=;
	b=dRG4J49SYJiPVB83UrGJfBbbYCyWwCmOqDEA7oBqGn6Xfn3bIbDJWzQkp+995HQsL7wwQj
	/dyG+tteRH0udJa5f+fII/wJ24nrGVDQOTVCl1gZrmfU+UqDBs9cGvv75nVRRrvzN+ZlzY
	5BszmAK6HEB3RDHTatvPCHwsThUPHwI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-MxRzmOzlP2azCBUyTJYr2w-1; Tue, 08 Aug 2023 06:43:16 -0400
X-MC-Unique: MxRzmOzlP2azCBUyTJYr2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0DF880557C;
	Tue,  8 Aug 2023 10:43:15 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D5A51121314;
	Tue,  8 Aug 2023 10:43:14 +0000 (UTC)
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
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH V3 08/14] scsi: megaraid: take blk_mq_max_nr_hw_queues() into account for calculating io vectors
Date: Tue,  8 Aug 2023 18:42:33 +0800
Message-Id: <20230808104239.146085-9-ming.lei@redhat.com>
In-Reply-To: <20230808104239.146085-1-ming.lei@redhat.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_034320_804405_263167D5 
X-CRM114-Status: GOOD (  15.41  )
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

Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 050eed8e2684..587ccbc1ec92 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5921,6 +5921,10 @@ __megasas_alloc_irq_vectors(struct megasas_instance *instance)
 	int i, irq_flags;
 	struct irq_affinity desc = { .pre_vectors = instance->low_latency_index_start };
 	struct irq_affinity *descp = &desc;
+	unsigned max_vecs = instance->msix_vectors - instance->iopoll_q_count;
+
+	if (max_vecs > scsi_max_nr_hw_queues())
+		max_vecs = scsi_max_nr_hw_queues();
 
 	irq_flags = PCI_IRQ_MSIX;
 
@@ -5934,7 +5938,7 @@ __megasas_alloc_irq_vectors(struct megasas_instance *instance)
 	 */
 	i = pci_alloc_irq_vectors_affinity(instance->pdev,
 		instance->low_latency_index_start,
-		instance->msix_vectors - instance->iopoll_q_count, irq_flags, descp);
+		max_vecs, irq_flags, descp);
 
 	return i;
 }
-- 
2.40.1


