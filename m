Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49E606A32E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b79rTviw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5GFzxx3iTCNJhbuSD/q+9umx6gML7ap63zvkg3Gu3uU=; b=b79rTviwSSxMl6BT+5X30PZwVS
	x6USLlLXbaBEkPExVtM3hzCZxxoiQxQyMXSZTatxfJZho94UYF2Q6ipki0yC05kqFXtHDGZuQz0PH
	DPmUJRDT+LqUwnD4b10RnvWNc/n4zKoB/prQAbEnwzxeMEEcQE3Xd09TfUYwyp3zVxU3JJ/F5wTXP
	KbMuWS8lJQH7Gu1D7P8bPb/siJjgoxPgqpY2PVF/w5ylxPXvDC97pVZw3uwh8pyhX5ZQlQgnPwAKp
	sPVVm3Zy+pFakTipv2ZZc0VNGBaGzzrWCYEiTZOcg38Q23eKEHbj5gbuBjpz7tCSbwFV3smi0ePZE
	l+bpq+fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdSB-00000005sHC-469w;
	Wed, 04 Nov 2026 16:03:11 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJqy-00000003UQd-01Lr
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:07:29 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jJykL0jZmz5B13Y;
	Wed, 04 Nov 2026 03:07:22 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A3J79Nf084249;
	Wed, 4 Nov 2026 03:07:09 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:14 +0800 (CST)
X-Zmail-TransId: 2afb6aea30e2942-d9e81
X-Mailer: Zmail v1.0
Message-ID: <20261104030714286L0-QmZfiJgl_w6jvQVKSm@zte.com.cn>
In-Reply-To: <20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn>
References: 20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn
Date: Wed, 4 Nov 2026 03:07:14 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gbnZtZXQ6IHBjaS1lcGY6IGNvbXBsZXRlIGZhaWxlZCByZWFkIGNvbW1hbmRzIGluc3RlYWQgb2Ygd2FpdGluZyBmb3JldmVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6A3J79Nf084249
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 03:07:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30EA.000/4jJykL0jZmz5B13Y
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_110728_193362_1EF45109 
X-CRM114-Status: GOOD (  11.14  )
X-Spam-Score: -4.2 (----)
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:03:11 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_pci_epf_queue_response() completes a command directly when its
status is non-zero, without calling complete(&iod->done).  For commands
that transfer data from the device to the host (DMA_TO_DEVICE),
nvmet_pci_epf_exec_iod_work() clears no_wait and waits for iod->done
after req->execute() has returned.  If such a command fails
synchronously, for example because the request length or SGL is invalid
or because the backend rejects the command, the work item waits forever
on iod->done while the completion path has already queued the iod for
the completion queue work, which eventually frees it: the waiter is left
on a freed completion and the SQ worker is stuck.

Only decide whether the work item has to wait from the data direction
and length, and let it complete the command after the wait even when the
command failed.  This preserves exactly one
nvmet_pci_epf_complete_iod() per command and also wakes the waiter for
failed read commands.

Fixes: 746d0ac5a07d ("nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a8df176c1a57..b12855b57b59 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1248,10 +1248,11 @@ static void nvmet_pci_epf_queue_response(struct nvmet_req *req)
 	iod->status = le16_to_cpu(req->cqe->status) >> 1;
 
 	/*
-	 * If the command failed or we have no data to transfer, complete the
-	 * command immediately.
+	 * If we have no data to transfer back to the host, complete the
+	 * command immediately.  Otherwise wake up the work item, which
+	 * transfers the data and completes the command even if it failed.
 	 */
-	if (iod->status || !iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
+	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
 		nvmet_pci_epf_complete_iod(iod);
 		return;
 	}
@@ -1659,7 +1660,7 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 	wait_for_completion(&iod->done);
 
 	if (iod->status != NVME_SC_SUCCESS)
-		return;
+		goto complete;
 
 	WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
 	nvmet_pci_epf_transfer_iod_data(iod);

