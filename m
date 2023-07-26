Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4223C00528
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 09:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tpdmXVrSFhq/BTLlYN4vy8lpJH7u5Vwwe/yeAm4djqM=; b=EFv0lCOklOgifN6YqM1k/uWRW3
	KX+nkVQitk1tC6Om/PU5d8/CHzhJoZWyGiiv8f1FVH+jgg5B6WUF3JGN8dNVgMdk51lRWhT7AbnZc
	XW0hi2tMjQ157sCiPPmuvIleKqnssshGZKoOURmgdRtD4ydrjSCC3mlEi7mH+ET/9ovVYGG9dqfkm
	ZhCB6rDwpCS6OMmot5cOQAiS0qdve8iJYUGjYbXkPxSZMI+1iy1Cmnpi9BP5KQItIJdEohP0iiTNa
	6DLwxtVQ1haIlBu8zgSlszf9nd1EeMJFKCSQEvsZmYJuO6iDWkrvZ3fs/ilDzv91ri8Ko7sh7Fq9S
	ouDaXSGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0v-009llk-0B;
	Wed, 26 Jul 2023 09:41:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0q-009liP-17
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 09:40:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690364455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpdmXVrSFhq/BTLlYN4vy8lpJH7u5Vwwe/yeAm4djqM=;
	b=LLgi3Mnlv07C7DHStNbtSH7jfEYe47HkI+SvPoCh4T0Nt5gxgKn9gNiFIV8B/G4yPF31R/
	FjMDMWTLcRX4Gqlnrd4xD12jQfqPBfmBK7cS7AYHI8vfWD22qTeuRHRakh3CNDCNLFMV32
	RtcFwjFP8rRcCAupT8YpSuEj0T3PX7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-0nPrqDWGMH-CodtW9dOuMg-1; Wed, 26 Jul 2023 05:40:53 -0400
X-MC-Unique: 0nPrqDWGMH-CodtW9dOuMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36142104458B;
	Wed, 26 Jul 2023 09:40:53 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21C23200B41D;
	Wed, 26 Jul 2023 09:40:51 +0000 (UTC)
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
	Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH V2 5/9] scsi: hisi: take blk_mq_max_nr_hw_queues() into account for calculating io vectors
Date: Wed, 26 Jul 2023 17:40:23 +0800
Message-Id: <20230726094027.535126-6-ming.lei@redhat.com>
In-Reply-To: <20230726094027.535126-1-ming.lei@redhat.com>
References: <20230726094027.535126-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_024056_458892_A3FAB279 
X-CRM114-Status: GOOD (  14.07  )
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

Cc: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 20e1607c6282..60d2301e7f9d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2550,6 +2550,9 @@ static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
 
 
 	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW - hisi_hba->iopoll_q_cnt;
+	if (hisi_hba->cq_nvecs > scsi_max_nr_hw_queues())
+		hisi_hba->cq_nvecs = scsi_max_nr_hw_queues();
+
 	shost->nr_hw_queues = hisi_hba->cq_nvecs + hisi_hba->iopoll_q_cnt;
 
 	return devm_add_action(&pdev->dev, hisi_sas_v3_free_vectors, pdev);
-- 
2.40.1


