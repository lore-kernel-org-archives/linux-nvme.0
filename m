Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C5CCC6B15
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 07:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fi6i98rsnzRjLaE+pBgUUzL0LZaOxpHA+vPLz5+YMnI=; b=z50Ujg4wzt/z5MGoN/SDjpYjz7
	QF4PyhFIXKtkrh/rjBSM4E4kt0519zHExDOVLagXBr7XgNlnIVo1HmshsuxUZ/dG64tUpBnR2ISbp
	uXnxZFzwbNXUSX/pfJ9E66jkb28MglzGKhX7koeyJXl/Ag+EiNkQSKLvZz9c86RfM0Te7qv2lMSna
	wXrI4RR6lkwF6nxHoQ8DdERarUS6+mvhJoilg0P1jwf+Cahy4bUv0+m92VlsV1YlMmrBluOuCN+tG
	XgjaPAOpd+/ZQfBflJ/JQTyVY3eYjnB4gZn1I4vhgWdabdkOsi7kr+l918xhzOmcaJiwrpedM2u2I
	pAvyERdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8CWE-0000000H5pR-3Y2F;
	Thu, 02 Apr 2026 07:31:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8CWD-0000000H5pA-0DFI
	for linux-nvme@bombadil.infradead.org;
	Thu, 02 Apr 2026 07:31:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fi6i98rsnzRjLaE+pBgUUzL0LZaOxpHA+vPLz5+YMnI=; b=gkNy1XxlaGIV+oE3TfRKLY+fxe
	d6ojWzo2u145+HbaY2FIPGcuRwqObz/R+HXPTL3hsmC6avaiJSYvIFZ9GHl2FbhqQ0G+OZoDVhN7t
	GtLyYczdpy27ABgYvChTA97gZ1AvM5gmZcSwTpPvD2spf/nIfPt88PZ4NWAQjMyEmjnSjR8PjmDGG
	mVR18j3DlSDMey89mVheJyBZgdbguCOwpC98SUxDqiOOrw7qnh/KSDRhOOEbcNerh58lKijAchyfa
	iI0YitH9yo2Rgm+pgPKzDgLbpzyWRTaZnr9D8jug+T/3d/MQTGKEL2nk9NBTSoNrKuBbVPFUirLs3
	+k15kjtw==;
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8CVM-00000001x8F-0G8j
	for linux-nvme@lists.infradead.org;
	Thu, 02 Apr 2026 07:31:04 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-82cf084fe58so307842b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2026 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775115005; x=1775719805; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fi6i98rsnzRjLaE+pBgUUzL0LZaOxpHA+vPLz5+YMnI=;
        b=jCTTjnDzkqCP70j8e5T1tjCt+TPYw8mL9Gd5ula9NZtuapKMj56ZsPFafZvfF1f1d0
         IiS/7JdsQhjiqWxM0A+F14OjpPJEgoyFWgmH2jPqOkjgp33KEmSKnJfgRBdqYamyngCB
         jT7mPF0TSmcesrn2iB2s+RmA5HQuZy6qVh7AQ86ou1VlwowLF7zXL/Qvr6TkNzP6gqUj
         SuwTKeedU15nL0MdhwQU9HtB7r6Sm7y+MH27wcIpaVUH4kwR0b2fbOIoOtM3ObqWOrPs
         38FrPStyfTHxt1mZDH7fcBuJAKtibsCKPLOWWAbVZ+m5e3tK9wuin4BuO5VZUhh7Et9e
         IIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775115005; x=1775719805;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fi6i98rsnzRjLaE+pBgUUzL0LZaOxpHA+vPLz5+YMnI=;
        b=fftWZgY/KKyhxSsMRKu1HfhC1jigqlZTVKWjCa9hAniKmL+cc4UBlI/vu4Q1SbEFgK
         SAjt0YSAgIzPLG98POrcUv4ydMlW5Nk4wcXGa/56H80eQFPqcUCfJHWW7DQSbK74pOo+
         wS4R7snuYJTY9l5piAiKLklpht9RGtTykYU6Tw0wFo6Xl6zTa47T5gOga6h3jBaymPO7
         wKa+aQc01/OWseUa7Cz8p+yAdntPZmknRDq2Ic6X2RzCuNNhtehLrHaqlMiTtvTpFjyg
         HncxMc1S2GflRbyMmHiAgnqYBTo5/N96IND/zbTdhLM19a6Yj7B8EqVjh/ORJPlF2bdP
         lclQ==
X-Gm-Message-State: AOJu0YxZlwDTF36CdL3bSUPG9mEPgD6iyt2t9UfYBTk3fwUa4ZYCz2MH
	effz9EefQt0Hcu1Ql0lYJi8TBO8IPv/1PvuoQRuP4UojgUGylzd3K5eM0SeLXIltceDWXCMpB6D
	KC6mekDBxv4k/8lyAnhp42JZJ9g==
X-Received: from pfvb22.prod.google.com ([2002:a05:6a00:cd6:b0:82c:6863:427a])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d53:b0:82a:7ad8:75f2 with SMTP id d2e1a72fcca58-82cfbeb58d0mr2498752b3a.56.1775115004949;
 Thu, 02 Apr 2026 00:30:04 -0700 (PDT)
Date: Thu,  2 Apr 2026 07:30:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260402073001.2039625-1-shivajikant@google.com>
Subject: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA transport
From: Shivaji Kant <shivajikant@google.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_083034_811219_79BF7C2A 
X-CRM114-Status: GOOD (  12.01  )
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

Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
RDMA controller supports it.

This patch depends on the PCI P2PDMA support added in this
patch [1].

Suggested-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
[1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35c0822edb2d..09eefd7c3ff4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2189,6 +2189,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
+{
+	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
+
+	return ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
+}
+
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
@@ -2203,6 +2210,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address		= nvmf_get_address,
 	.stop_ctrl		= nvme_rdma_stop_ctrl,
 	.get_virt_boundary	= nvme_get_virt_boundary,
+	.supports_pci_p2pdma	= nvme_rdma_supports_pci_p2pdma,
 };
 
 /*
-- 
2.53.0.1185.g05d4b7b318-goog


