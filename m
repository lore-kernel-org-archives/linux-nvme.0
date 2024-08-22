Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470C2C52D7C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/FSttR6p2yucCC2C1ycZHoGqThcAXEf4kSal+8QkByQ=; b=P//GLLJS7BYGJXp8V5YkMOohC9
	umCqSASKsoyTy2JzXTwlA7yPcYvwBwyqrpUTnrgXsya0RcjFupjLA+op2nbNAsKNFeSSiBbvlZIb2
	58r57m5A7xtktxbmo/vw01SX3X2PlxfUL7AdSYhH0Sr39E/JzSH+kUM7/hfkIDDB6gkcKXnKpChYA
	99PE+D2zVZ4fTjunSDnQzVT/2pxBcURhPQ78gDUq80iV2bbAFnKoQu+oS2BVYoYFooDvU158phG70
	AJcFW7Pp79soP7K/XyhSav5eqKCecwUE8ru8k49077RmZLo2/B6aXa0WZZ2x0FHNqw70UJc8WFFGV
	h9L94ckA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCh2-0000000DyBb-3WyS;
	Thu, 22 Aug 2024 18:37:56 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCgx-0000000Dy6y-2Ecf
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 18:37:53 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-20227ba378eso10564855ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351870; x=1724956670; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FSttR6p2yucCC2C1ycZHoGqThcAXEf4kSal+8QkByQ=;
        b=MRDODlaVirX9FKFXbHGpnJjXuOADEPBqATbPXeEufEAP6NLtOO6NV+NyZliWnMfnUl
         9jkzG6MpUhO29waXZirAKmpPbw5XQvJPUTNTrBSbx0MNwrVOlXEo6BDQyc4ZdwdvR5X3
         i+AvfXAUnuVg/yyof+fwZnbLfY3TF0z1WbEmiYB+1TeY56h/Hc4lzjzS38rbmjEJuYIx
         RzK8cgE7dAs5ruKHLKwFfCO0/FXmsrpJrUoaZV8eu09n73NkbUdt8pLf4woyBzYP/Wan
         5T5S40SJ9vmDVmJK7xgGSgsNS7aX/KxDsv24KQ1+9K4bXqhWZCA/dOtVDJdkpkxst7GY
         Tw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351870; x=1724956670;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/FSttR6p2yucCC2C1ycZHoGqThcAXEf4kSal+8QkByQ=;
        b=JW2s30WF0+bsFb9f77oOyJq6whubrL6ff6aEGBD51Li8SfWOrar9+rb9Cy1iTXQ6gt
         Gvh19zgykxF/E2+Wo3eLDSfuviV+sVd10kADWPKM/qLD6KJ+NByiOJ5camEh0Zl9cvKX
         Sh3CHXHFu5DSSQqVVMF/tqLSv8CEc4A1kHQTMv5TxTEWx+TZRE2dJlmsgQ/Z/n5ngCCh
         x+hQ/T89NDK+XQcgEO8mP/Viy4jZNVrTbrzkED3DbNKGpk+f+jR9DuM7yhRh2rCa6gV8
         BLg1mw/XeCnYzn4DnxR1u5AYcUB8rNFf2V3LD+uZCj4+HQ/rulC1/XRiHajRXWYirPve
         0NXA==
X-Forwarded-Encrypted: i=1; AJvYcCVpFCPflRsxorOrC3oM9vqBhHQ29VdiqTbYFXelhCYMQAf0j9zghT/DzMyW2gcUjHWdjLGV6dXFQft9@lists.infradead.org
X-Gm-Message-State: AOJu0Yzzufnn3r1BOBq2K0c+davxsayjU+NbHtu+U0+mA/wh1EMyepEr
	/dV7+GNSg1rYdZ1mybDM1iZLc6lkfEcF3R13ZafB++lpOHRUxzwA
X-Google-Smtp-Source: AGHT+IG0xFiyyhUEAVqUeNP4awQwMQmb0ao3xlY9kk2g+DZ4RUL1iV7dvaFZrYLPjHsqT4Fbvb/IyA==
X-Received: by 2002:a17:902:ce85:b0:1fc:6740:3ce6 with SMTP id d9443c01a7336-2038822be0cmr36095425ad.20.1724351870494;
        Thu, 22 Aug 2024 11:37:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:50 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 4/7] scsi_lib_dma: Add _attrs variant of scsi_dma_map()
Date: Thu, 22 Aug 2024 11:37:15 -0700
Message-Id: <20240822183718.1234-5-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_113751_637879_AD38513C 
X-CRM114-Status: GOOD (  14.02  )
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
Reply-To: mhklinux@outlook.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Michael Kelley <mhklinux@outlook.com>

Extend the SCSI DMA mapping interfaces by adding the "_attrs" variant
of scsi_dma_map(). This variant allows passing DMA_ATTR_* values, such
as is needed to support swiotlb throttling. The existing scsi_dma_map()
interface is unchanged, so no incompatibilities are introduced.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/scsi_lib_dma.c | 13 +++++++------
 include/scsi/scsi_cmnd.h    |  7 +++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib_dma.c b/drivers/scsi/scsi_lib_dma.c
index 5723915275ad..34453a79be97 100644
--- a/drivers/scsi/scsi_lib_dma.c
+++ b/drivers/scsi/scsi_lib_dma.c
@@ -14,30 +14,31 @@
 #include <scsi/scsi_host.h>
 
 /**
- * scsi_dma_map - perform DMA mapping against command's sg lists
+ * scsi_dma_map_attrs - perform DMA mapping against command's sg lists
  * @cmd:	scsi command
+ * @attrs:	DMA attribute flags
  *
  * Returns the number of sg lists actually used, zero if the sg lists
  * is NULL, or -ENOMEM if the mapping failed.
  */
-int scsi_dma_map(struct scsi_cmnd *cmd)
+int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
 {
 	int nseg = 0;
 
 	if (scsi_sg_count(cmd)) {
 		struct device *dev = cmd->device->host->dma_dev;
 
-		nseg = dma_map_sg(dev, scsi_sglist(cmd), scsi_sg_count(cmd),
-				  cmd->sc_data_direction);
+		nseg = dma_map_sg_attrs(dev, scsi_sglist(cmd),
+			scsi_sg_count(cmd), cmd->sc_data_direction, attrs);
 		if (unlikely(!nseg))
 			return -ENOMEM;
 	}
 	return nseg;
 }
-EXPORT_SYMBOL(scsi_dma_map);
+EXPORT_SYMBOL(scsi_dma_map_attrs);
 
 /**
- * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map
+ * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map_attrs
  * @cmd:	scsi command
  */
 void scsi_dma_unmap(struct scsi_cmnd *cmd)
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 45c40d200154..6603003bc588 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -170,11 +170,14 @@ extern void scsi_kunmap_atomic_sg(void *virt);
 blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd);
 void scsi_free_sgtables(struct scsi_cmnd *cmd);
 
+#define scsi_dma_map(cmd) scsi_dma_map_attrs(cmd, 0)
+
 #ifdef CONFIG_SCSI_DMA
-extern int scsi_dma_map(struct scsi_cmnd *cmd);
+extern int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs);
 extern void scsi_dma_unmap(struct scsi_cmnd *cmd);
 #else /* !CONFIG_SCSI_DMA */
-static inline int scsi_dma_map(struct scsi_cmnd *cmd) { return -ENOSYS; }
+static inline int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
+						{ return -ENOSYS; }
 static inline void scsi_dma_unmap(struct scsi_cmnd *cmd) { }
 #endif /* !CONFIG_SCSI_DMA */
 
-- 
2.25.1


