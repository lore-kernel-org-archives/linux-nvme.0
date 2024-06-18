Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4001EC2BA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 20:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBIEJthE+Hi//pMd62yPEo4UEXsH3Lmm8lxfinm/XSQ=; b=wvZKeT1fV7EXrkE2MwC02k3wug
	jYZFNA0ebxKZzEkJx1OMQSgFj5mZ9P38FnwqIQ6Dmoa5ocBrsYiTlTeBzTRH4b/3RyeMjgQCJfL2F
	Z2VRNKdUZb2CQDUMu6KkU6S+4M8B0Nr3rE77phHalIbyS1+PXQoHiOdmCAvc+AWG5GCdC7UzIxAVL
	10SVaHhWnN9BstpUzY/JEphImEJx3SXL2DR5s3GUWdiPXSyqxHTl8JhXNiYue7keRtIA6NSpOfAj9
	/QJ1ivLEKwjVBRaXK8Ye6h+b2CIMaOeJxb9ivGVlvhyAiiUrDOwqzXhqDi212bWwb4HRtgZp+pK4d
	7NDcg7jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJfmA-0000000GYqS-21g2;
	Tue, 18 Jun 2024 20:49:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJfm7-0000000GYnz-2RpX
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 20:49:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8D51061B6F;
	Tue, 18 Jun 2024 20:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049C7C32786;
	Tue, 18 Jun 2024 20:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718743794;
	bh=JHzSKxuAUt5sskKJDUz7UVvUr/rjQm56XYg7g79WgHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1HaqRJPzz0zJSG/rrBID1OFWnkvPyXQUHG+2hFSO5FynGak2I85FGd3Iw+wsZPTK
	 rTgSR9XE2n4Uft8hL0UMAfhPVKYDZkcaVAIcBRM0W1sEzYD8FZ3Bo+lZF2RRGn4L4F
	 /xC2B7x5WEaF22/wfFgIhMXWxjiRWxCfjH7iVJDFiENoWSRCrMbkshsxk1QBnJHq8u
	 1Gt+UxrkNlyAulGCl0fTJ1BL+L+bPpzfNrO0xq8iJC3hEP1Z1ddHLUukq9IrXB+G8c
	 2YiEdaYr1dvxeaLJIVU1fUXSicM3+dJ1o/084SxMmFybN3tLXBfvV2ae5tSRfq7Axn
	 9FcmsnYLNW7Xg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Crider <gloriouseggroll@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-nvme@lists.infradead.org,
	regressions@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 1/2] PCI/AER: Disable AER service on suspend
Date: Tue, 18 Jun 2024 15:49:45 -0500
Message-Id: <20240618204946.1271042-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618204946.1271042-1-helgaas@kernel.org>
References: <20240618204946.1271042-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_134955_728532_5916A999 
X-CRM114-Status: GOOD (  12.49  )
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

If the link is powered off during suspend, electrical noise may cause
errors that are logged via AER.  If the AER interrupt is enabled and shares
an IRQ with PME, that causes a spurious wakeup during suspend.

Disable the AER interrupt during suspend to prevent this.  Clear error
status before re-enabling IRQ interrupts during resume so we don't get an
interrupt for errors that occurred during the suspend/resume process.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
Link: https://lore.kernel.org/r/20240416043225.1462548-2-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
[bhelgaas: drop pci_ancestor_pr3_present() etc, commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac6293c24976..13b8586924ea 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1497,6 +1497,22 @@ static int aer_probe(struct pcie_device *dev)
 	return 0;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_disable_rootport(rpc);
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_enable_rootport(rpc);
+	return 0;
+}
+
 /**
  * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
  * @dev: pointer to Root Port, RCEC, or RCiEP
@@ -1561,6 +1577,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 };
 
-- 
2.34.1


