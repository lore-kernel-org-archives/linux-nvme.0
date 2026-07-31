Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358C6C55167
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 03:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0awXeF/gF88O8qDwUznvq70IwYmiWUT+LyVuwyr0H/Q=; b=mOHBWNd/R5fHYi75LSmESv/SgL
	zw/K0bCh0U6zlJvHzQ8QRi8be+WoUND6QQcn/jhwhmd7qeXmV8oulEboZ989pSQqp/jiR/lrSy8ka
	qhtxDfgGQsEAylCuNXiG+L5850pOVG2t7f4k4Ek0i6yAU6SrRGtJkv6MX03ggIw2Kyhr3cX01k3AX
	1ohTkllql+iPbzAoqxq7Zmqjjpiis84IqmB84AiPEdFtbCaXBWgypUseh7pmCF0pGi2CfMuNU4WSl
	RcKARg6YUFAQUxosM4eJxaPoq97w2fqJ2cIiWrbP+tCvNES49E/T3YUyj89DHMjo+gP0FMxK9QOA6
	M0ltXLlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdno-0000000BfkJ-2et7;
	Fri, 31 Jul 2026 03:20:52 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdnh-0000000Bfen-00O3
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 03:20:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785468042; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0awXeF/gF88O8qDwUznvq70IwYmiWUT+LyVuwyr0H/Q=;
	b=jiEju7Vljfl7GByJO1ImwFyJAORD8c/I7kKYb/SEwNW5ZUlz1o0wRgP/WVwDgQvVnqGXPnSjPWU5DRB0YOrM92XxL29OVMrHxNUY6S1FjoUgzVeP+Gs5F6jdcUdDJDI5LoMDOvzrfrP5hR/8n1juZTJ/LXH8RZfNkCMyyIkAtUU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X86jPlz_1785468039;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86jPlz_1785468039 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 11:20:39 +0800
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
Subject: [PATCH v2 3/5] nvme-pci: release descriptor pools on probe failure
Date: Fri, 31 Jul 2026 11:20:29 +0800
Message-ID: <20260731032031.1090755-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260731032031.1090755-1-kanie@linux.alibaba.com>
References: <20260731032031.1090755-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_202045_184989_D1D729ED 
X-CRM114-Status: UNSURE (   9.62  )
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


