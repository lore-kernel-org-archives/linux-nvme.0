Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8118AE77183
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 09:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YBay4ll/MbnOPw+iTpgxqxIfmMNAoMXitwGEFi7jv1E=; b=JsTu1qbmlDS4OO59UO0ESV3ock
	WF2nmauNbh3skhJe/Yb7E4016cU1b0QRZgwCwmyTUx0Zmt7OUhUIyEC6AwOw3ZzH7RycRlI4mCu4z
	kqbRzpGvAPD5kqdNLw6Rfzm/kE+2S+gyyoC2G4OJsAnkFfhGKjy1dCzNfSVhL/6/9eL5EO3lLY8ZC
	0tgUoC/zFqeHsgNa20MZFrnqTwBwHJq1OXeqVXsIqTNAiCYlWd3s/H6QthCwPYzR1nnuGKPcqehU6
	WBYYp+A/kG+brBGLirOb5ptMavgbrkcIXKrCJLv6rwc0QrRWWNmk7s6xsSXGa7AwHrxI80Y3vSf+J
	FpICrzgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwgv-0000000Avr8-2fhn;
	Tue, 10 Dec 2024 09:38:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwdy-0000000AuVZ-1ZTz
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 09:35:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 562485C4EED;
	Tue, 10 Dec 2024 09:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5B8C4CEE1;
	Tue, 10 Dec 2024 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823301;
	bh=NgeDYVmKLnPnEgYMTm8Gcflj4/a9LtgCkbnjnyI2o18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCM7L3EbQOWM4GitPXZBbCfMY4O1th/a3lqPnIR0RCeZ8oHvmyypM50v52BsE5TuX
	 0s1TVntRzAezPY0fNEt/IRVxgYVtFD/XauCYkAlWlzUCrSwd3ZYzq9kMa+XBN75P5H
	 /ByPDxc7zjQZNWNSOruEenTgt6kl8S95F+JLC3C3Lkd0BNhFqVYeC1Ips4KBUgMbZv
	 vv9AIpxUs86443bcPgiBJYJ1yf9fmdphwcd84w5rQzNEKVBe+b7LdIVLXS/Nxmcz4r
	 HoShfXiCa6qF7Ev8r5J5YcxYS4R3M0MUG0I3efpNIwm8yuCt6liBPrd7NCQksSUcGo
	 6Bs0ewqlaQS3g==
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
Subject: [PATCH v3 11/17] nvmet: Introduce get/set_feature controller operations
Date: Tue, 10 Dec 2024 18:34:02 +0900
Message-ID: <20241210093408.105867-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_013502_452926_ECAA597F 
X-CRM114-Status: UNSURE (   8.67  )
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


