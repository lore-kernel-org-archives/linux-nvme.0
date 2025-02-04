Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32889C02193
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 23:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJVe67JRWk4bcEtE0wJxXkXG+iyqzbv5P3l6eWFvYfw=; b=ItVyJS/wyf/iWKAWGFGvxFknMK
	L79VcMNH/vQPKVY7/XmxUH29EMwy5Glm2o6NSF6RDmCXA20fD7NM7khhOvD7Z6NVX4R+xwNJ3ba0q
	h/qFTZxMCvLHRuaUYa/Tt1kL7nRRUOOycEeRttzMWK0b1XlgK/1cNCGZcF3do+u1nmPtBFgtpWmd6
	O6gk1IuoY+nRtoXEBksr+3/kFUGyEDRkK1Z1iMOgXtPIDgiPE3iKVnyLQnh1urzYnkKGuzqvpRq3e
	s20yzPQ+alglv2/8Dbgxm2gI0HKtktB+lkLBzUelC6Z+/rucgimykQUI5/BIQ0XVy5NGMzt0bZBJn
	2sY70bgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfSTS-00000001qNb-2CO5;
	Tue, 04 Feb 2025 23:36:58 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfSTP-00000001qLt-3ps1
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 23:36:57 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-216750b679eso97854135ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Feb 2025 15:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738712214; x=1739317014; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJVe67JRWk4bcEtE0wJxXkXG+iyqzbv5P3l6eWFvYfw=;
        b=QoKd5GtyzYGhx8Yqc32hksgGxavlNFFYY0jNMsmXGM1u30BeXvurU94vfoxSgaLokf
         ZPDGdAJMh3eAucL5zvLob3GaijcQcgG7u4nzdCNQI4TIZ0I9SJpjw6ruAkPRILmaHodM
         N8TGokJxyi/dlpPyb3tJbiFEc3JEyOiK+hUsXfKTaHWBMHIXEv3Dc2DfZSk9+5NroFnH
         ie8pI/3k8+rTc+Cw8FFJkihwxLqp7eWLQGWBH3T4qKpjMy0jnm+fZ2aKbyK7dFIY1X3v
         9oOJgJOVljWiOXLQa0XwfV1eRHUGmWzO/fp05kfdBhQCZugJjJwSzUCW/e94PjKMGQCE
         Orjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738712214; x=1739317014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJVe67JRWk4bcEtE0wJxXkXG+iyqzbv5P3l6eWFvYfw=;
        b=X9Onlw3aHkDzdS33zxP2K9jfL0gPa+bMv2E8U6FP2ELk4fq4xnST5giwJq86lD0iSt
         UnQ1vQ7vn7Pgqb844Js7RL+rcaS5rSQZAjc91vjYv/eURA/l6qxfHm3JPZCEfg2MPqGk
         Qgi83tkcTtTl8O8fdrdqNCYrWqpoV/J7SxvYlwhjkGjAmEkjqgo3vpwhzij1281QmH13
         TGlspFS5aqcxiZb6x0Pa28WnWLdbSxttxoGk47u4VikDfwzoqOQ/gRRzG1wjKnxMoXmA
         0CIx4op/5FYxExC+12Jl9ydrTQweoGgbtWS0rEDt/STJYzf1fDojd5sgpFo/OcYRdLOv
         +BDA==
X-Forwarded-Encrypted: i=1; AJvYcCVvZHZZSCKvBi95X0m2Y6cObasZzsKCRitIJGbuP15yk8C8rVj8qdcJRYViDH8hRRy5LQ4IjuZ1d2oE@lists.infradead.org
X-Gm-Message-State: AOJu0YxmZ4AAcsDf4Kf6SWzqolIQaqln3w/XkfjV3KyFH/ZmBqo9mVsP
	T7KjXpyZhMaBTnv7Vtfipe2UDrb5S5Rg8m50la64zYv75n/HrdCu0CAZ1yO5WE4QOynHZhCIPA=
	=
X-Google-Smtp-Source: AGHT+IHqNiTQFePPYYTwiCZWSt9I9UEe6Z4Xonv9HrbH6InazMe/EyQGOeXMZvMM6NFFgT9S95Z9rbiivw==
X-Received: from pgbcx10.prod.google.com ([2002:a05:6a02:220a:b0:a87:a3b9:db3d])
 (user=jxgao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f91:b0:1e1:a716:3157
 with SMTP id adf61e73a8af0-1ede883ba28mr948529637.17.1738712214499; Tue, 04
 Feb 2025 15:36:54 -0800 (PST)
Date: Tue,  4 Feb 2025 23:36:28 +0000
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Mime-Version: 1.0
References: <20250204233630.3407878-1-jxgao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204233630.3407878-2-jxgao@google.com>
Subject: [RFC PATCH 1/3] add full_buffer_write flag to struct device_dma_parameters
From: Jianxiong Gao <jxgao@google.com>
To: Keith Busch <kbusch@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ryan Afranji <afranji@google.com>, 
	linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
	Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_153655_951417_F9E41282 
X-CRM114-Status: GOOD (  15.68  )
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

When devices write to a buffer, some devices are guaranteed to
overwrite the entire buffer. These devices may benefit from such
behaviors by reducing the need to pre-condition the original
buffer. For example when bouncing data through swiotlb, the buffer
is forced to be synced before the device writes to it. For devices
that we know for sure overwrites the entire buffer, this flag can
be utilized to eliminate the extra copy on every IO bounced
through the swiotlb.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 80a5b3268986..003007ad6ad3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -460,6 +460,7 @@ struct device_dma_parameters {
 	 * a low level driver may set these to teach IOMMU code about
 	 * sg limitations.
 	 */
+	bool full_buffer_write;
 	unsigned int max_segment_size;
 	unsigned int min_align_mask;
 	unsigned long segment_boundary_mask;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..e93b909865d3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -513,6 +513,21 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 	return dma_set_mask_and_coherent(dev, mask);
 }
 
+static inline bool dma_is_full_buffer_write(struct device *dev)
+{
+	if (dev->dma_parms)
+		return dev->dma_parms->full_buffer_write;
+	return false;
+}
+
+static inline int dma_set_full_buffer_write(struct device *dev, bool full_buffer_write)
+{
+	if (WARN_ON_ONCE(!dev->dma_parms))
+		return -EIO;
+	dev->dma_parms->full_buffer_write = full_buffer_write;
+	return 0;
+}
+
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->max_segment_size)
-- 
2.48.1.362.g079036d154-goog


