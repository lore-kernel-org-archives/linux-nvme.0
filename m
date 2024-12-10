Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B30E77184
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 09:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AbXRJU9qTkbH67/TXs0oqMnHBc+pwE3hV9iu4xKlz3Q=; b=nJYdw0Ri7dEyCAXKKJvSgApf9h
	gBO0jCkWUft0x+lRcKuR1vnkoQMObwfMQ8Q0mvymJ+X6agLcsdjaNCecLGq9/JxewpnG2qiU1X48m
	23pfsqBxwXLuk8ou7+Wi/zI+7/oIn8hJSphbkDhtFmzWKTcuMGhYMEo4yM4Rm8d3TzrkS1Bviz6Wu
	f6RXEVqH7/XL1/H1DoBtV4iLytGM8bWGEO/MxYnKXWz3EcznDvkXU6+w71UtVSA6RzP91/2hTvmD2
	bSi+mdqgy15JuW7jaHSFdqS/Jp7OxaRWY8uvkviwuYhIkJfTcNxHzs6qR56HMAOvYysYboQAUwfTD
	/AOoSctA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwgm-0000000AvcM-3I5G;
	Tue, 10 Dec 2024 09:37:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwdi-0000000AuPG-0oSU
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 09:34:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 359995C5427;
	Tue, 10 Dec 2024 09:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81396C4CEE1;
	Tue, 10 Dec 2024 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823285;
	bh=fvnoQyhJzDikdPgkmR97fnyZzwgdUNiPmqC+qs3AwAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2ETE7vxPF4hk/KozYU3ufGaAtE0SWvZOA4aS1w3Yrp5JF08u/enOahC7F5Fur2Ko
	 dJkGOv/6QLvqlsBQ5yRyrFn5NzyWhHjskHbpmVDrPmkdQBfLYbUYPlQDNJV3+Fx3E0
	 cVNZr+MraDgvhfPoJOWpCeqgVCVcCGd/qcHL9HvAJmzmuqGApb5PkXqrS0NojXIq03
	 9rPsLyvKitf4IdR/yOvYNSEXGMyIfMzpIXotrn+zaCELV1TK7iGMCbAZArWQg+0aEH
	 CLGKROqFZGhgHAI2K5H2M55Jpyt8gO79Wdc1P/HyCZRI7WrUwMjubTa+nkXYp0LMP9
	 U29EuUQ9qR3dg==
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
Subject: [PATCH v3 04/17] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Tue, 10 Dec 2024 18:33:55 +0900
Message-ID: <20241210093408.105867-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_013446_274259_FAC83644 
X-CRM114-Status: UNSURE (   9.94  )
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

Allow a target driver to attach private data to a target controller by
adding the new field drvdata to struct nvmet_ctrl.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/nvmet.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e68f1927339c..abcc1f3828b7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -238,6 +238,8 @@ struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
 
+	void			*drvdata;
+
 	bool			reset_tbkas;
 
 	struct mutex		lock;
-- 
2.47.1


