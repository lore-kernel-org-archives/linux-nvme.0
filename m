Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27316C3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0PZRW8Vsrd0CZaj4tR++ioZ3YZvz2qd/JHZOwrXz+Ko=; b=viWnhgZeB35EJr9aWFnmSqcGKJ
	NoE45thJ+/Cn01blNweSPV+GJoOzb+oCCk29wb3ux9pOrBBttsbdhDF/a+4ddUM1qP9ZZCs4QEQgX
	N2CbTVDruXCn9YdcEe2Zq9Dnn7b52xQqD2MT0sHuhHu/Tsm1d8kB8FiG/z/Ah5Fu14Fg9LVT8WyOd
	CeW6UE9M3racYvw/5dbNpHmQh4ewUzU9ObVN+9p41kMkociI6iw63Uv1PYL7ldCSPjTClxTZWGMp+
	9Q6JnEB/BefwJtDxxPMnJJRwkNqV8W1HPF5YfWzmX3tm/WsBhQBg9wa8wmUT5jv6E2j0a6APzJ0IZ
	cZsE3Vxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCzrA-00000000XQe-3Z8k;
	Thu, 08 May 2025 11:56:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCzr5-00000000XOv-0Dzf
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 11:56:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1BB2B5C629B;
	Thu,  8 May 2025 11:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E87C4CEE7;
	Thu,  8 May 2025 11:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746705358;
	bh=lDit1oyaFcxfGkC94lOoCNGwdvxZE9qyh5oj5Gw33QM=;
	h=From:Date:Subject:To:Cc:From;
	b=GMHgFSd8a3aYlAABrm6tK+X/J1Mi9f/vuCWwTXF+EiuEHzyOuPFqZqvvG16stIJxl
	 nDhFuNhaoy19U1xhoHTDpMq/jNsxSGydDbysM6672fQVPgMLi877b3m8mO27F1pYX3
	 WUOGUfOE/fAEyecnnkqeaJuxF3BqDVo6SMc8ox+eigQTu2/ke/KdoHdA9EB44tntaj
	 TXbfAFZPSK+VG7AL8K9B/rS3nerq3eHbp8Wfm2f6TqV1tcERZ6soYnGYEVbyuf8udN
	 hgS0Yz9T/KkX7yKxpY9FQYB/hAg+H6KtVW1OTgErXQbKh5aCqPcJrJGe6QSXx+o6B4
	 JuzOetiSLHfQA==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 08 May 2025 13:55:55 +0200
Subject: [PATCH] nvme-pci: lock per namespace in nvme_poll_irqdisable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-nvme-pci-polling-v1-1-29ae900e793d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMqbHGgC/x3MQQqAIBBA0avIrBswQZKuEi0mm2qgTBQiEO+et
 HyL/wtkTsIZRlUg8SNZ7tDQdwr8QWFnlLUZjDZWW+0wPBdj9ILxPk8JO5Jznga9DLQStCwm3uT
 9l9Nc6wdj+zVMYgAAAA==
X-Change-ID: 20250508-nvme-pci-polling-a88ca70b7ada
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_045559_152526_A82C2A88 
X-CRM114-Status: UNSURE (   9.51  )
X-CRM114-Notice: Please train this message.
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

From: Keith Busch <kbusch@kernel.org>

We need to lock this queue for that condition because the timeout work
executes per-namespace.

Reported-by: Hannes Reinecke <hare@kernel.org>
Closes: https://lore.kernel.org/all/20240902130728.1999-1-hare@kernel.org/
Fixes: a0fa9647a54e ("NVMe: add blk polling support")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Keith, I hope this is okay. I picked up your patch and added your SoB. As
mentioned in the thread, this fixed the problem reported by our customer.
And yes, it is a muliti-namespace controller.
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2e30e9be7408cba9dbb8918f066717b3a1c24010..b07ee427c311d508a95ab730c0b875f21fe5cc43 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1201,9 +1201,11 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 
 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
 
+	spin_lock(&nvmeq->cq_poll_lock);
 	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 	nvme_poll_cq(nvmeq, NULL);
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+	spin_unlock(&nvmeq->cq_poll_lock);
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)

---
base-commit: 0ea9b1f7aabb8af08649048d04fa3cee44dac4ab
change-id: 20250508-nvme-pci-polling-a88ca70b7ada

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


