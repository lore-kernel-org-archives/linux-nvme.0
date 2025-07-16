Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41153C83F27
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P2SOYl/XQMHOmwrX5JSsna52LJMbkh+N5xjV/ETx76A=; b=CGKrPv4ikKkBTRetmASVetUqH4
	O98MvxVgP5Wa+DX6iUWsu3gu2eW872ZZV1zjdsI+KjsZgI7o98PFqhutwaDDHEzAcjkN1RpsaLG4Z
	KsmAXcKqY9H8ttCgmADMkQvPpgmlQCd36EA/GpqD26ZfUyUTWSx9bKh6mnAPGeY45+ZC6iP4MeLr0
	vFVdZsV/lbLYneB8YSTJ+j76d523Ik9w6bmN5uOHd5j2Uqp8ckc7wzg09uv7WvqlnB3h+qAQ0rIN2
	pYvUoLbMWGlB0k9W2MAx9NdeqoGhHF6+USnRK4GRTETY6kD0Axr9P31KtIzed7kHxK2f/K6XzVfMX
	KvjGwRsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc0SC-00000007ZrG-14Qa;
	Wed, 16 Jul 2025 11:37:40 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc06V-00000007X1Q-0d6r
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 11:15:16 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so1277266466b.0
        for <linux-nvme@lists.infradead.org>; Wed, 16 Jul 2025 04:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752664513; x=1753269313; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2SOYl/XQMHOmwrX5JSsna52LJMbkh+N5xjV/ETx76A=;
        b=EyH99v06JlgwjuRYtyrDXxqzPXkKcOy8LBjYC/Or9cGvuhKyhK5dCojay7QqvQwFVo
         bAUa0E0EynZyFLAhq4xRjh3ts8gna3aNpqnHoQyo+bkJj1uRhRJUywZ5+bEgQmHIJPM0
         ZzR5kfuV2Yd7IxOtVXI1kaENp0G72xfC3MTm4dXIiRKbCL/Te7L/GVDIH/VQbZAxBVzM
         VjbPfyFu15adt3ZzJIKtszRdymG/7h1gFmWN/SB67R/Al9jYTFr16FvSsquV6+tpmp3R
         3KVahpTF8Nvwjr2FnQFNh6DA0S7wvuk+bStzDM5t9LzBdWIi5pgP6PZYq/5GhtCIEFCk
         Mg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664513; x=1753269313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2SOYl/XQMHOmwrX5JSsna52LJMbkh+N5xjV/ETx76A=;
        b=HqJTCbhkl2+wTL8kkjBqL5wWOpQawW2+DOoj+JByDrXAVh2kneUC5P9ZcU1/p34IzC
         APp2DeRNmnSTHrMLiB5MT2CTKB8fZreDbPBgUE7cpkKZ5fHKYIEi6yWnwEtw6VPHqSzm
         ZPJBCDtcKaLTFP0h3QWvyg+KK61HpvB+ePqVNzE/9jMFf7vXREYof6aewT1QArgCccuO
         wEhJvGm0fxlGTj14guVW3F1JzpNOlkZfq8pfm0NQqHOeF/XdcRZCZyxnaLP3DBl2pVNP
         GeiRCrJQQqrUMO4xt7o9kwx0wE25AVFivvic1BE2FDWBNBIBoMqHOXXpV6nEzOwlj7Cr
         Q83Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQa2btdueyPpfocd5xLuqGyAfCdZnkY0GsWTEkaJqI2tiP5UuYfQw9zW1AoTnX4xPByPebwzRt1EOI@lists.infradead.org
X-Gm-Message-State: AOJu0YwKyvcSmyHs8gdJNVe11uMypTZtpNDsfEVtzfHlKbNNFY9gWbFF
	NqJ7CrG2eyZwjFq9iWdtJLWXMcrO4RWAE1I8E3AKR2HunXUM2X2HTU/N
X-Gm-Gg: ASbGncvMVYBWN4kPYJuLpgAqoLG6epkaxiMugQs70OxPdK/zeOwjxhT5LHr0n8RIKuP
	LRprnHYmgHPaoTBEY0ZRZTBzUmRMgscFvO2Qs0+Mdbgn4cmvFUd92AMtRKNHoXSNq/YDtRzMQS0
	xO+qyU5Wwh0qTm8HHfzX1zOj6UI6m0bYi8YlEqHj/6rRToqmwyvM2OUPgOX16X/bATNVQQJB+vK
	PqOVcp43MkVgo3zP+61F9v1UwzqxBLBudZabaHBjykRNZi28cdfLQO48IsZGdyeU5eUZ0nlSnt/
	sVaeXyFnF5nXdeQEVCodHGmRZDI0aftaAROApB8HVZEpUgvtOR0MWafKOl8rSASMCNrORT5YYe7
	O3BtXqW/Q2mS4bAEnXh3M36mYJz0sr9sPnBEFINUKcv+oT96NktJhWZ+IyK8=
X-Google-Smtp-Source: AGHT+IHuaG9Q4KyyDlobEdm53aQS309RTLX1FnzlLthLLXD+3Rs1MJYH27z7J7Sc4zrPCnLs0uM4Hw==
X-Received: by 2002:a17:907:d847:b0:ae0:a1c2:262e with SMTP id a640c23a62f3a-ae9c9b3e228mr272402366b.50.1752664513185;
        Wed, 16 Jul 2025 04:15:13 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dee16sm1175217766b.152.2025.07.16.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:15:12 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails
Date: Wed, 16 Jul 2025 13:15:03 +0200
Message-Id: <20250716111503.26054-2-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
References: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_041515_189085_1B1E4766 
X-CRM114-Status: GOOD (  17.60  )
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
different from DMA_TO_DEVICE. This results in a double completion as
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
called in nvmet_pci_epf_exec_iod_work() leading to a double completion.
This not only sends two completions to the host but also corrupts the
state of the PCI NVMe target leading to kernel oops.

This patch lets nvmet_req_init() and req->execute() complete all failed
commands, and removes the double completion case in
nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
double completions occurred.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
---
 drivers/nvme/target/pci-epf.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a4295a5b8d28..9cd470938463 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1242,8 +1242,11 @@ static void nvmet_pci_epf_queue_response(struct nvmet_req *req)
 
 	iod->status = le16_to_cpu(req->cqe->status) >> 1;
 
-	/* If we have no data to transfer, directly complete the command. */
-	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
+	/*
+	 * If the command failed or we have no data to transfer, complete
+	 * the command immediately.
+	 */
+	if (iod->status || !iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
 		nvmet_pci_epf_complete_iod(iod);
 		return;
 	}
@@ -1604,8 +1607,13 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
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
@@ -1643,10 +1651,11 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 
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


