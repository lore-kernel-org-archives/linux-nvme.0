Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EFFE7716A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Dec 2024 06:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z+/1O83Ca30ryr3UxtcmVoXzBbSLNXVVM33KxyKH5HU=; b=D85clARnFsLGa56hpleZO8xMM/
	ItEYc02qZZ9/pB2Ih1K6YAcawYv2RZdUPs+mWYz1HZ403VgqMHAZ4/3RUgBL34QnPC3WaU6LB6Tsi
	TSaaoGMl0rTmIvxQ9rgp7XMnUJSMBrWEcBFLEU1XvkJ3Vl3oLlo1g7bB5gzEMiYr1DvrWqzwllHIt
	TCSNrniIJWkEkcxZ5E19WtUTaOxYrt0ilWG5L5eUYbCInbKTbtAyfKi/PdjSssWo46eGuoTKq7CTl
	B5UOihKQJLnBmtm6VqXNQR8JuchwmmxH6SI5l3SqQEkeQxxr/BY6hvmoTVcDHqzyPIIsxYtGOHIoQ
	xD4xiYLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLJL-00000005mqm-1Ww3;
	Sat, 14 Dec 2024 06:07:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLJI-00000005mmk-1rMz
	for linux-nvme@lists.infradead.org;
	Sat, 14 Dec 2024 06:07:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A16085C057C;
	Sat, 14 Dec 2024 06:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A997EC4CED6;
	Sat, 14 Dec 2024 06:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734156447;
	bh=dZBG+7Cr8qW6187cdSEai55I2p24hR3EwtjXgP/1ONw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QsZImcU2CZCw/VhAjBlCqwBqvEYgFjBIXuN4GBggYoqrdTCHLZbOQs5knUniih1Py
	 S6B+hLqdQxp+3L3XF8Nmv1fLZ2cOgvvTNTNd8VzsIrqwcZuyeShJ5Q9Gligyo9zM1A
	 u9Y+0nFFvZd9w3Gj73HU58nHcGGB46asGHl/qTIdW2bPNfg3H92i5RMKX1rxsFmmLr
	 bBGU8Rt+JxISydJzIhAKGKPx89er1iE99gzdqYXvmZOOwPRlFHwoCDHYuiOdutdQYg
	 y+BvMb/Uo1cttMtKFyEwGHqkfLrlMWw/3Cjd/qcC8ycg/Vlvv3pwHEWCj/be6exPJe
	 lToFu+M8Bme1Q==
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
Subject: [PATCH v5 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Sat, 14 Dec 2024 15:06:42 +0900
Message-ID: <20241214060655.166325-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214060655.166325-1-dlemoal@kernel.org>
References: <20241214060655.166325-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_220728_519970_DF2D0929 
X-CRM114-Status: UNSURE (   9.89  )
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


