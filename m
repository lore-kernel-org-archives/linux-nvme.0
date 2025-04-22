Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0531C369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z3tB0h9RksPJEIyvjsBpowsXLr2+CyDhWSQ1RmiUmY8=; b=ceaqNSPWIUk/ikT6OH1IoBWpGb
	MTxqFKlW1hUtNh8Co5/68e/cwcq9jwuVugoIj+fRB3C/DyrG9MFIItHry2zSz72/ehaDTPvfAJSfC
	opfSNo21R5H0NvywjtTk4UvLZsxQbzmYlidw6TIaKpSAu3BMMlcjmF3I27rYPj3y/6meUhwK9xqTy
	qTrf0QT5TZv+b+0dHLX3GQEI6jBM4LfT/VpmhxIdBaTU9FbjnKMkGJwx8qzugyF9bbPhPGGPzQUi5
	k//kiIDTtWs3AyI7mW35VXyz1cQit9vLzPHu/RRdLcsl7QMNVEi3bIJE+jnUU7gOJr6MaOXIGF89Q
	9zJyoWCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7IQz-00000008Ang-3yz3;
	Tue, 22 Apr 2025 18:33:29 +0000
Received: from mail-io1-xd63.google.com ([2607:f8b0:4864:20::d63])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GM2-00000007sbK-2C08
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 16:20:15 +0000
Received: by mail-io1-xd63.google.com with SMTP id ca18e2360f4ac-85dce1987e5so16054539f.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745338813; x=1745943613; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3tB0h9RksPJEIyvjsBpowsXLr2+CyDhWSQ1RmiUmY8=;
        b=gTwgKxcn/1ZNXjdXcR7Z4NmIE21SnURG4sTXsSzW6solfyr7ofkNDwzFkyV8ujDgWF
         iA57e9wOuprkQeMxAHlLQApHWMbmTijcXqWlDZUlAS9uGCScbM4dC+N78f1HVDNhlrX0
         qrqilaJO/0Pl+HVC5thP/ss0KllgLih55aPb8S/bL5WinjS8QLPGzrl/FuO23q2l3fBJ
         3C8h7V0eaGlsBulr00iLOIGeIiCfBvKMrWRJopyOAXeTqi8L9/CN0ayEsXEFclmB/9uG
         ZNDNm4GWySijeMvZVlV8ljcU4klIGc0smk+8qJ1DGZGZniaO/XsVJzp2Klw1LWmLWzue
         7ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338813; x=1745943613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3tB0h9RksPJEIyvjsBpowsXLr2+CyDhWSQ1RmiUmY8=;
        b=R39EljEuhBf7paNYm7AbvnYPEh9NpBPs+8KAFk2N9igJbH+v2U2Wks3oYggUFvGgSX
         Lg8ktJ17ga8e5DmiJdYz/o4TwdOPnnucuk5MYHb9OHuCP2G0u2DZXyCTBK8PxfZJ1XBy
         YLqnfMtxZeAy0Hl1ogJqNtlnKM9ldm+YEMa0Ypghp9/zlmTKB4QJTCxK+iHitnMgjdvw
         2DY1340WiyrJr5UPsPomyuPmw2nyejcp1DdvpEJj3GmsOnf7HjwmkJ9v/bBy9o8gJpJu
         trsT1dJE1rgnPVkBwMQBs2lc0WpXmSpdFlQXh5UK6HJThlioCPguwC9x7SDbY0m2Ym/v
         B2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAtJp9Cb6ozlg3DcmJyaoPtjYDZWxa4+GsKmL/SjP09K4P2ek9N0e9Zg0o65ltDNhc/IjgNtRnj3QR@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/sBzCASSB8mdhprB6asVMOB75KFB4mPO1LTo1EjIztZ6ItuLe
	a2uKcc1Ji7x9Is6vUDyGJ9l+w0P5+/TrqVY4CGJukCwBnyfhNcevYwPzU+ROchop1BcqfGvPTU1
	MeEvUT5/zNvcvQsTZeoUgHK9wDImfLpo9
X-Gm-Gg: ASbGnctBK+oC8V3UMgEb/0UR0Ax8JoWBXqxRwm9B5M1zZzJQBOo+ZjntoL9VK5R/lbE
	N3IW3DfczvSJSYKngFnHt5F/kwDXiRgBdXFmBMRxRokjjJc7wIawaPvmOCQjor1p7eBuB87+AZv
	HPF1FKmpz3wFGysrKUQfAvNY5rudomL6NhJOG578vZL2jzBLUnEPjFWsdZo66QayGt/bcx0fjR2
	YTnc1My+VTQs5E530up7GHHumoGNKt8aKtXV/n7Y+q9LDbQDm0BJT0DrXaSVWoNZWlkM7h0IjId
	FLcil2Q89ngcD35R2dJvxRQB2f8Uiou7uK8L92xgHhSc
X-Google-Smtp-Source: AGHT+IFOuBh78/Arra/8VT8CFCwZ10+p/3FjWjMAdwvGeQ6A51CGkqMAbb3nYKQwFscJ/2uEL6kvG5FRiJiU
X-Received: by 2002:a05:6602:150d:b0:85a:fe80:cdd1 with SMTP id ca18e2360f4ac-861dbc66cccmr448575239f.0.1745338813592;
        Tue, 22 Apr 2025 09:20:13 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-861d9603fe4sm39101339f.2.2025.04.22.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:20:13 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F2964340363;
	Tue, 22 Apr 2025 10:20:12 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EFFB3E41D06; Tue, 22 Apr 2025 10:20:12 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 1/2] nvme/pci: factor out nvme_init_hctx() helper
Date: Tue, 22 Apr 2025 10:19:58 -0600
Message-ID: <20250422161959.1958205-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250422161959.1958205-1-csander@purestorage.com>
References: <20250422161959.1958205-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_092014_558526_FE641A2F 
X-CRM114-Status: GOOD (  14.28  )
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

nvme_init_hctx() and nvme_admin_init_hctx() are very similar. In
preparation for adding more logic, factor out a nvme_init_hctx() helper.
Rename the old nvme_init_hctx() to nvme_io_init_hctx().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b..642890ddada5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -395,32 +395,33 @@ static int nvme_pci_npages_prp(void)
 	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
 	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
 }
 
-static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-				unsigned int hctx_idx)
+static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data, unsigned qid)
 {
 	struct nvme_dev *dev = to_nvme_dev(data);
-	struct nvme_queue *nvmeq = &dev->queues[0];
-
-	WARN_ON(hctx_idx != 0);
-	WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
+	struct nvme_queue *nvmeq = &dev->queues[qid];
+	struct blk_mq_tags *tags;
 
+	tags = qid ? dev->tagset.tags[qid - 1] : dev->admin_tagset.tags[0];
+	WARN_ON(tags != hctx->tags);
 	hctx->driver_data = nvmeq;
 	return 0;
 }
 
-static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-			  unsigned int hctx_idx)
+static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+				unsigned int hctx_idx)
 {
-	struct nvme_dev *dev = to_nvme_dev(data);
-	struct nvme_queue *nvmeq = &dev->queues[hctx_idx + 1];
+	WARN_ON(hctx_idx != 0);
+	return nvme_init_hctx(hctx, data, 0);
+}
 
-	WARN_ON(dev->tagset.tags[hctx_idx] != hctx->tags);
-	hctx->driver_data = nvmeq;
-	return 0;
+static int nvme_io_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+			     unsigned int hctx_idx)
+{
+	return nvme_init_hctx(hctx, data, hctx_idx + 1);
 }
 
 static int nvme_pci_init_request(struct blk_mq_tag_set *set,
 		struct request *req, unsigned int hctx_idx,
 		unsigned int numa_node)
@@ -1813,11 +1814,11 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
-	.init_hctx	= nvme_init_hctx,
+	.init_hctx	= nvme_io_init_hctx,
 	.init_request	= nvme_pci_init_request,
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
 };
-- 
2.45.2


