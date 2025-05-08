Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D68EC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+rwDC5M1PX6Ze49fUMvoCsk3wyoowzREoL1w60rfEqw=; b=gYDmsnoEhydsjTkokdav6ST4Ve
	PfzEVQCvPrXfWzrojWMPalVR5S9KwKZHSfDUK5LCJwTN1dBW7rxjUbgRkwrkdvWwRHEXEjpLZvshO
	WluLlUfvHufgHb4M6InwQ5RYioZCYcWdhaFU4gnYoxDGAfCcjwpYmBTAOfde85KnoMsZi1ZXIQ0gH
	z1btKK9a/csGdLw9vi945tjtPEeNLS8mK2dpUF5Txx6q+7xjkgWr1X9fsQ67Ueh0V6BjbV+WubjLc
	gyf2+KYA1m5GeU53/UXI4nXNuJOLA0jDyFsIxaGlH7CEe2GJCPH4BQMYjfmre/PZTMErjSJU3fa9r
	7VHfA7kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD3KL-00000001A2p-22Jq;
	Thu, 08 May 2025 15:38:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD2gR-0000000110I-0n5s
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 14:57:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 569C244760;
	Thu,  8 May 2025 14:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC62C4CEE7;
	Thu,  8 May 2025 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746716230;
	bh=u6YIWCcbD2cIB6QfQaeiHH3AqkjJXoUcIqRzbWkTC0g=;
	h=From:Date:Subject:To:Cc:From;
	b=M3JeHbA7WL0AZvAuLwdhhsH9A30wuyatAY8Dj2R8jy7HrSxCP8h9tI2TscFSk963u
	 m9OhlUxtUeyfvRj7llu+WYCQlAx1305A/3dibeAXUV5ssuOK/PLKElGtp98WWHn+/7
	 ly5hYffqiRdY4IwREQ6h4/nEXYiO9+YTYdNqhBhjl6GVwliihArGVjbF0p5eTdOnRj
	 mGG5NujXfw02I2rRAlyamHqHyv/MnbUolysh3PU14zvxndRfKU67toVTX/1yZf9XdY
	 HKkFka9q4BIHYCmXmn/RSFYchE0NJ+Sozjk5eudUvNoC5JSWy8S/fCOcx1q2bxXxBL
	 p0LYaXZw7Nd7w==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 08 May 2025 16:57:06 +0200
Subject: [PATCH v2] nvme-pci: lock per namespace in nvme_poll_irqdisable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-nvme-pci-polling-v2-1-0c7e1edad476@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEHGHGgC/32NQQ7CIBBFr9LM2jEU0wCuvIfpAulIJ1YgYIim6
 d3FHsDle8l/f4VCmanAuVshU+XCMTSQhw7cbIMn5KkxSCEHMQiNoT4Jk2NMcVk4eLRaO6vETdn
 JQpulTHd+78nr2Hjm8or5sz/U/mf/xGqPPUpjyQhBypymy4NyoOUYs4dx27YvmWYQOLEAAAA=
X-Change-ID: 20250508-nvme-pci-polling-a88ca70b7ada
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_075711_265061_F615D1E4 
X-CRM114-Status: UNSURE (   9.28  )
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
Changes in v2:
- disable irq first, then take the lock
- Link to v1: https://patch.msgid.link/20250508-nvme-pci-polling-v1-1-29ae900e793d@kernel.org
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2e30e9be7408cba9dbb8918f066717b3a1c24010..c86af9e9211353d1713569c294899b0fde229020 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1202,7 +1202,9 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
 
 	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+	spin_lock(&nvmeq->cq_poll_lock);
 	nvme_poll_cq(nvmeq, NULL);
+	spin_unlock(&nvmeq->cq_poll_lock);
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 

---
base-commit: 0ea9b1f7aabb8af08649048d04fa3cee44dac4ab
change-id: 20250508-nvme-pci-polling-a88ca70b7ada

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


