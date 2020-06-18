Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC97C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 01:36:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608AC221E8
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 01:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VpWXE9r3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqfP47B9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608AC221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RzQ8vZBpyDeTtK10IHSrjdD8TvSFILbsuaHSM7rvRYc=; b=VpWXE9r3EtgYMQ
	zFsdMnmM9z8JtS2eIMX+f9A39nNLZhAeaMhTcwQd4Ufb0F/GDv0pVyNfx9XpfcloaGs8oS2TxTdix
	iGm0o/SatI1zy9cD6M0J6G4vb5tuMK9Soes88JJudbWrqOXwqAXDF5EoscdDToQQF/EGrbhaiCROM
	lxRIBakm1RQdC14N1nZ1jyD4ZgeFwr0mKXS0IinXR7DkbJ3MyVT/xzXHsmmFlA9nubwDRZW34BCSW
	ZgFZRugSNOQvGkozPnK+veWgYs8PJJrQFlYhzoJYCZ+yxvZuhhTg63NS+Er3RFLi8OEwKngBO9/bc
	Lj0c11sZGDmC8WqS8rAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jljTp-00081R-V1; Thu, 18 Jun 2020 01:36:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jljAA-0007ON-5A
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 01:16:20 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C78F21D7D;
 Thu, 18 Jun 2020 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442976;
 bh=S683/qufa5CQUuVgcuYcQAqplJwbPg8tguzW1wjfo7U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hqfP47B930cHLrM5S4uLhZcNq69Ufxr++C02bunepshebtmCmvIknugnQ2FBrl2lh
 rDtgLCyOxATaF49qcH2DvzhSDvVpTXb9R1hNxqtJpqykalNhZKwcOrWJ3mfUFM2gDx
 V5GV22LkfDFp7KnA0JJR/0gatcQm8deu51GZqjIs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 379/388] nvme-pci: use simple suspend when a HMB
 is enabled
Date: Wed, 17 Jun 2020 21:07:56 -0400
Message-Id: <20200618010805.600873-379-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200617_181618_549332_CC5C563F 
X-CRM114-Status: GOOD (  13.63  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit b97120b15ebd3de51325084136d3b9c3cce656d6 ]

While the NVMe specification allows the device to access the host memory
buffer in host DRAM from all power states, hosts will fail access to
DRAM during S3 and similar power states.

Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cc46e250fcac..340bb9c8995e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2933,9 +2933,15 @@ static int nvme_suspend(struct device *dev)
 	 * the PCI bus layer to put it into D3 in order to take the PCIe link
 	 * down, so as to allow the platform to achieve its minimum low-power
 	 * state (which may not be possible if the link is up).
+	 *
+	 * If a host memory buffer is enabled, shut down the device as the NVMe
+	 * specification allows the device to access the host memory buffer in
+	 * host DRAM from all power states, but hosts will fail access to DRAM
+	 * during S3.
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
+	    ndev->nr_host_mem_descs ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);
 
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
