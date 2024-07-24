Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9576C3DA61
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jul 2024 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0sf7M9oppzFrXiz37pajdVXERkZRu0Y5tggruBV2pig=; b=ryqqHrxWvwcg+sqMzHN7xBUFEJ
	t5PTkPqhPclTe6jqVSKiJ1+3jYVf4eNRguwpABzdd5nI66WWzgooSgSiB9Q7MZ6S5+cwBn0k1HMj0
	h1PF6lKVikW3M4EDqSwD5jg3zecI61CkW6s7yzxktCVXpqC0qz4mdB6XWBwoeukmVPZxEqVeUEYZ/
	TA6WoVpsantU0KiwEorGyS2snj/2z2ngYN8EqQdv8XNz+5LTMGJ6jU5yAi3XbZ175YB0PHytJm5Aq
	VG8lbVHjWJjtw4r47KPMjfRmXWhpYDyyqnPtTo8OxyRZ8Tlg6xGs+wc85mwZlpW706fT3U/IBWaht
	iUsZ7Y6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWZHO-0000000F6JW-1Jn5;
	Wed, 24 Jul 2024 10:31:30 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWZHJ-0000000F6Iw-3nBJ
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jul 2024 10:31:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 85AB6CE1005;
	Wed, 24 Jul 2024 10:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BC1C32782;
	Wed, 24 Jul 2024 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721817082;
	bh=oTEiypWgCfBrzn0eenLSvsKim3M9QkN5uZiMhaGWmT4=;
	h=From:To:Cc:Subject:Date:From;
	b=HCFw0WaHJuXuMUVjOgqhoM2ArhaW9vnZ4MAEwxWu8FLzRdTje2kB4andVY6bO7X5t
	 H17dNr5pY/9/b2GC//lBpFEiBIeNxYKGNoU/ZNVR8zt8VfrWcwxbI5eXvJAoNKVB0r
	 cZU5iY4Sj83M1hz4kFeB53wBTYYDtxuOHSV83OyYALotnhrA264OhqEPfGCObGGcUe
	 8u/KKLUh0IT6PD9KZX3Y6gWMpbpJJoIGSBZdqt4yPaAWhTzc76VAeyFCwiUMwbjA0m
	 BuyLWoS9RDKS9aJX9O4pQxP9FlN78yW8VyNuNZ7tAcRdrvOcV6Pm0gD2jxkVKU+noP
	 KsgXe+k3g6KJQ==
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: add missing condition check for existence of mapped data
Date: Wed, 24 Jul 2024 13:31:14 +0300
Message-ID: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_033126_139539_E5BC9844 
X-CRM114-Status: GOOD (  10.67  )
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

From: Leon Romanovsky <leonro@nvidia.com>

nvme_map_data() is called when request has physical segments, hence
the nvme_unmap_data() should have same condition to avoid dereference.

Fixes: 4aedb705437f ("nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65f..cdc0b25091e9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -863,7 +863,8 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	nvme_start_request(req);
 	return BLK_STS_OK;
 out_unmap_data:
-	nvme_unmap_data(dev, req);
+	if (blk_rq_nr_phys_segments(req))
+		nvme_unmap_data(dev, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
-- 
2.45.2


