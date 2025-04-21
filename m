Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B189DC369AB
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMEgWb5Zpf4MCf6w3ykJFs0Ob9U5wFpE+oGVVEOi8uc=; b=empmZTNqfD2FKX/FkScRzCz08c
	UwRwxcZNZew1eNDHx1zr56IouZeQrthz1uSOVj9n3JdhM4ZqOPXSFTbTYiD9BsNljp9JD4Ob8djmC
	pMrbIJcMR8LxX1uH2Ln9Fw53LfkQu/2YkO/sNGAgrCD/tjpZ+6uJDmmvAg9ybZH6GPon3UX42wqSV
	fe8x2vJfCd6SfoJfaRYRVzzUVTRtcxpKlxmnTbYwqUe9NpdMp//giuzblD7F5EYC1Cs/VLCyU6k6m
	HfK9UCPkv/I9UwO6HEScgazL3TjUj0/sQIaz0MbM651aq2KgUrfSrsXrmDqXnFAQwh9Xfe2EEFrlA
	JpbPgThQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6uR3-00000004mcJ-1cZY;
	Mon, 21 Apr 2025 16:55:57 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6uR0-00000004mbU-11Hr
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 16:55:55 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-223fd44daf8so8604445ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745254553; x=1745859353; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMEgWb5Zpf4MCf6w3ykJFs0Ob9U5wFpE+oGVVEOi8uc=;
        b=ecLFs8d4xLuCbDFHz+92D2yPnNTjFSH3Yl0MN3fG/uvqYnwnyXwF+rFqfwRQN02QAp
         0m1BfQjiPR0QfI35WNkbDagb3+F5CmYQlNQvXKlt+/3b+MxtJNkfkcnOBfHDHsiJk82D
         PdeZXdXApwyEYg7oCC2qE+Aq1ZrcWpE26DVKIKPEAYQvNI/IvNAND68384KnlALsCdoW
         2PZveal35YGrZsOYHmhVoQezvoksO6XGoCYVJ6VB/lBww7UlGW8pr56vw+jtf0hhN9CD
         EjUFJd2Wn4NMNUY+VX5imk63GHE8lbjELfQ2DHDAOUKtsh2hwL7xAScTuJrkhMbZGwlo
         EBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745254553; x=1745859353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMEgWb5Zpf4MCf6w3ykJFs0Ob9U5wFpE+oGVVEOi8uc=;
        b=gtUtgO1MwoBc0yQ/0a5S/uldyJ9BUsha8Sj8Yrv5sQHB8sybYg33drjT2/7mJ3UPaD
         rOV40AcpGY1CiaRTjFQkNfxV8ScAPMqqrqzGOzomg4kCtvRKqjANfNtLeDCatVXlfclH
         mr+xxo90Z7Cwns6sITnkRzIG961nRI022zGbBfTfJniGWt7t6+xKfryNTTLGKg0xOK1W
         DEEQtcicrELZB6iO5akUUmYcBuKMpb8mEzNZ0GqcShqv2HufZpaCCixwYmQrO9g49UYA
         IBgdj73SMNt+zUIO7Qcy/uXaFG63jfR+CEeWM/SeWx/hDmu88RrkHBqOhS/nqp3PqYt9
         /MgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2fGYwbZ2CWfjl+MZ1lbk9yRIt07TCYW33O5SXTPrASLB2tgRY1ZhxlJq5OtZXk0CB8Oj7dtbspTXg@lists.infradead.org
X-Gm-Message-State: AOJu0YwVF9S7s6y0qlJXOJTPTcJcOA2LOQe7oAaeOKWxd5P9pSrO4ank
	HqorBg5bMZWI2IMm38KbnRGPV7nT8Cog+DYOK587qjT9ROr4WTNID2tMphQ1hjm1LO28JYod6QQ
	AHmTAVUrmxpp3OdyTdkfa+nWWfiCzG4GW
X-Gm-Gg: ASbGncuBh91CUhCSAw2HsORaICpT9MPMOB5vm4cmvaD0TlnRQArUTah11SgwYMMpXke
	kidGpjrP+vjiqn+AS3DsLgWfn5fd2pSb92fLO69vZheNjx7Dx2dKOH/H0DE4Lfif2MkeWSIB6pe
	mPjnut6F6RywKNingmZIYRE4toj2dmxMcOAv8HbsRQplp3KQGFnPLfT7RoSSkraogpjo9PQe5gL
	e+Zdv6gBVTtNUFSOpswug6Lczx1yLhPpE1ragBdw+9gJczr6ZfWMSVoyRt2JXqejqB0G1l2Zi4o
	i82x4O5XNFNJjObMiYU9fsRqonREycqE02qEMtOUgJtj
X-Google-Smtp-Source: AGHT+IEtnQbE0lKY4qlJspwVfxkPFz2/gOrPkE/mbdSfxR4HhHAAe9jfFIEZfKONBd7m1NYuLvIjpOYLcRVS
X-Received: by 2002:a17:903:2d0:b0:22a:bbea:6ab8 with SMTP id d9443c01a7336-22c53622bb9mr71534915ad.12.1745254553330;
        Mon, 21 Apr 2025 09:55:53 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22c50cf1ebdsm3798865ad.60.2025.04.21.09.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:55:53 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9CEEE3406E9;
	Mon, 21 Apr 2025 10:55:52 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9AEACE4151A; Mon, 21 Apr 2025 10:55:52 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 1/2] nvme/pci: factor out nvme_init_hctx() helper
Date: Mon, 21 Apr 2025 10:55:24 -0600
Message-ID: <20250421165525.1618434-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250421165525.1618434-1-csander@purestorage.com>
References: <20250421165525.1618434-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_095554_273182_5CEE55AA 
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


