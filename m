Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AB1C83027
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nP/keTBNc/O0C5wVNNia0UrfzNdX2jAeR1fDwRug/i4=; b=0IaslP0RVuSpihOEbYXSIC/UzQ
	SJyRpQPFqajPQMbRQcYLqLqTb0ONXqiibQsBfhLN4yPOVthW3nWGGZfkYw5awTOWOQncsDDpyKX1e
	IOvzYxbP3EI+kmfrt3V7Jd+tkwHneCf1cCVrvnmwvy7qClnh88fDNtIKTU0GSeuG5OdCPxm3qvQ8r
	c0iPaZo1aipIXCCdvEsGuX8r3qhzafcncAuetjTw4L/C30Zq5fOighQpS6454H3RQZP7f74RiaNKN
	EZZaiQhIeXa5gkx01F/1LmbOe4E5wIdqfDkJ4X8CErKbFwQpsePoFlJSjYhcW67okniT1osZbHrjn
	dmvJKqow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAvA-0000000F4H7-2w1f;
	Fri, 27 Jun 2025 15:23:20 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhk-0000000F0zU-11uT
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:29 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-ae0d935020eso378123266b.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036967; x=1751641767; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP/keTBNc/O0C5wVNNia0UrfzNdX2jAeR1fDwRug/i4=;
        b=j4rZ7cqCJvl6ndz2pyyG4sRdHbJ0GvMpY699UxUsmL6waEAwt2nxryi8KE0tCM12IJ
         MG1Je63c3+BrpjukFUikKLG7+JHQPLp6Y3C6dkkySr1xwqP9VpUA+qEOqLdPH/uUn24u
         dKMzS48QAtvkK4EUcavAs/4V4hggqar7pnjr7UNRBERrVQ8tuycUJg90ICc9qLOeHilB
         KtQxGIfos3kTmyNXOqENk+2EmL/aaLJtO+Hjnv699oJPxJYhev6jOwCKv0nra7L52q10
         oMXpBLxrDB81VracKyf+NNabVgzB2GVZX6YfXVB6x/jLsk4GqXBiH+sZ0cTz7uTkgiTd
         Xwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036967; x=1751641767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nP/keTBNc/O0C5wVNNia0UrfzNdX2jAeR1fDwRug/i4=;
        b=MEfaUwlKquJWTLnlfEgi7xh/ebP9dNTv7DTpOFuI0iWg+oqoUJV2o26ybObeye337L
         bpxDFm4GRtgxVAMKqdfZnN3uPrxpteR/u3+Dy7jnNWvx5c0i7tq3MBEqE0JGsripaM34
         4jwcK590fvO4KHGRPOdpWIPbKPly/v+3KYnrDmqavzKwVE7VKP+XUxrjWBaXFHzq6iV+
         GjU07T84LM0MQCHeWnkp0t4QX3cuFfUp6z4SP00SzX/s0UVzfDdPr+8SWBUqkhUmDqZb
         FPd1Xm2lD24WJiqzAdgk+ZJvGfzJ+JilZl0/iQ2VK+k/MVzvuXqbPusP0mjumoKMu7tu
         LIhg==
X-Forwarded-Encrypted: i=1; AJvYcCUWOx+siQEkBFwNNFha1c8TFqOkM6rkR9fWBvlPEJXLZKKxHViant8doXRNY5dF+MdiIOwOefAKJ4Ge@lists.infradead.org
X-Gm-Message-State: AOJu0YwXDxtVrwpcLLQeooKe/OaNovLMnSJ9hip2uIxUqDasV5VVdFwa
	X9Hi5t+VeuO5wQfilSVvnP2ZOdfXCA4k1mdJuUuC976TH4l3xZd/WpXH
X-Gm-Gg: ASbGncv6IHbmgM5AxPMpR2ICzB6ZUHFLaheZDe4SYqbVDww9CoSTIsw+tZ2X2yKZ+tV
	wLt4zh+nAeSbOkCECSBtgsncC77+yUmMGtH6zj74ZCCexv4bC2YzI9LASfHn4tgS4e8qhPkvP0O
	VXYoEwRCOj79i9x8yv7ckY/nnAcw2AXcsqMYEfgXovQp/ba3sgvyOzyvmStlqjLPdx77wYJKQbc
	FIjsJRfgbPuMHwEFsw1nw6N8+dMvo9Ep1ENwCAqWOhBOjI9GIu2i/v5tRn+d77FqY8bWWFox4TI
	G5uVAPSho2epRRjeH0KsUczCNJs6TGbbcM/drmVrb/hHgkiP+PhjKxhGWKSOXCAtFGIlT4whz7U
	U
X-Google-Smtp-Source: AGHT+IGeQPxp7NHdA/JBf+pRqn8DJa3rDWFqYT7jpmKVfeIg6XCHEueu+grIlnzt9pADDCFo4kqA6Q==
X-Received: by 2002:a17:906:794e:b0:ae3:4f57:2110 with SMTP id a640c23a62f3a-ae35017b2cfmr334573366b.54.1751036966119;
        Fri, 27 Jun 2025 08:09:26 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:25 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 05/12] block: implement ->get_dma_device callback
Date: Fri, 27 Jun 2025 16:10:32 +0100
Message-ID: <25992680f704b6e92bd8c96e86cd143895fa03c2.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751035820.git.asml.silence@gmail.com>
References: <cover.1751035820.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080928_300640_6C2863DA 
X-CRM114-Status: GOOD (  11.72  )
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

Implement the ->get_dma_device callback for block files by forwarding it
to drivers via a new blk-mq ops callback.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bdev.c           | 11 +++++++++++
 block/fops.c           |  1 +
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  2 ++
 4 files changed, 16 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..28850cc0125c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -61,6 +61,17 @@ struct block_device *file_bdev(struct file *bdev_file)
 }
 EXPORT_SYMBOL(file_bdev);
 
+struct device *block_get_dma_device(struct file *file)
+{
+	struct request_queue *q = bdev_get_queue(file_bdev(file));
+
+	if (!(file->f_flags & O_DIRECT))
+		return ERR_PTR(-EINVAL);
+	if (q->mq_ops && q->mq_ops->get_dma_device)
+		return q->mq_ops->get_dma_device(q);
+	return ERR_PTR(-EINVAL);
+}
+
 static void bdev_write_inode(struct block_device *bdev)
 {
 	struct inode *inode = BD_INODE(bdev);
diff --git a/block/fops.c b/block/fops.c
index 388acfe82b6c..cb22ffdec7ef 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -941,6 +941,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.get_dma_device = block_get_dma_device,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index de8c85a03bb7..1c878b9f5b4c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -656,6 +656,8 @@ struct blk_mq_ops {
 	 */
 	void (*map_queues)(struct blk_mq_tag_set *set);
 
+	struct device *(*get_dma_device)(struct request_queue *q);
+
 #ifdef CONFIG_BLK_DEBUG_FS
 	/**
 	 * @show_rq: Used by the debugfs implementation to show driver-specific
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a59880c809c7..54630e23a419 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1720,6 +1720,8 @@ struct block_device *file_bdev(struct file *bdev_file);
 bool disk_live(struct gendisk *disk);
 unsigned int block_size(struct block_device *bdev);
 
+struct device *block_get_dma_device(struct file *file);
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
-- 
2.49.0


