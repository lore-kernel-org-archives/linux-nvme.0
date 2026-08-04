Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC5EC55838
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 02:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0awXeF/gF88O8qDwUznvq70IwYmiWUT+LyVuwyr0H/Q=; b=MRgBpbjtLmTjNGvSpaE217URXq
	Xy92g1drPDE24eKDy2idXZ0GnssnF59BJZa+PXk2iZjbod8Re94cBtX6mVEfE3HOyGAiDDQTL0bsx
	PUOQVinXsgHz8IuC52EaDF/guM5pVsT5v1Jh5eaZhuGx5HtLolaNxXdDJ26Kjegzdfi8SG+3CeSlO
	ITkmEZiEr/t9p1a22PsJEy62QRC6F9XRYtFNPPeARRO44fOmrHczZa7kZilsE/1dz1aL+7O96QXiN
	Fc57MEEY6K8VjD8J0pJLn0SsuEApeXiNnaTNTYVF6NWU+ZdPKpwZ6nGYNZ8p3UaU08ubNKXB+zw+q
	Uu0UVLEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr4kR-00000000pMf-333n;
	Tue, 04 Aug 2026 02:19:19 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr4kM-00000000pJB-14Ny
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 02:19:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785809949; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0awXeF/gF88O8qDwUznvq70IwYmiWUT+LyVuwyr0H/Q=;
	b=s64DZoMApuilxBAvOi92qYzMKlcNlnJt6APBxEDn3OEn3bJnaOLkqSGWNdgKTX9LEZNIOBhDmnwQUh7JV8bUeJVttnAftluqHyOoxATKcj7yx98Z7VXGzys8rvACLRlcfkL5PWTKLozX2ptsOO7GiShym/DHU3VjXwbLvlOm1xo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8MDIyv_1785809948;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8MDIyv_1785809948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 10:19:09 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	nilay@linux.ibm.com,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 3/5] nvme-pci: release descriptor pools on probe failure
Date: Tue,  4 Aug 2026 10:18:59 +0800
Message-ID: <20260804021901.3777326-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260804021901.3777326-1-kanie@linux.alibaba.com>
References: <20260804021901.3777326-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_191915_214234_955E0FDB 
X-CRM114-Status: UNSURE (   9.61  )
X-CRM114-Notice: Please train this message.
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

The per-NUMA-node descriptor DMA pools are created lazily from
nvme_init_hctx_common() once the admin tag set is allocated, but they are
only destroyed in nvme_remove() via nvme_release_descriptor_pools(). Any
probe failure after the admin tag set has been allocated unwinds through
the out_disable label and nvme_pci_free_ctrl(), neither of which releases
the pools, leaking the dma_pool objects.

Release the descriptor pools in the out_disable error path. It must not
be added to nvme_pci_free_ctrl(), as that would double-free against
nvme_remove() on the normal teardown path.

Fixes: d977506f8863 ("nvme-pci: make PRP list DMA pools per-NUMA-node")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b53..f1b24a53aa02 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3838,6 +3838,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
+	nvme_release_descriptor_pools(dev);
 out_release_iod_mempool:
 	mempool_destroy(dev->dmavec_mempool);
 out_dev_unmap:
-- 
2.43.7


