Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827ECE77182
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 11:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z+/1O83Ca30ryr3UxtcmVoXzBbSLNXVVM33KxyKH5HU=; b=Wc/UvV3euSd8i45cbnaNK0Vu9F
	iulSnan/UlTM9zV2ApgHHFx4qec420qrBN7sIFDzitlzPKoRlmMc+boIH32pfb4CC/Uz8etgARo/v
	WTSqdhBMfLWSgJ9OwFHG7TT8cjN35wMHtT/wiXNeFqvBIacKHYHnpuc7oqEZVnNI6xtEOEBwjE2Bz
	gdL5lSmOSXThl3Av25Q9oPMrNcrl5mPLMBvSOFgl8wmycBgL36fXvF/FIxUqRMhjrGVYmxiyvuIzq
	Oey8GUbtTznLdHxNoSsd0UG7bGdpZX65XWOTChahOZSTUPwIUfACf8XuWDpLfbOHw6+YNkVDULahA
	y2E+EPRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhVQ-00000000Dl4-25ms;
	Thu, 12 Dec 2024 11:37:20 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhTR-00000000CuB-04lw
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 11:35:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0AE9CA42769;
	Thu, 12 Dec 2024 11:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8062C4CECE;
	Thu, 12 Dec 2024 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003316;
	bh=dZBG+7Cr8qW6187cdSEai55I2p24hR3EwtjXgP/1ONw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cctn3u4BAFt/PozMhGE5GKDcbt90Wd/QjYlE3Yp8P8uxDDDdjFQZSlAjOtkbV0rUT
	 T0ywfepox7xxy+EFwGO1GoOEu0N7ydBvOG9CoKlQgB+M8YIozJe6n7wuk3KdA0ZHc5
	 bJBx8sQJdMvbV40qKSeXXDjERk6e12+yiPR2QNhAJABmpBnpnHdBDcCZmixoyJFi8j
	 1xKo2Yve5sZGf4X+o4T5fc6tdv2BTq3cmkIVMjeMD0CFPDhftVCNMRB2j0Ktcgvj43
	 BWLyCKN3LyeWD1qZJK2+DVKZdE1W9CSvRvvO0v6WyzwVAqprhQsWl9v+7Z9/q3H2Pv
	 HWNNq9F0g2Srg==
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
Subject: [PATCH v4 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Thu, 12 Dec 2024 20:34:27 +0900
Message-ID: <20241212113440.352958-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212113440.352958-1-dlemoal@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_033517_121700_682D131D 
X-CRM114-Status: GOOD (  10.37  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
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


