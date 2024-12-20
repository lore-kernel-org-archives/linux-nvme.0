Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED08BE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z+/1O83Ca30ryr3UxtcmVoXzBbSLNXVVM33KxyKH5HU=; b=04ngWPU+PbOWyEoQ2bhAfWVpMb
	wuxg5qgoGG7llN10yuSLQsH/xvnx0MGcd9XVOhU6gWkj5VokY3iyeACgohr+l45VWIq+Xk8c5w0wP
	7gTHr5fdGypeq0lmiKLFyxK1SiXs1VZJDuD7xtz1tBx3j5uz08Ub3M1GFgJlb7bAd3gtBZMQIJc7H
	U2EU/iVMhAZgqsEV2+I+Cq6IChVCVH2jV6aYSdldMPwUOPFNrhh5K7qGd4Q6aYlSPSXX/e526mul6
	X3aA9lQ8HwKlUnwbci3zrbCjuqNPGRZrwZeL9oS5/Fn0MqCf8IHnlTUSj8CfmevZqRx4Dxh/toWhB
	op8UioYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZer-00000004TGZ-0ELx;
	Fri, 20 Dec 2024 09:50:57 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZeo-00000004TCz-25qt
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 09:50:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4EF33A417B0;
	Fri, 20 Dec 2024 09:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86061C4CEDC;
	Fri, 20 Dec 2024 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688253;
	bh=dZBG+7Cr8qW6187cdSEai55I2p24hR3EwtjXgP/1ONw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R16L8g74dHRMK4211FV984fyPJOdN+257lC0nBIYO5MtQYkcqE0EmE0w5nEXSPYOA
	 c4t4rb6CEdJd1t6OpwnK8MiQpV++JKclVFUJrC/2hOeNRSpLZc02d+lE+LLJ+qMC7i
	 634qYauS8oqqEAOocSmf3LWHWpkMJLtIbS/mbGAIZNukTgwGUYYa3vRD1w4QXnoupI
	 xKBuUcFVP+uZ1ykgXFNg3tRu5WvBHA9OB55HOOYSglrInjlrMfaNOmo5bSXMMpFv4a
	 0Ol0m7syB5vwHucuUsTWUlBSMjt4RhBcAK4DdZXfXqgshOaYCLPX7Hf+7BuX4ZE1k9
	 hQzA70c0vdcCg==
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
Subject: [PATCH v7 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Fri, 20 Dec 2024 18:50:55 +0900
Message-ID: <20241220095108.601914-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>
References: <20241220095108.601914-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_015054_621317_E909BE8B 
X-CRM114-Status: GOOD (  10.58  )
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


