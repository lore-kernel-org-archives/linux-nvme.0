Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EFCF9D0DA
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdmAK4WYDVC89hEfWtovcurzTpnZydiXm4cIdQHMYRo=; b=vChVMz4flmfLWj9rCeVmKtj4xG
	dbWCrxeCQPJaG+DTAqUe+ZOKiSQ8CVNz/EtMI4Ni8HrYK9EZ60dHr1vqktAFHGEUvp2/3sa9qFWKR
	21wO+UIUqV+0vWKgREDcdhjJmJY2m9k5uxug/hhMzs2uWqc3TaKjvSJgSKL/IJuJAtOxEwjlQL/YJ
	WZKKJFKUHw91jqqDWClgztjwlRtZP1+cig/ZP63TrGR64ptBUD3+Q5UsImaC7m299+uqIhZJtR8Zu
	8eHkSB4DtE3UNhwrs+7vvUV9eZFT0Kd3LUO5fWO6wYumsuV/z13c7JO3YqDQ6g8LAeILKHdfmIzwR
	lJzWweFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCgBW-0000000HZSZ-2wuI;
	Tue, 14 Apr 2026 16:00:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCgBR-0000000HZQw-1PEi
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 16:00:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AA70D60127;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42B45C2BCC4;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776182412;
	bh=pfNTF4MyP7MbmWdaazOq9QG/qOgjWorM7k/pjnsdDnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sU694WY8maCGvpsF2aPpm4jykA3aSkWrASj+i1wx4WXCaMBFa/Zp0bB/AwQCxS+lh
	 QhDNbpEZKsjJO8i14ujORdg0B/cGIq7oQXTua+g4ufmC2XyAZ1gxxaXP8k6iPfmdeg
	 UnWTzjH5eGd7ybatUXh7WFySJ2tFwsSxtMNI2QxdbKJDf1g5Ie7aNUdPx/2qTYAmzh
	 z/ugqtiaApix27pRIyiV1Bp3C+dDpkIkwMRWVK5eOyx7CFjbdsVm/TlUC5xGZFwd/7
	 NrFsmrkA7jnAjhsu/OGO12rjRDErQDO9q3g17ojFDcXBhzzufJyPnxfqK0F4ffIH1M
	 9wwhDXd4TJ+Mw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3612FF9D0E4;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 14 Apr 2026 21:29:41 +0530
Subject: [PATCH 3/4] PCI: qcom: Indicate broken L1ss exit during resume
 from system suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-l1ss-fix-v1-3-adbb4555b5ab@oss.qualcomm.com>
References: <20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com>
In-Reply-To: <20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=4DYEP1zauw4orkCeJPQ0uZzhSR/jxYVrTX9FZ5rhz18=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp3mSJljvX2vawbgDmc0ySB7J1BxqOQETumjAom
 wNG3QoD26iJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCad5kiQAKCRBVnxHm/pHO
 9bvaB/4oVZcPWtoaiBUEUXLan1VGwV1vrK0hc99d4fh1ddJGcWisR+kxmzUyky+BJJpPBnoT3ef
 5PeuljVd9HnNz+Nv+Ik5keS/N+FGKfZr9n7Cu4CLc472+00oPb8wnWxXWpa6/xhNe5G7iqCHSEn
 6wYL5AtnXz4CL2zs+oZwk7xAf+DY3EkbrJlhxy6B2W9hBF+0ZK0Zw7zamLuLmgyRvKs07zOtkUf
 Y2arFkHTFH9deHbELWtMtHckak0wBO+opSqpprijj/g6iEVEpi/mFDIrxjZdwGuIce96deoHSYQ
 8K/B2aQnL9YPi9b0KFoTmoCVyuNfaTCdhVKGKaQkMeuEmUeb
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
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
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Qcom PCIe RCs can successfully exit from L1ss during OS runtime. However,
during system suspend, the Qcom PCIe RC driver may remove all resource
votes and turns off the PHY to maximize power savings.

Consequently, when the host is in system suspend with the link in L1ss and
the endpoint asserts CLKREQ#, the OS must first wake up and the RC driver
must restore the PHY and enable the refclk. This recovery process causes
the strict L1ss exit latency time to be exceeded. (If the RC driver were to
retain all votes during suspend, L1ss exit would succeed without issue, but
at the expense of higher power consumption).

This latency violation leads to an L1ss exit timeout, followed by a Link
Down (LDn) condition during resume. This LDn can crash the OS if the
endpoint hosts the RootFS, and for other types of devices, it may result in
a full device reset/recovery.

So to ensure that the client drivers can properly handle this scenario, let
them know about this platform limitation by setting the
'pci_host_bridge::broken_l1ss_resume' flag.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 67a16af69ddc..01afffd384f2 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1363,6 +1363,17 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
+	/*
+	 * During system suspend, the Qcom RC driver may turn off the PHY and
+	 * remove votes to save power. If the endpoint asserts CLKREQ# to
+	 * exit L1ss, the time required to wake the system and restore the
+	 * PHY/refclk exceeds the strict L1ss exit timing, resulting in Link
+	 * Down (LDn). Set this flag to indicate this limitation to client
+	 * drivers so that they will avoid relying on L1ss during system
+	 * suspend.
+	 */
+	pp->bridge->broken_l1ss_resume = true;
+
 	if (pcie->cfg->ops->host_post_init)
 		pcie->cfg->ops->host_post_init(pcie);
 }

-- 
2.51.0



