Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D947CEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e8Vi7/i7yjgowd3xt9ePA02o8PSoNsR4xIIv0gxmnqY=; b=dKh66uQp/tkRckmHHtpANxG/br
	S8WF20UPhhLbPozVFkWr8ZFEk8PHmJIv6KmubIQKHb9bzUcJ4tNi8PazpqIwHXhPbWw7ck8/KFvnB
	9fPTi/wRZeWjEoRy0Rki8yv2PoVfrVT8hvKXPQOU9Ez96E+fIbDkZgTXmb2kGtGpikbQNVdsf0Cks
	tVBPvXbsoPswx4nvpDV6xmpQzp8R6Tek/EMGsspEm65DcGWCj44KA6ddw+hfQoK2l7F6PkQro1w4I
	idOawCb/vKy514nPMyaeMU/8xGLLCDiV42rVE8SXq7msVaDeujRF/VmXLm4oMAtuvZquit+d3KBAV
	ffZ1nz8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJsaq-002cDS-1q;
	Thu, 13 Jul 2023 09:26:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJsan-002cCS-1a
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 09:26:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689240391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e8Vi7/i7yjgowd3xt9ePA02o8PSoNsR4xIIv0gxmnqY=;
	b=V3z5RVCbCAsGr/6q2jYoBH/QAyL2CT0/egzYYPrK867q7idbq5xs3XjXov7POH2ZGrib0Q
	jGS2UHkbbmvG7LVdkanyh6bSMMCJHwmb4YJzfLS1KsDaGBZ87wOZAixDXYXofAIxc9XraC
	Az5hkVzt7Of1Tjtlb3pR2IPKq3Vm0e0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-uW05Q_6gN4iBgGeFF25lXw-1; Thu, 13 Jul 2023 05:26:28 -0400
X-MC-Unique: uW05Q_6gN4iBgGeFF25lXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2524893B780;
	Thu, 13 Jul 2023 09:26:28 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 311DA4CD0E6;
	Thu, 13 Jul 2023 09:26:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>
Subject: [PATCH] nvme-pci: fix DMA direction of unmapping integrity data
Date: Thu, 13 Jul 2023 17:26:20 +0800
Message-Id: <20230713092620.2076742-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_022633_600521_DB061B4F 
X-CRM114-Status: GOOD (  12.94  )
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

DMA direction should be taken in dma_unmap_page() for unmapping integrity
data.

Fix this DMA direction, and reported in Guangwu's test.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Fixes: 4aedb705437f ("nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cb13ba203956..88383371a5a4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -967,7 +967,7 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
+			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
 	}
 
 	if (blk_rq_nr_phys_segments(req))
-- 
2.40.1


