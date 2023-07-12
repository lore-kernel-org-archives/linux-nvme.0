Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29314EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nk/Wqaa+Kq1K/rJO90p9bF5IpxDn2p06PBFgsL5mmuI=; b=ztsnd15DW0Hg4NWPFUBulIlPWL
	Ns0jdO3kqHnSEAHUjXMrXXRac+OShTAqzgulzz9JXlyZvHx5acqGWxKkXjYQ0i3oNRKdg0+6N3z0H
	HQQFpHbMIxZ0yJJooML6N6RTeJVnaUUbEL3Bhf1MtgEKPbnHcOT2wSk3HvpQT2ZvyfqKpplc9MZwU
	ACBpr9N1V4DfSmrPgaN7tdA+PQOLJpEVjOI8iGYXDCe2ER2bFx4iCiLTqRzoz+c7arIq5jn+zwCC2
	ceRPqyNhTHHuoo5n79cjAiLtK6LS2MmEzhasTeWHwXp/2/6wQpaeBLEtDxyEOsjnn8RGQr+nPQwxa
	uJLxdu1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZNa-00HaOl-1B;
	Wed, 12 Jul 2023 12:55:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZNX-00HaMD-2B
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 12:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689166534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk/Wqaa+Kq1K/rJO90p9bF5IpxDn2p06PBFgsL5mmuI=;
	b=X/XBCsDLfWqlHy70qKvaK8pKm2qngOPPfdNE7mKGbcCfrVOTgQyJe6kfpXLHhRPKrPSzf8
	/J0BAMiGlyVOlgTez9UxPxtCvslnurrXuIcstp0qsVHBXZ/dBcECEL8dXo0Pq+QRvpKk+O
	zmpWyLTdXehI6yg+nemV2f9sVCUKqHQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-FEyENvIFP9Gm5X0qWJ9PYQ-1; Wed, 12 Jul 2023 08:55:31 -0400
X-MC-Unique: FEyENvIFP9Gm5X0qWJ9PYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A4943C0FC94;
	Wed, 12 Jul 2023 12:55:30 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BC6362017EB9;
	Wed, 12 Jul 2023 12:55:29 +0000 (UTC)
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
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 7/8] scsi: mpt3sas: take blk_mq_max_nr_hw_queues() into account for calculating io vectors
Date: Wed, 12 Jul 2023 20:54:54 +0800
Message-Id: <20230712125455.1986455-8-ming.lei@redhat.com>
In-Reply-To: <20230712125455.1986455-1-ming.lei@redhat.com>
References: <20230712125455.1986455-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_055535_794577_ACB8A1E1 
X-CRM114-Status: GOOD (  15.07  )
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

Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 53f5492579cb..18a73d3ff00b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3332,8 +3332,8 @@ _base_alloc_irq_vectors(struct MPT3SAS_ADAPTER *ioc)
 	 * Don't allocate msix vectors for poll_queues.
 	 * msix_vectors is always within a range of FW supported reply queue.
 	 */
-	int nr_msix_vectors = ioc->iopoll_q_start_index;
-
+	int nr_msix_vectors = min_t(unsigned int, ioc->iopoll_q_start_index,
+			blk_mq_max_nr_hw_queues());
 
 	if (ioc->smp_affinity_enable)
 		irq_flags |= PCI_IRQ_AFFINITY | PCI_IRQ_ALL_TYPES;
-- 
2.40.1


