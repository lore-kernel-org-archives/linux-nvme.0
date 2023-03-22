Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BED0C761AF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yfW3PsNgl2YqEj9a7UK39SEPm8kNWu59VpFFdl1BIYg=; b=xumiKt8gitPNzb9B2DkhUp+szS
	QOARRsn8KjKrOdC+7dS4E3CQQfnCi+zs45BlNZUzfrDbZxkKn6MQxf4Zb/nTmISmfCE958N9w6Mrl
	JB2tW0juZgGzRtEMx6sbM4Ws9XZoC9+6nzHc/swMmhxXpwtfilOofFrrJd71m+aFmkwOlzqLvcHkw
	eaLuT1qxh7AGWmGhzIwvHCJBDFHhnqlPC5ntXe+iwsph8wkYcyR97+fgkhJ4lqpn9zki4UFEt1QL2
	0UEoVI+Z+0ww3GrGtFDF0bbcT592Mfsx3D98mMgOyqd7yl88aR3EK5uXKM2mz6LPVlqWzTassMRUi
	reA6a9pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf4c6-00HFnK-1e;
	Wed, 22 Mar 2023 19:59:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf4c3-00HFlu-1K
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 19:59:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C8BFF62294;
	Wed, 22 Mar 2023 19:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F363C433A0;
	Wed, 22 Mar 2023 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679515150;
	bh=WtqBU0M7xNp4cbCC9ne0kWRWFFTtrkx01YJanzR9t4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5z6q3QnOrAMbxZwzCJHNyrwKRYVPXCOLI/Mh8yybsplgVpHVgygPo/nWLeDni4sw
	 L4OsllpeqHTA3ySC3N72lOX+Yzx+xdWfqT07gjx4rUKP1zkJmGQpCSlwbGYrZC6G3I
	 AzTZ/OWMSyspQ3DFdm4prrQ260gvMCQ+51DnIkx2HtIT/G3+nKYaTttKL9ti4y/fVZ
	 yw3y24zWNGzAD7sW71dOOlLpJy8TclcX/IARcmtaAeYS1oCZtMy3CCOfkoqXmoOBjm
	 KzSpSnKWzXWUVgRgPNG5QIYAYhJb/SAsDXEs18VXhnbfxphxJmOFTMHNZXOYNnNaF/
	 91DYS4p+qKqyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Irvin Cote <irvincoteg@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.2 35/45] nvme-pci: fixing memory leak in probe teardown path
Date: Wed, 22 Mar 2023 15:56:29 -0400
Message-Id: <20230322195639.1995821-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322195639.1995821-1-sashal@kernel.org>
References: <20230322195639.1995821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_125911_487139_62AFCA6D 
X-CRM114-Status: GOOD (  11.70  )
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

From: Irvin Cote <irvincoteg@gmail.com>

[ Upstream commit a61d265533b7fe0026a02a49916aa564ffe38e4c ]

In case the nvme_probe teardown path is triggered the ctrl ref count does
not reach 0 thus creating a memory leak upon failure of nvme_probe.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c11e0cfeef0f3..0a77242794d64 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3126,6 +3126,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&dev->ctrl);
+	nvme_put_ctrl(&dev->ctrl);
 	return result;
 }
 
-- 
2.39.2


