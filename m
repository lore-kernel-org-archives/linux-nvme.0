Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AB9C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 04:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EIqb3ZhtP6vTc/Ol0BEJS2EDfRh93Z4lytIAwmN5HBw=; b=QUBRmty66swKda/8lvjtkqrUAH
	TpRhsN/EAdcLQF8O2MJiAMigyUO+MM9vPUe/Rs6ysZupRsoV1EaGUczXWbyuFBmrjZeqQZnU1YnIc
	rNvzEfV3AU2JtPU2X3bFliPxdWK4uJErkORttQ2FlfabbFMu/EGxUD9/iyZ9GRuVLHKrj25OxXoSY
	LiMrsbJF4rvIVJIq7oig7ongLd/bVmy8NVR/vvuwiBil4HOYZH5RXGybkt9NgqT5HBglxJ7aGKvCZ
	89HQR7nCgwI85uhWx8KizD05rIRnQKlUrvh7+dpumUiYKMDmIu4kvnlKvcFgWKhxZpT8DfOC5QHQI
	NP3e6Tqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwaVf-0000000ApNN-3fhv;
	Tue, 16 Apr 2024 04:33:31 +0000
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwaVb-0000000ApM8-30Se
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 04:33:30 +0000
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 656BC3F0FA;
	Tue, 16 Apr 2024 04:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713242003;
	bh=EIqb3ZhtP6vTc/Ol0BEJS2EDfRh93Z4lytIAwmN5HBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=NKOtAfue4ui49NMuPLL0XAKGEFXav6o4C68s62FY4mxrjwrfM4IlFO/o2T99SB7h1
	 E9GAlvpSYHu6NAZtGms4ab9wfWZ9jAovmt+67i/pQuMRuWXWKL2+rkLy9MJxJPaF+s
	 KEIUrUBacCuEPfQK6v3CfSFewEZ5Wy8L2kuC6LwlzrA3xyzo89DEDkJCNJRKNCO6wR
	 Q68K9/AN2CaAUfc5//i/czP84EqEosxaTqfRNf4uLUWVg6etOiZW1UigHHln3r1eMj
	 StHCFMAMxZL78xsjzt4zV6Cm/poJOsXEvB65i2FW7B7WNkqzX1AGEd1eff45PPOhfu
	 m27lNjrJFS3Eg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bagasdotme@gmail.com,
	regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kch@nvidia.com,
	hch@lst.de,
	gloriouseggroll@gmail.com,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@suse.de,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v8 1/3] PCI: Add helper to check if any of ancestor device support D3cold
Date: Tue, 16 Apr 2024 12:32:23 +0800
Message-Id: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_213328_654243_3277AAE0 
X-CRM114-Status: GOOD (  10.51  )
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

In addition to nearest upstream bridge, driver may want to know if the
entire hierarchy can be powered off to perform different action.

So walk higher up the hierarchy to find out if any device has valid
_PR3.

The user will be introduced in next patch.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v8:
 - No change.

 drivers/pci/pci.c   | 16 ++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..7a5662f116b8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6225,6 +6225,22 @@ bool pci_pr3_present(struct pci_dev *pdev)
 		acpi_has_method(adev->handle, "_PR3");
 }
 EXPORT_SYMBOL_GPL(pci_pr3_present);
+
+bool pci_ancestor_pr3_present(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pdev;
+
+	if (acpi_disabled)
+		return false;
+
+	while ((parent = pci_upstream_bridge(parent))) {
+		if (pci_pr3_present(pdev))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_ancestor_pr3_present);
 #endif
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..cd71ebfd0f89 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2620,10 +2620,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 void
 pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
 bool pci_pr3_present(struct pci_dev *pdev);
+bool pci_ancestor_pr3_present(struct pci_dev *pdev);
 #else
 static inline struct irq_domain *
 pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
+static inline bool pci_ancestor_pr3_present(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_EEH
-- 
2.34.1


