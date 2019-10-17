Return-Path: <SRS0=aIMh=YK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8616C4CECE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 07:40:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA99820820
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 07:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lMMYFMbE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuUb1axD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA99820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=CCaWO2w3JZw3TsQbYeoIiQmztwjXuAjafT4QVk8BIkI=; b=lMM
	YFMbEHabdMkI3ftNuYOgt12PJIBWjWagb9VNNwVtQgOLv4eDESSRBeCD3jKO2bZJAi5zcfq9Wl3eR
	Fy76jf3Ehb8BwmdJe5D4vxnPlY4pVPRqHt9r+N6s6Mt9GF2y9Sv/9j9VTBs9a7/6D8kgNl0FASpMK
	bsjxTQNQZzX1Jk/xi5SGj9Wyk5RFb9m5PdKhVKAXBya9ODx++S98yO7Kpg7V5cxZedK7rouQPJgr+
	4awN5TglVj2u+W75JqZQ9uPuXYQu6tR4qMOFk2g7DuJOm04ujsCZOZ9aemTX8Yq9y5Ue14Y+Pudte
	dM5ds80EqvUHSuEVLyJyp2ZFGAayI5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iL0Ov-0006Bk-9P; Thu, 17 Oct 2019 07:40:49 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iL0Os-0006Az-JV
 for linux-nvme@lists.infradead.org; Thu, 17 Oct 2019 07:40:47 +0000
Received: by mail-pg1-x541.google.com with SMTP id e13so830678pga.7
 for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2019 00:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TAfFhgzDCoU5lkYQdqSKhcSBVe3MOzX8jH2WnEQxIxM=;
 b=kuUb1axDaiGvKaP/79WC7GlOQ5m9WUpDSPfrQdsFLmz1w84U7uw5ppiG8hn/fDjtIw
 Mre7087OOIrUO1xAZUKhj/JalUMelPUm6ISY5+zZBVBzl8TOyKsvGKOl6/FaGPXqyhLc
 kaOdfHNVuvERd7ELmho6lmhC9A04cobW8s7oRENJQzGtRbO1SMeZxXT4B7W+kAQBEc5F
 rZA43+5gggTyZIjCvBj4c4XsOG14nZY29lB6mBJj1/i+26e9DlW/w+43ZHs6R1V2en8E
 qiaNoOf3xDbh94GwiNVbyeW1A9s4mNnz/8NwhtMxrVTf1Z5vh2M89MrCkjYVmlBnLE9b
 J5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TAfFhgzDCoU5lkYQdqSKhcSBVe3MOzX8jH2WnEQxIxM=;
 b=bj5ZaLyTDb9FhD6hTL8VDhIoTEAOMsbqNOriRy6Cr3tPdfecV9NAPouO1XFJ6LuEcs
 NHoK3yXwHmwL7ri4Sd5FqZL18K5qVBNhQuB0B4F77ucDk7Z8tqtfSEVnMZkqbLpFBbPE
 hve8sXPW1IL1k9TX7flC5C41HGaGu/A0HF7BLK0j2jc/8q3a54hpGs5oGbrDWqL2B5jw
 9+WyFTKd4Vr6eame6cSmXGtfRZvr/vmSe2KMzD1bwJY5/RDUhrAF6UTI2sErHVYnQ3Nn
 AQEzQuxtQjvKv0p2mviiFKHWg02T/0LVQe/1vm/DfoRZWw8zKuhXhRI3ymi3J8FpQ3u/
 rrWQ==
X-Gm-Message-State: APjAAAV8EWbT3go7Rh1X1ick4evIlL4PH//bxxAe5wozEdQhDNcHrXrH
 2bZyREQKEVvh6kaN9bv8DOAjs5lyin8=
X-Google-Smtp-Source: APXvYqwGDL9S8OA1zC7KOX/zEyn6p0E9xpx8NogSJisTGnx7ZOZFUWmqERv7tuD2Ph43PNuL3FLA1A==
X-Received: by 2002:a17:90a:1aa4:: with SMTP id
 p33mr2595178pjp.59.1571298044916; 
 Thu, 17 Oct 2019 00:40:44 -0700 (PDT)
Received: from pek-lpggp6.wrs.com (unknown-103-217.windriver.com.
 [147.11.103.217])
 by smtp.gmail.com with ESMTPSA id q20sm2250788pfl.79.2019.10.17.00.40.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Oct 2019 00:40:43 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: Set the prp2 correctly when using more than 4k page
Date: Thu, 17 Oct 2019 15:34:28 +0800
Message-Id: <20191017073428.46155-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.14.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191017_004046_667137_A956B085 
X-CRM114-Status: GOOD (  13.41  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the current code, the nvme is using a fixed 4k PRP entry size,
but if the kernel use a page size which is more than 4k, we should
consider the situation that the bv_offset may be larger than the
dev->ctrl.page_size. Otherwise we may miss setting the prp2 and then
cause the command can't be executed correctly.

Fixes: dff824b2aadb ("nvme-pci: optimize mapping of small single segment requests")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb88681f4dc3..fa647608c907 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -773,7 +773,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 		struct bio_vec *bv)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	unsigned int first_prp_len = dev->ctrl.page_size - bv->bv_offset;
+	unsigned int offset = bv->bv_offset % dev->ctrl.page_size;
+	unsigned int first_prp_len = dev->ctrl.page_size - offset;
 
 	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
-- 
2.14.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
