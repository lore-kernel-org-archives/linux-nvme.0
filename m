Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2D3EB64DC
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jul 2023 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tIRaWqNd8CpFFc5HeNtFkuYRBNFE4Oe3YtPk/F8xiyA=; b=XyGi2uV1pwTCiRrqhiJMIPTSO5
	wq09wSKk4VtMNXuKzXDcQT5VdF7G9l6uFOTn8cph0fLgD8j+hdrc/viLZYngAONvcZPhgDm+d9D3V
	4bwfaszqPA/CXnXhNBVVkJGCblqdh/49x/YZ+dshy79p5Gro7zUdHtkGCQIMcdJwXBU0tdWz4vY8l
	4BtJ6NZBstf2o3mWk361KuCwi77bUkrs6I67DWy/1CtBVZDxzb226eQ4BgeTilGxl9nK0fmtf93kv
	eU5XaWjml6V+gE13zrA3D02ObB0MgWUTW9av3XqD220wVMHqU0EqTOfGVGkW6fl6PiISUzdY5T2rf
	9dlfK6aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qKOGA-0074KG-2N;
	Fri, 14 Jul 2023 19:15:22 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qKOG7-0074JU-2H
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jul 2023 19:15:20 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c29c283f5so1713267a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 14 Jul 2023 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689362117; x=1691954117;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tIRaWqNd8CpFFc5HeNtFkuYRBNFE4Oe3YtPk/F8xiyA=;
        b=ipJM850R8G3r1+3KBLZOIROyJCUjMU9of6KXkX93ZxqyymqzT/H6Tiq9wxD529EglC
         baBZ+5wLkD7wRXBiPJWXf8IGRY60Y2afL38H2CiOXbdbCqkBnbLuJ5jM5yRv8/PYgJJR
         SNO1zPb5Z0U8SbUAVK7pcQlZB07wynKEeHSxqRe5gAxLQcwDf+eXFe+vdzQrkDxD1cA3
         ZwkIcVzFgRaRok1O92gVNvWTwsO2JFE8xaU7YDqcjXqeSDankPXki3olflfv443eMR2k
         OiREuPEjpv/q6TtHCeNjGA8jaEXFcI++lpJWlL0G3lLCzZBIBq5beZMbDGK9KE/OcCcy
         fXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689362117; x=1691954117;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIRaWqNd8CpFFc5HeNtFkuYRBNFE4Oe3YtPk/F8xiyA=;
        b=T9AjFTpnJS/z2kb4wx9nfdPw6JdVTSZM00y1yXmmeuZ4gt7NJYkPF8noF85Jes83H0
         sWLKVpCrExtyudS5Bp/e+N+HMY04iMCmzBT0TmMcgF3lGplw4zik+HOjnPcPmjN6qtI0
         /nLhchfXU2t6lX4TB8Z162qXJf4FzIWbht6pKyv6yeXCqQRr2izRA6Q+lhQcbd4RLZSL
         /cpEvi9pd6vkTYkGJgzBJCqrefHi9UrRPd0CMXH/O4MVE5GaaGgDy2QmLFA7yZjFgB4Y
         WBRjC0A/TRGBCtBqYytL/YC3lW4iSLBZ2Pe0EqLZTEQTuRCQOVrgpsNSASXDJdqwnWuC
         PhPA==
X-Gm-Message-State: ABy/qLad79c4AaDqKKhxXWXyjwvUxcE9dVL6lOFTn347kN+DUrxfu98n
	d03U/iUNgp+0LZIH0UG0N3sagbb+1d5Lr5E=
X-Google-Smtp-Source: APBJJlGPwvId1hKvJGb4xXQWCBhwlHfd5BkrJuPcvfHbnRDhI60r6NrNnA2MAZaz8x5MiPoP2ygL7CA0f37uPew=
X-Received: from zhichuang-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:30fd])
 (user=zhichuang job=sendgmr) by 2002:a63:3d41:0:b0:557:9cc7:bc79 with SMTP id
 k62-20020a633d41000000b005579cc7bc79mr10364pga.7.1689362116807; Fri, 14 Jul
 2023 12:15:16 -0700 (PDT)
Date: Fri, 14 Jul 2023 12:14:51 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230714191451.2700625-1-zhichuang@google.com>
Subject: [PATCH] nvme: fix dma direction macro in dma_unmap_page
From: zhichuang@google.com
To: kbusch@kernel.org
Cc: hch@lst.de, axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	Zhichuang Sun <zhichuang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230714_121519_764455_DC83AE92 
X-CRM114-Status: GOOD (  13.79  )
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

From: Zhichuang Sun <zhichuang@google.com>

This patch fix a DMA related bug in the nvme driver,
which caused a surge of DMA errors. The DMA debug
subsystem complains:

"nvme device driver frees DMA memory with different direction
[mapped with DMA_FROM_DEVICE] [unmapped with DMA_BIDIRECTIONAL]"

It's caused by the wrong macro used in "dma_unmap_page()" to
specify the dma direction. It should use "rq_dma_dir(req)"
instead of "rq_data_dir(req)".

For map:
drivers/nvme/host/pci.c
nvme_queue_rq
  --> nvme_map_data
    --> nvme_map_metadata
      --> dma_map_bvec(dev->dev, rq_integrity_vec(req), rq_dma_dir(req), 0);
         --> dma_map_page_attrs(dev, (bv)->bv_page, (bv)->bv_offset, \
				 (bv)->bv_len, (dir), (attrs))

For unmap:
drivers/nvme/host/pci.c
nvme_pci_complete_rq
  --> dma_unmap_page(dev->dev, iod->meta_dma, \
		rq_integrity_vec(req)->bv_len, rq_data_dir(req));
    --> dma_unmap_page_attrs(dev, addr, len, dir, attrs)

For the same req, during map, the mapping direction is passed with
rq_dma_dir(req); during unmap, the mapping direction is passed with
rq_data_dir(req). rq_data_dir and rq_dma_dir interprate direction
differently, see definition below:

include/linux/blkdev.h
 #define rq_data_dir(rq)         (op_is_write(req_op(rq)) ? WRITE : READ)

 #define rq_dma_dir(rq) \
         (op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)

include/linux/kernel.h
 /* generic data direction definitions */
 #define READ                    0
 #define WRITE                   1

include/linux/dma-direction.h
 enum dma_data_direction {
         DMA_BIDIRECTIONAL = 0,
         DMA_TO_DEVICE = 1,
         DMA_FROM_DEVICE = 2,
         DMA_NONE = 3,
 };

As a result, for a read DMA req, during map, it is recorded as
DMA_FROM_DEVICE(2) with rq_dma_dir(rq), and during unmap, it is
unmapped as READ(0) with rq_data_dir, which will be interprated
as DMA_DMA_BIDIRECTIONAL(0), thus causing a mismatch during DMA
unmap, triggering false alarms of DMA bugs.

Signed-off-by: Zhichuang Sun <zhichuang@google.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72725729cb6c..7778f384293c 100644
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
2.41.0.255.g8b1d071c50-goog


