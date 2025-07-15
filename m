Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A135C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 09:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+9C4SqxPPpyskVd6ert0bcYvhtym6+38fcjIR9tWwdk=; b=gqRgDuW8zjV2SdiNwQRtHKsKt5
	zfgTQAjpk09n5KZqPUgTeOEDg2ULHPR1C7Wlm5kR+MWa4olx064BUPbP0umT7tehvEq3qHfvi6C1U
	MqGhG20IEbYr0dvuWB9nDvwW4c7ZST/Ozv2did2OJxJR/PQ8OHRNnRy57VH6alP7N08bKb9HOBlBx
	cB6da6qxRpyza0KGqIz23Fa5yd1BrGhygJojKjD2wxtPTLZikKr89/6UtwNV7I9KlXF0FCntVlChR
	+cjSKxaKhuVJJHjJhMABFHS8AdmlxGHzBn34ub0/aQp4kR06phMj1Z/jlX9k8IPERySeQt71g1KgN
	/aZ472BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubcKo-00000004kuP-30uF;
	Tue, 15 Jul 2025 09:52:26 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubbo7-00000004eIU-2mmY
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 09:18:40 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-ae36e88a5daso1037964266b.1
        for <linux-nvme@lists.infradead.org>; Tue, 15 Jul 2025 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752571118; x=1753175918; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9C4SqxPPpyskVd6ert0bcYvhtym6+38fcjIR9tWwdk=;
        b=DW+XVHMgn6k6tOMnUygE5KRjNlx/4wN3fJuduzuaXP40YtgejQYRATR1EM52UOXf13
         IlMuyDmB2nC0fIYWdhSbu7pcbprtj27zjVEEZD/TMbt6XkrHLZGJTPHKhOEWASvh+s2f
         Ioh7U8BsKfbpb/oBZcf6mgUjd/qzgeuByWHGBiIYtuHKmVugHeDpVL2FM0KxUck7/9TG
         3v8+eBFq7FE0hATXRNOwJtk/KY3ftvZ8cfK7w9Q25qNpPyfDL388IhwodVBGRzesJlNa
         415GcpVzBM9BNuy5jEeGOGnm5FBBb4pKK5uXPCes4E7nOhsCx6OWXkSrYYLE4FQHBTHY
         Utkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571118; x=1753175918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9C4SqxPPpyskVd6ert0bcYvhtym6+38fcjIR9tWwdk=;
        b=hpySzjWEpOY9az9byWr7d0hBLst8/7j7WXW4bXgqlWu7i0dXYdkluvIM1uD8Rvfvid
         5fIN9tGI6Ggez/M3wOkkh+tmiWPyVPx+U63OUnwhi10eGc99JGdxGQytWoYMZr1FLdgV
         7ymYxxlzxMFAsW7WqOJ8Lz604eGEeSBP6b8mL8ybhGztQ2u/ISEyKkB1sjeB8ENAi7pS
         V5SKqyX8BSYbs6KnEfHoFnTP6lAgBTemn1gtedfTUXIAtqvcWOYKSyuZKwQh/z/DmEph
         4qSR8ojmgiq6rA3Q5p0Zzqy5x4iIczpFTWv2fVjceYd3pTK0okK5899d3txjTt7trfwb
         le9A==
X-Forwarded-Encrypted: i=1; AJvYcCUzRnAqVWtGHv5b6tH5Dw9lqCisVumDwkL7EXSPrL6ekBsqm79qz04s6YjQYu5EZQ9MwqqNKG1IgFSM@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5JTYlaP0CUPNOq797dgxXWuNu6qpotNlBDY6SUImueHVgQJaZ
	dXbpqUBNBR5rSh4Dt3ufcFAMKAkudbRjNRzSDV60SYrEbhiGQNz1GMzH
X-Gm-Gg: ASbGncva4Dz7ZAUvmPSQJcl6cQL8I4Cxrsdtp+/O23S9NuoSe46fmB8i/tX/diiEpcM
	MWlaNxaJxo1REvAewTsyjaBI5GL5Evk33wBYoF0Vi7ulXqf5tXQhItnXgnk2fPjLRp2i3YXNQUb
	hi7iKpHCnw3J9yIYiCdas8bQoqn8mQhskBNIOEluybZtFOXw9RfH9+EPtp+CQ2xmPaHcKrekL4K
	6lWMMaBwxfk4DBi31Hk+xYBD24GRsf+nQZoSSU5YTBiAw6A5IqevqlDS/tpYqGP4XGOa+g+0MRS
	mGmIL3DzZJbXO6N88NJRVvJji5v1CUNYILbT2L3r1m2qVGeLszU84yp6AmXqjZdfijVkCTJHELf
	4zQNawEGz3zE6uigVz/DMKHMZVka5xpAOzNXwfw3W6PjbP9sy
X-Google-Smtp-Source: AGHT+IF6yENuvCdGMmQcnjxY1sTGWjszAKx0f9Kx1Yo4wEy5CvAUJeELbK5qpL9ki6y5Wq0WZQ8Q/Q==
X-Received: by 2002:a17:906:fe0c:b0:ae3:5212:c906 with SMTP id a640c23a62f3a-ae6fbe13960mr1793783966b.10.1752571117363;
        Tue, 15 Jul 2025 02:18:37 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91bd0sm973213566b.33.2025.07.15.02.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:18:36 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails
Date: Tue, 15 Jul 2025 11:18:26 +0200
Message-Id: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_021839_722394_1D76DB81 
X-CRM114-Status: GOOD (  15.77  )
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

Have nvmet_req_init() and req->execute() complete failed commands.

Description of the problem:
nvmet_req_init() calls __nvmet_req_complete() internally upon failure,
e.g., unsupported opcode, which calls the "queue_response" callback,
this results in nvmet_pci_epf_queue_response() being called, which will
call nvmet_pci_epf_complete_iod() if data_len is 0 or if dma_dir is
different than DMA_TO_DEVICE. This results in a double completion as
nvmet_pci_epf_exec_iod_work() also calls nvmet_pci_epf_complete_iod()
when nvmet_req_init() fails.

Steps to reproduce:
On the host send a command with an unsupported opcode with nvme-cli,
For example the admin command "security receive"
$ sudo nvme security-recv /dev/nvme0n1 -n1 -x4096

This triggers a double completion as nvmet_req_init() fails and
nvmet_pci_epf_queue_response() is called, here iod->dma_dir is still
in the default state of "DMA_NONE" as set by default in
nvmet_pci_epf_alloc_iod(), so nvmet_pci_epf_complete_iod() is called.
Because nvmet_req_init() failed nvmet_pci_epf_complete_iod() is also
called in nvmet_pci_epf_exec_iod_work() leading to a doubple completion.

This patch lets nvmet_req_init() and req->execute() complete all failed
commands, and removes the double completion case in
nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
double completions occurred.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/pci-epf.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a4295a5b8d28..aad828eb72d6 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1243,7 +1243,7 @@ static void nvmet_pci_epf_queue_response(struct nvmet_req *req)
 	iod->status = le16_to_cpu(req->cqe->status) >> 1;
 
 	/* If we have no data to transfer, directly complete the command. */
-	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
+	if (iod->status || !iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
 		nvmet_pci_epf_complete_iod(iod);
 		return;
 	}
@@ -1604,8 +1604,13 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 		goto complete;
 	}
 
+	/*
+	 * If nvmet_req_init() fails (e.g., unsupported opcode) it will call
+	 * __nvmet_req_complete() internally which will call
+	 * nvmet_pci_epf_queue_response() and will complete the command directly.
+	 */
 	if (!nvmet_req_init(req, &iod->sq->nvme_sq, &nvmet_pci_epf_fabrics_ops))
-		goto complete;
+		return;
 
 	iod->data_len = nvmet_req_transfer_len(req);
 	if (iod->data_len) {
@@ -1643,10 +1648,11 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 
 	wait_for_completion(&iod->done);
 
-	if (iod->status == NVME_SC_SUCCESS) {
-		WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
-		nvmet_pci_epf_transfer_iod_data(iod);
-	}
+	if (iod->status != NVME_SC_SUCCESS)
+		return;
+
+	WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
+	nvmet_pci_epf_transfer_iod_data(iod);
 
 complete:
 	nvmet_pci_epf_complete_iod(iod);
-- 
2.25.1


