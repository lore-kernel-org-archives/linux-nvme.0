Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC97E7718B
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Dec 2024 08:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g/PXZGdcdvXR2gkkT3t5JxDfFT6N9ynrcIgYmMs/8lQ=; b=tgl/CjiJYNR0TcI88eLgW4sX73
	1an82ThQN5fn0MqH2pw6QwRlul2K5KwpYYZ8pXpdugqTR3wx9PvQycEo7KXOHYhPh0wy4KpOrERBm
	PfyuCA5yLFAW1OCZSjrkgIrULbdjq/Fta3tRDaOSlF89uBt8F5/3CQUyjw76vg1FFwp8E2HUVWcfp
	Rwg81KqHoqduWm0mUHkOneMdptwZNdJWdEHqy32V98guu36fJTbfGme5Sz8l/4C1sv99HFCtjduiA
	bEbwFUD0SU2ajLIAtqpXRJ5Sd/oINexOnzbP6SJCaRJy2h1kV68y7/a599/g1NKNJqZZAIJ0EQPHt
	3wjm9f9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQMn2-0000000DSIo-3BNf;
	Wed, 25 Dec 2024 08:30:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQMmy-0000000DSDo-162K
	for linux-nvme@lists.infradead.org;
	Wed, 25 Dec 2024 08:30:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C7B235C589B;
	Wed, 25 Dec 2024 08:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DE8C4CEDE;
	Wed, 25 Dec 2024 08:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115443;
	bh=je5NcrKzqRp4TLcdE4FoMVzSwtY0YrZ9VBSF2cscEis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1THOzaIySgps4LDrsazXNQehNaGOg0tNBGKzc7eVS2fwDpn6rMn6Xt2uTCfAJZi8
	 CKJA9FcdiDDSK6LosnZemuMOrmX842Tu7dyU7MROVPajDnPMk4hpXfrtlCDNaYb8/Z
	 7ODIkvWpKUtJB+5S1RssR8BvqTdQ9fdD8IgjcBepqtKeCuV12fwz0hbJ1GVYjrT6xU
	 XRRn2hd7yqVbSnXybxRov/0RbObWJNdsZzmEuKoiH8Fws+pzQJkspSUp/Wp2xfukRR
	 XTS/dFXbKCl6fkC+o2i7H7uJeMRwISufDi1HZY4wrtI3P5BOWCjjdtvW4gH/m+tGzm
	 a2SeKPao2UJRg==
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
Subject: [PATCH v8 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Wed, 25 Dec 2024 17:29:42 +0900
Message-ID: <20241225082956.96650-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241225082956.96650-1-dlemoal@kernel.org>
References: <20241225082956.96650-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241225_003044_360348_A759CB3A 
X-CRM114-Status: GOOD (  10.55  )
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


