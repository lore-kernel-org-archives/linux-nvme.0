Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D611E7718A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 03:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=it8TC3omcvsc7cT+tTzeGuirDtUVOh2SOWzG+1+B1qo=; b=PcuC2eBGYIdTxRaL3UV5U9kloi
	clF834C2/X1AX2Vzf9RHDlpp6j8hwc164rpLcPJ9aGmcTSAl5tkKsAzeVOU+ggG5oLu5ur4L3rdsZ
	RAQ4pUIshfrF6WFv2oGPgKot3YOEGNMkjm6SO1PuVztuxd0Ddai3PUjck2UaX9L08jkUgLEAL27/j
	rbR41ltEVF+7BpEX18/qWZeSWtaTOugf0zzF4O2SepLCT/v4fTNMZZ7rMG98pEeyUcl2ENOunMzXz
	FfPWVroLbruTHi/uk7A1NUtjfwIijQgv2MTptMm0EJ6bcqoHlShzt2lkgPRs5LB/n+f2fzLBfDPFW
	q6Wju3Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU6A-00000003qAf-2DqF;
	Fri, 20 Dec 2024 03:54:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU68-00000003q7H-1jmZ
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 03:54:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F01155C6AD7;
	Fri, 20 Dec 2024 03:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BFCC4CED7;
	Fri, 20 Dec 2024 03:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666883;
	bh=Tq5lne9E79bYedkcTiQtblQgzJZr02APslo5sZaYcwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6Kb5F2tQNVNinwbOY9YB177gkPDJ2H8hfo4azdx8MRNgL2s/0BNRUNMjoWzJXtiM
	 rRjNgJF14U+dg+PWQ+dG0rDLXGLGX67egqEngOKPnDPdyFbEDOMpa51gS/bItb74r+
	 Xhsg+YD1rLXzE+HDZPalMkjVP3rE34Kasf5RhIAsQQjLExSKQ3Yk5MKNsz2/aLmaeX
	 FZlNDOv8VhEVU8CUC29qhPFpCSOcjvJ6utYpoE24J4bNbUrkh2sxrh+Ma5kc0iIjcY
	 wTfzUqn+WyX/eQ6VZxEWDMSF8eI3QorcBuwJXcZI+C3YQOCHChYMdbNbEyL5vM70+m
	 p4wOMFC98DwJg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 12/18] nvmet: Introduce get/set_feature controller operations
Date: Fri, 20 Dec 2024 12:54:35 +0900
Message-ID: <20241220035441.600193-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220035441.600193-1-dlemoal@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_195444_504151_6D5EF4A5 
X-CRM114-Status: UNSURE (   9.22  )
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

The implementation of some features cannot always be done generically by
the target core code. Arbitraion and IRQ coalescing features are
examples of such features: their implementation must be provided (at
least partially) by the target controller driver.

Introduce the set_feature() and get_feature() controller fabrics
operations (in struct nvmet_fabrics_ops) to allow supporting such
features.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/nvmet.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 86bb2852a63b..8325de3382ee 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -416,6 +416,10 @@ struct nvmet_fabrics_ops {
 	u16 (*create_cq)(struct nvmet_ctrl *ctrl, u16 cqid, u16 flags,
 			 u16 qsize, u64 prp1, u16 irq_vector);
 	u16 (*delete_cq)(struct nvmet_ctrl *ctrl, u16 cqid);
+	u16 (*set_feature)(const struct nvmet_ctrl *ctrl, u8 feat,
+			   void *feat_data);
+	u16 (*get_feature)(const struct nvmet_ctrl *ctrl, u8 feat,
+			   void *feat_data);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.47.1


