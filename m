Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90F2E77197
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 05:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g/PXZGdcdvXR2gkkT3t5JxDfFT6N9ynrcIgYmMs/8lQ=; b=lxN/k+kW1PJ16/3PiythKWWucu
	Mb986PvHVkCRuEYE4f4dum78+IB/04k711Q39AXxmBecR51lAtOodc2v3+7K2UqmK4UCmwjTaGvcn
	sT2WKSTwliTyvzEt7NR07DrR7PtpGVdK55YoFyvKpY3X4ZWKdC1tc3Cy/bBPaqHtxsT04cW/2iXPc
	twR2qWLuQJ+KbsFk8u6IERIL3iQLyED89rE9v3itE/9CkEamKKImUyOhUalWiklB8AIVZizQMVxuA
	jEjlCpaB5AbTgU6IPMzsBiYEApmkAjGvyWSn9Wv97Pg4Ex39OgJFt9KFZo4QZ65FHytHUQjMs2g91
	Z1wX2XRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTwH9-0000000ETjy-42b8;
	Sat, 04 Jan 2025 05:00:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTwH6-0000000ETgJ-406c
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 05:00:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3B41A5C2722;
	Sat,  4 Jan 2025 04:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8ACC4CEE1;
	Sat,  4 Jan 2025 05:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735966836;
	bh=je5NcrKzqRp4TLcdE4FoMVzSwtY0YrZ9VBSF2cscEis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQeMszXBRzSMj91s9u4Qo9u3Fbue+yXE2NZ/E52WTFi4pMI9wUwinKUamldjVF9pd
	 SgLraV8vfK2LfdaDagFD0VizSVzwDPeSnYM1FKhSmq01II6I0vqdLRw88Jzf0zhzmM
	 O2ttNI/8a8m5f0WCJko7/t079J6zA0Cp+BD3FHTX6lsFgqQhx1fAiMTY8fUWDZMtUh
	 4BED8pdKRS695QMcXMOQpG6L7W7EUJgE4hJM9PFuIMBGsIXs/xyqc+0ZgsfrzyLcJ8
	 L4g+JLsGqnSKf4Y8IuBm5vYUA0qKc7zbrGwxPTTcVSqJzK0BkaeuFIDoZTS2FDBMbR
	 V2LY5SkM7BrVg==
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
Subject: [PATCH v9 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Sat,  4 Jan 2025 13:59:38 +0900
Message-ID: <20250104045951.157830-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104045951.157830-1-dlemoal@kernel.org>
References: <20250104045951.157830-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_210037_028991_89E7DD18 
X-CRM114-Status: GOOD (  10.45  )
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


