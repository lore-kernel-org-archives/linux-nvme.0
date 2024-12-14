Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9150CE77183
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Dec 2024 07:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=it8TC3omcvsc7cT+tTzeGuirDtUVOh2SOWzG+1+B1qo=; b=cYurXe64MpLcRHPbWJevIh96wC
	YunYTF5wnMBNgm3+QLr/D30X0hYwwJpTLHL5WCLo1uoCO57Aj490OKuwG35En6jUSXHoUx97azDLg
	ri7Hcd+egnqKpzA3a9TWn0wraDnZN1n+iS1U9zB5zlaxXa6ld1VbuxE4LgtgTtlE9VIPRgNQD5f1y
	7fgHKmeNb27ms0KKHDYIg+dycw9WUylSbrgeQC8MVDURVHNig93GG5vuHtevVr/rLCjieJjgrn5Gd
	9UQdWfvWJjHbfuNub33KQkNzHfWqP1o+Z20NwLG216IiW8UfHwEVgGtsHGceNhHqo7q/YE4ytsBVK
	ZeocpCJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMMNR-00000005tKU-3k6C;
	Sat, 14 Dec 2024 07:15:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLJY-00000005n8q-0OVT
	for linux-nvme@lists.infradead.org;
	Sat, 14 Dec 2024 06:07:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3FAC65C0523;
	Sat, 14 Dec 2024 06:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B90BC4CEDD;
	Sat, 14 Dec 2024 06:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734156463;
	bh=Tq5lne9E79bYedkcTiQtblQgzJZr02APslo5sZaYcwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENl+X2Cw9A0Pbl4nzgORL5GeWMerXdpcqhYf5VUJyncYwP/EgEG4jdPp4ETgLAo7T
	 +xhvL7PUSWikAS7O5Nx6hY6ERrzCA8PxjHUyICbvJmyFyBGlJYQfJJegQTLjxj75WV
	 HFOlSa7CNwNHBUlj4dU7OHJAQ3mHuX0u5YAxKzXz/PwqwfsNWQkes4iRMOSE/PHYvW
	 0fqofRL3bc+iyIpkZF41P8g5YhYS2CejYIah+0PJ8ZtQPUkYSvbEC/FWsqoLS8GgfQ
	 TKnzEH7Bw73oAXGcAPkUEpj2qn9ktSb7OnDF2TomS02f+Lo5pIBrBLQ8df9N/PuFcw
	 JCZ+/APUHdGfA==
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
Subject: [PATCH v5 12/18] nvmet: Introduce get/set_feature controller operations
Date: Sat, 14 Dec 2024 15:06:49 +0900
Message-ID: <20241214060655.166325-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214060655.166325-1-dlemoal@kernel.org>
References: <20241214060655.166325-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_220744_196586_C063C2FC 
X-CRM114-Status: UNSURE (   8.70  )
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


