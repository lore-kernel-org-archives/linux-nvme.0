Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5CAE77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 05:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdnnriFRyPD4i0wLhVsD1v8b1D9FcPPPX7WJpCd4O74=; b=yqDzLHezYv1jCIR73pzRy7C8o/
	euKhxIXZ3o2Mq7fH1PJ3BPDez1CJqlU6JwlkTiTUqwfmY+9bPe1zGW+D5kOqft02FY3DW1LtGbFjd
	4Pc4YQYznoQddIKBZz92nHKQgexsp4220o13Wi8Xu/BVifWjOFz7sFmqig8JmjO0ZXRVkoJeizIUm
	W6v/rPyepW7EL7wV+3vw3+r+L6byyKPl/15H9R4PLpni8FZT2cGb9BFyTlek5jPwKwdxJRCmkgr2i
	5gi4V96ldITGM5ZFiZb5RwKyDY/UoBWhur9sWcejTNIgtd8z2J6LHhfUJSdWCNY9MiNOfRxEaSfT0
	M12gp2lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTwHL-0000000EU3g-2GFt;
	Sat, 04 Jan 2025 05:00:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTwHI-0000000ETwZ-2Sb3
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 05:00:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BF3665C2770;
	Sat,  4 Jan 2025 05:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADE6C4CEE1;
	Sat,  4 Jan 2025 05:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735966847;
	bh=p1XyrBL8a77sSRG6UZmdKw8GtdrJgme1YzapYAfDP6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwICOefWbti2TmMc6FSulKUFrMX8w5PXLrouq4FTuw0Z4sYHlShcbfH4F8Tco3+YY
	 m9Fe65xkVfWfGg+lcLJzJGvxj5bDVFoYmxBGTZzyWEytMwJbrBKOQ/k/4ezPThjvww
	 cPg1S4RbqkZis1fVLwtDLxHeFB3b/7TfvUdVSH9Mo9IL+qarO5Turt2iWr07PDh5kT
	 ZDFNeiR442vwkgwpWUR6nr6OQm8KZ9Ool+GxUdHmU9pvnItlj032xmkwpiGtLUY67x
	 +ZpovLmuJRlWMJB6xV33OPJyp6qKRKk+fpfrwut4ZowHWBFH1w4jX7L8WhVg0iBuPn
	 k8gG6RRL6BY5w==
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
Subject: [PATCH v9 12/18] nvmet: Introduce get/set_feature controller operations
Date: Sat,  4 Jan 2025 13:59:45 +0900
Message-ID: <20250104045951.157830-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104045951.157830-1-dlemoal@kernel.org>
References: <20250104045951.157830-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_210048_699710_783874E4 
X-CRM114-Status: UNSURE (   9.37  )
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


