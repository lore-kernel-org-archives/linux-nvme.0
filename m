Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ECEC369AB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMEgWb5Zpf4MCf6w3ykJFs0Ob9U5wFpE+oGVVEOi8uc=; b=jKgebVjulYHeGvhDj/JnZkYBKZ
	XeHr5gHDZTKMB8dLj4KoQwyDg8q5OWX/5O7lbZK5jOaq3wE5ZmPomGRDPl9lvts+VphY9Gjf9CB1R
	c5lJHvAIAxqKxsx0NXukeNZius9HUhTz2Nd+QKyf/ishdj6weervt9EYHP7pzWTWp2QADzAAt7G6Z
	yR05rarZIRKabh9quBz7zNQnxyaGCnVt/A6n+JH7lj1svKpuKr8iJz5EvCSqtG5QVdP7n/rqhDHyh
	LUgkb5KZN/cBH7iYErfODgix/uP8660/lBdV1CHJ2K1drkKB603yvinWKPo93o8qFhrs46u0rYxIa
	so6obzPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6tpz-00000004eWF-1w9B;
	Mon, 21 Apr 2025 16:17:39 +0000
Received: from mail-pg1-x563.google.com ([2607:f8b0:4864:20::563])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6tpw-00000004eUU-28t6
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 16:17:38 +0000
Received: by mail-pg1-x563.google.com with SMTP id 41be03b00d2f7-b078bb16607so454093a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745252255; x=1745857055; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMEgWb5Zpf4MCf6w3ykJFs0Ob9U5wFpE+oGVVEOi8uc=;
        b=a1gJAPjyC7M0tTdjcJbulz5iDbhSpmABJYkkj2gKiBvZColKReh/cUmMyUfq0ZtDic
         9kXGghktJjI6JE6SvVamkEv+EYu00fRIz3ix8rtJwODbZd2bzrqlHlksazUAhTEyaASp
         ZZ//b2++1cog3kuVoR+yndcIOgwDmPiWWgjpfmTFdg20xa/uz/j4zHYrAcrynvMVKqUg
         UeDF5WHogS1fxx0BBZ5ra/gO5Y2RvJ1yueQJrpE2HZTpmS5HlFqnu7tG9jL5BU/VvmyH
         iZ+dadqZQqMyQhCL9E6ZUeBb/E7NA2N2GlEas2+nm6yyDVnSwh20Vvm7XeBS4Ysmcpwj
         JLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745252255; x=1745857055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMEgWb5Zpf4MCf6w3ykJFs0Ob9U5wFpE+oGVVEOi8uc=;
        b=DwSlnRQ9O7tquI9XzQF2+A1rWU1r5FJfcqggCptWcQQbbHK369+wJKyxw7MrKepFKz
         vikbTmfJPXLZc0n/hUDPynXJUp8tfcoQRfpaPsL4BT2pqtYTwTNoY9LBg/zztfOkrEyB
         cqusgQc0va1ru1GXOJzApFdrX9rg+QoUO83IjSHKEQjRgBHudFqz8m/uJ0OvfnX/SUSl
         JykRh2uIcwLCmuLVHStKSIFjARH1VUPYhoRCCGA8MPPT1L7YK2yNdNjhE4QunxMJ+h62
         qOpcfxgp+rH0lwWK9cD8rG/a+D6xfpcfs6FTSoqtSgmbNEohofzDyRacHpQJscs1Z5JK
         Nf7A==
X-Forwarded-Encrypted: i=1; AJvYcCXgaTLzYax6YirkTJrYw4uYuR/Q7PBC0zTyFK8jP9mnYee7yirUxUlaUi9XsIsgWrihC89VJbrdjkWb@lists.infradead.org
X-Gm-Message-State: AOJu0YyQCog44TDCqNOy6/yNZagxIiNc2y0dPOnkEfT3l/NC5UgpuQ0g
	adJRcbQVHT+tv6UybCqFbKV4MPS84TUJ5aknuy8XmOej60c7rFeaklXm/nB9MFZEIMRMpfhWTGw
	P7lIsMcprVS2IFqiDRJVm0XqXbPH5M45s
X-Gm-Gg: ASbGncsmAhcFGs1NtOG+KXq43nYy33JWaSEELwf9p9KQawdUweSjY2QEzRh1Iiyjdaj
	JiSXJfMLh9Sr6br8nfpQT6ussnYQtcYQSHZM14utJeg4g7DQv07S5+EucTSHXVmJqQj99dEbTxj
	TMeOvkNaTePbeeCwusDKzOgUhWJGaO903ufyEpA/AYvN0O5A64p3NG1ejMQFU3uNntbVQiM6yOg
	nng+5fmQzvbmzdL95Z8dox6QfyvUaxTStqVhuIrsXZNLCeGloAIA8Rz/srHu4hbcQYMIUkIgKVK
	jOlUY+ObMEg76632OXF2NB6THk6vdv0j1UClf+a19aWP
X-Google-Smtp-Source: AGHT+IE6loebWB1SWVve/qgKlrBiVTBt8NCR34+v7ti1HB8vnb5fZGntVJutHi+ayxKstwkEGksjiK0bSxi0
X-Received: by 2002:a17:90b:3e85:b0:301:1c11:aa7a with SMTP id 98e67ed59e1d1-3087bba8573mr6764330a91.3.1745252255440;
        Mon, 21 Apr 2025 09:17:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3087e05ee89sm472211a91.15.2025.04.21.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:17:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E961C3402B2;
	Mon, 21 Apr 2025 10:17:34 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E72EEE41856; Mon, 21 Apr 2025 10:17:34 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/2] nvme/pci: factor out nvme_init_hctx() helper
Date: Mon, 21 Apr 2025 10:17:24 -0600
Message-ID: <20250421161725.1610286-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250421161725.1610286-1-csander@purestorage.com>
References: <20250421161725.1610286-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_091736_587850_1021D2C1 
X-CRM114-Status: GOOD (  14.08  )
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


