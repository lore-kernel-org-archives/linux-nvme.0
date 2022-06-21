Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5486EC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvI01MXf/9x+TLIyH8+Cps3GqkyrQeLz2N9hejsrZ2o=; b=jzwMwzAYOGJe/HSULOig9uREIW
	e9Fasut+SgRaY5gqWLfUc8KhDbgRjbHeilDYoMSlbFktokcQV27AZdVsEK4q5iAkuuhb9sA4iFKgU
	FNZxMyZIPs2negYZCyLuBfHuVcdo63hGDAUgYzSq+UMw3vwkQEvuH5R8fu/9qugLqjFh+wy5LiwM7
	mgZ0hx6SpIeyfnpvoapzJJD8Va3+hFMN8034GZyInZf9gnPgrZ//mqaLX6hRiN2+LGaEI2ls1RHas
	busM6D+kXXcnDGB7mCgy9+46eYlL8SCZ1wMQpy1Jl3bsqftnS/ZG8HHqiPNRFW4qRY4XSdeAvgYZw
	xkdipNng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpT-0076UF-GF; Tue, 21 Jun 2022 20:50:31 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kou-007674-Ku
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:49:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4DE36B81B22;
	Tue, 21 Jun 2022 20:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C1BC341C6;
	Tue, 21 Jun 2022 20:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844594;
	bh=l2LU4Hwzs04L/tPSjqDhp//mMg4wc0YpboI8cag9lJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/cvhmbqANjMWKd9OE/CQV35rZSEh9azqL8ZSJs65q/mrMP6E47PXUSbMGT7eDa1G
	 Fb8xZjkKmWZw0+IKnzSygUtvkvLypPW1nvFRmOELyLz+PCkCEsGcqQimUq5ayZQGDi
	 PiWHjFevdMz+LTZAcZaY0G8AgA6m1BCXN+X3GSLWEoKU4eU0OMKgNVvAq4hk4XgOA0
	 nB69OiFQnmw90Ph+59yxDfzll6fQmYQjC4nTkeN7QcxI+lMYyKzU/hXCDa85MfjlOu
	 Vjnlwu/9TLkCGmXTy6bcYvLiMYWvd+fkggjurcNooTUPtH0vlxmgflTj6+pPgrPGPJ
	 m5G+7rOj9WfXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 11/22] nvme-pci: sk hynix p31 has bogus namespace ids
Date: Tue, 21 Jun 2022 16:49:17 -0400
Message-Id: <20220621204928.249907-11-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621204928.249907-1-sashal@kernel.org>
References: <20220621204928.249907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_134956_892578_46AC1CB4 
X-CRM114-Status: GOOD (  12.41  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit c4f01a776b28378f4f61b53f8cb0e358f4fa3721 ]

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216049
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6c862259b381..6f9672e92b9c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3470,6 +3470,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
-- 
2.35.1


