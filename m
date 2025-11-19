Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5222CEE35E
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 02:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gifhH+ouh+mmQPCG7Mlt+a64mECIBHFCW6GZClRn09k=; b=CmPcgm/zYA8BdqB9s5JXsC2dT+
	P5Hxg+l7wbnP337Nt9ds73NuOrspc5rpUiWvgxrlZo9MZLjfWMNdl/9wsQjxYtgiUwpjqf+GWGvcz
	c1/2vs6rCBOP0k/BiTBNisay5ksS600N80k3QC009SmtDNwGwNMhixT3CfN7PgjqqTnfF7iFuq6m+
	U81C+3s7EbdNfanWXPsdtEQ0mTBTOn/uHu7qdvXpNn2srYfnCWICLZgZBRy3Nk/zC56y0X+SSLNRo
	pQD8ouDJhDJYfbVOEbdI1j76Y9dr2esRabpNmsY/AYDg+NkWX9zzRHtuVcP1fP0BZgGYi21C2IPl3
	qrQMDbZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLXkq-00000001Nlg-25qn;
	Wed, 19 Nov 2025 02:17:08 +0000
Received: from mail-io1-xd64.google.com ([2607:f8b0:4864:20::d64])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLXkn-00000001Nkv-3BRw
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 02:17:07 +0000
Received: by mail-io1-xd64.google.com with SMTP id ca18e2360f4ac-949066a7ff4so15135539f.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Nov 2025 18:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763518624; x=1764123424; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gifhH+ouh+mmQPCG7Mlt+a64mECIBHFCW6GZClRn09k=;
        b=gMHHc/tYL0HIfg1+AZxlMdZ2UBx8xcURMkfM8OaPQp3PzDBcuWpfZiJxjgMjo3nthE
         tAxGpqfXcJOf1zuyCVg8qqPa7Xhw1R7+Snp9WNLyth8on2BjZYJbjH/u1jSqHHIK8soF
         RtipTsa4sG4K7bwlb0aQRJYOLtsHz5ifR+PJ53a5MwJ0pBA2xGNwyhH+2IeW5hJl6UUX
         jFnBgVpuTf2tBu4DLfhDNqmvPR7w/I/kDDoTBD+NvA9FEx55m/RS2AOBky3Mh6RQnMfs
         rtf51sy1bC/s5ziaoBBleupWW+wU4LCyoc34Awd+7KVM9xdXGl3oUmBVA+6D1leFVadK
         IC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763518624; x=1764123424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gifhH+ouh+mmQPCG7Mlt+a64mECIBHFCW6GZClRn09k=;
        b=n9DVxHIZHxnU9/yX2MufiHKBSDJV3sqsKgP8qWkRPEcaQfSOpF/i3rKJUemxeiXMZx
         47de5yIny8gx5AoYr8LBQmhRtfikCWjRxrD5y4nvXFnEZJBip1opF270y57asiFTWY2j
         O6qHhu1c8VIBP1wW4V14Wqp09DwA9vGMtQ+hNuygJVo5iwFtMl8zUoXsK1MV4JzYzqxj
         g56UNFfGqiAC2nysD0rMUSZtJmXtDR/SE7WYpnRzUESihUL+Y8AnimFNYYFPztFeooWE
         4q250KmmCcwezjRGHvdfblEgm6bF8j7Zum5IbuBdvWTqxh9Qsa3Ybx64tib0Q33ffm1e
         hyDg==
X-Forwarded-Encrypted: i=1; AJvYcCWtyFAuEWc8z0LqvNZMLshS4jMuiJmNg21FR3RS6s2wf/i4xP1nq5ndNQQaCM6VY0HIHSOg04VqPCOZ@lists.infradead.org
X-Gm-Message-State: AOJu0YxdhKJ1AQPdopCycNWZ7w2BP0XDrJhurFh/yTvIS3XYr1mEg43k
	nfwJXSawvzBM+jT3xkAJ10uC2FAi+O363wwPmJMCvPVTDtyFXooYMCZOwWxzP8JV9h12+KOHaoi
	HSLB23PojLDOAoCNTgfoKxFMu5WGaBM0GD9csckrQY6KWNIQ36jca
X-Gm-Gg: ASbGncvC9+wKkpVige6T3FHchXzx+qJhIXd724Hzq7S5CXxkH06DZALpISilpQT7mlq
	KKUkhnHesLGatyBHSNLfegYGpxw+vku19Uy613LdAmcl2EajnJcAde+ZbM2v/T5yIX5Oq6M+SHF
	MAgfnZArgEXIhPrypf9gR/MOTte2VIOEe2fF/9i3KGtUq7RDsdKZ4XvsxF2J8QyE2LAJprV4uSB
	ZPIwiCxJunzzlo1KmCQNcTeaAFCMMbuEJBN5kMRfKhiLc0CwGSVV7S2CGmAEg9x/yRD3ssQnX/A
	jXrwEumLsvvXJD4LdeQrHxl+XCFt6rtvvnk6dEstHhbwjF22pjl+GOi2BKUm7K/VzxdpSlX31lz
	axu1+4e8NCjc+fxqlxRqNNPyxkUw=
X-Google-Smtp-Source: AGHT+IGOR0ugmF8HlYOxXeeCF+7YKOfSX53SMdxQqW18SDQIzOnLaPZwyGP25uViKl+PqgVOUp+UmXSnNmS7
X-Received: by 2002:a05:6638:378f:b0:5b7:c10b:230d with SMTP id 8926c6da1cb9f-5b7fc7053a1mr2425426173.2.1763518624246;
        Tue, 18 Nov 2025 18:17:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b7bd246865sm1242893173.1.2025.11.18.18.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:17:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DB3A53400EA;
	Tue, 18 Nov 2025 19:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CE3A2E41A05; Tue, 18 Nov 2025 19:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: deduplicate empty request list checks in nvme_queue_rqs()
Date: Tue, 18 Nov 2025 19:17:00 -0700
Message-ID: <20251119021701.3165123-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_181705_830314_2F0B4940 
X-CRM114-Status: GOOD (  16.09  )
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

nvme_queue_rqs() checks that nvmeq is non-NULL before calling
nvme_submit_cmds() and nvme_submit_cmds() checks that submit_list is
non-empty before doing anything. A NULL nvmeq means no requests were
processed from the rqlist in nvme_queue_rqs() since the last call to
nvme_submit_cmds(), which implies submit_list is empty. So just check
that submit_list is non-empty before calling nvme_submit_cmds() and drop
the check for NULL nvmeq.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 15c12e6cba88..8b562563ef89 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1199,13 +1199,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *rqlist)
 {
 	struct request *req;
 
-	if (rq_list_empty(rqlist))
-		return;
-
 	spin_lock(&nvmeq->sq_lock);
 	while ((req = rq_list_pop(rqlist))) {
 		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		nvme_sq_copy_cmd(nvmeq, &iod->cmd);
@@ -1230,25 +1227,26 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 
 static void nvme_queue_rqs(struct rq_list *rqlist)
 {
 	struct rq_list submit_list = { };
 	struct rq_list requeue_list = { };
-	struct nvme_queue *nvmeq = NULL;
+	struct nvme_queue *nvmeq;
 	struct request *req;
 
 	while ((req = rq_list_pop(rqlist))) {
-		if (nvmeq && nvmeq != req->mq_hctx->driver_data)
+		if (!rq_list_empty(&submit_list) &&
+		    nvmeq != req->mq_hctx->driver_data)
 			nvme_submit_cmds(nvmeq, &submit_list);
 		nvmeq = req->mq_hctx->driver_data;
 
 		if (nvme_prep_rq_batch(nvmeq, req))
 			rq_list_add_tail(&submit_list, req);
 		else
 			rq_list_add_tail(&requeue_list, req);
 	}
 
-	if (nvmeq)
+	if (!rq_list_empty(&submit_list))
 		nvme_submit_cmds(nvmeq, &submit_list);
 	*rqlist = requeue_list;
 }
 
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
-- 
2.45.2


