Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F73C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CAkSoBab2mcjkSikNieA7Mms82PLhiuTw+xHOZIjvOM=; b=pWo0i21ftMPT7S8cBqVBk7QGwE
	WTNcaq2LKBrr5A/dPZ7x86xZkrRDx9GChWfwpqZhYAo7MUvbGjOE/0nHpS5E+6kOENkbP5p//h36x
	Z2FdSNvy29e9QJsRv58MU3583bo3DuixGi9plstoLqx+zgI3dRDqkhcbDPRziFIaXj+YQNk4/nhyc
	oGpbLv/irfNx+R0wJL7xQnWRCZpCq/NAp7Jw0Iuuzj26w7wk7mO4XTcJYmIaVDgAauK8BUPb8YNRd
	5i1OZn9wuadsYeh0Lg0Oz9kgSSKL/1+w4th1a7xs2LGPNqpQvS5ImZrbDNnMHDFmX7bcebXgc/MdA
	u5wXk6jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1oLo-00000000wug-0I6L;
	Mon, 07 Apr 2025 15:25:28 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ndJ-00000000lrP-1mWO
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:39:31 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso29932455e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Apr 2025 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744036767; x=1744641567; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAkSoBab2mcjkSikNieA7Mms82PLhiuTw+xHOZIjvOM=;
        b=J3EgCTLpeksQUpP3Yanq3AjSnvRou6ban19L4ThpnTsTsevKRIVqyF702squPYGsEv
         wfyzpemeCKKazqWsEoAjMlGceg80G/j4X6BTHqQ4t38Qv2l2Z96jLuAMp0bFp2+RQKfK
         cYHP6ZKXGyrhJLQRD/Peaz29umP/9RI8zj7w9U/WqMeglVZoi25HCjoEcZCYxaR/5h7z
         87Bg3cRfDAnC7+WhKJeD2gJe+cpODYTf+vDEeyhT0nhD8pwccH50cdwgTF2VMpwujE/P
         xsPbjFcOx6MJfZGma5OYAH93tJgOKeYQc3uw70C5m76WTEkT7GlPH+GnYsfhh+khnS4n
         GEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036767; x=1744641567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAkSoBab2mcjkSikNieA7Mms82PLhiuTw+xHOZIjvOM=;
        b=QFMurqPX93knW9q0vLEzq1k9vXUU0tBM81+BAiLba3PI48DO8xA4CLHsPolRQ1WSqj
         NbSrlMQP1Cwa9Utg2OpTCwWbZOZOv6LJ4b9OVI/vA3wF2t5y4mEbCPhBYRZCD3fThA72
         a+jVREHx7HFnKUIPxDXATq6rQ4TlWya2poHYfd7AWthu7ySC6h+nAHScvEL+x3NfY6LJ
         y3NuTqdznKA7M63N9kOP5PoS9yFBLOdokKFlaIF1a1wZAkqaPZKXn9lpd+9X4eFkZ53o
         nLUKUnDsO1dO213e7agcjs8u4/E+RPSDici1BtIsZ19Dga8uIrSwQE5E23CACYr6qUJi
         uquA==
X-Forwarded-Encrypted: i=1; AJvYcCVgcA6yJrC+8Ddvi1sgKoapj0K2YE8hNOHou+y5qbtA+Q8MWZFX8HJAj3BdT8tq6TfMR3zbZDfWVAC8@lists.infradead.org
X-Gm-Message-State: AOJu0YxnQufNFpZc7dow9QsZ6wbPE78kdyS/7Mie2hvSeqj4Yro7LlRk
	tWfEch1pxeWlqAk6HlnC3WMZTn6qw49+i7+V7oF8PKUS1Yds9gbKAxSJCPO8RCQ=
X-Gm-Gg: ASbGncvc1jNxbSmTETkbmPx2L6IqHeIyr6kVqL9k9h7oTcXlZCghCKlQxFf0TnH82K8
	DMb1PdQY1KxNwEVkoVuELPs0jgxgkSEztCPVq+3niUIqdjIh04ckKjkrejorAKPDeOsH6HTystD
	nD01S+nQ6JNpqLrmqwagFbLXZerXgdUFMr7qokMX2LslE/JdOfZ9FaRmsFPJMvWCgU+ABxgyKkS
	OSfmKuFK5kTraIKEEpn9pjdsTlsEki5FThOorYca1IHLwGBHKN7UbqxHNBFSbRadHM/8ueTWrmg
	f2j1isNh2WDDIJVZx2ECUZ4Gwf/8q1jfEKfrhIwALYT5KECwW5j2UCkykv0=
X-Google-Smtp-Source: AGHT+IHYNuBw7pt0b3N9Uj+WvpJtruSG0l3vb5tTFAlq3DYP7AsQp5Q6OxMd7vtr6bLEUuW77X9vqQ==
X-Received: by 2002:a05:6000:2509:b0:390:d6ab:6c49 with SMTP id ffacd0b85a97d-39cb35b1a8cmr12446064f8f.35.1744036766921;
        Mon, 07 Apr 2025 07:39:26 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm135003705e9.9.2025.04.07.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:39:26 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 07 Apr 2025 16:39:07 +0200
Subject: [PATCH v3 1/3] PCI: endpoint: add epc_feature argument for
 pci_epf_free_space()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pci-ep-size-alignment-v3-1-865878e68cc8@baylibre.com>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
In-Reply-To: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6049; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=gpdenQ1KTwrhqtRAGsdUtxPDX/0ZTIXJDe/D+TKenF4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8+OauAXNd7kCvh8ELhw9UoQ+j9kAT8RJ+NjMp
 oe5ssp0vg+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/PjmgAKCRDm/A8cN/La
 hX83D/sHZNFS59gQ+4tjHanyRU0075HG7FzCjsrOpcn4tmq1hn+jgn6dhWO8oxjMBDCbTextQIf
 XRhqEc8ne7LwhSCmO6VJffo+woIG1kNyvVmHcnUoacePg95tTePNuTrs9K2dLUe9JTvZwwJiKuc
 zvQCcBgslxS3wyCeZrO57mYiNHr5R/6kNvQ2G7t/to2FiXiQTduj+CVkiKvG+7JX/W7FA8C9MtU
 mj61PY4DqWpdNGt5ssMYq3mkwbLpEdWoOdgz/h9iLLqHyUeLv3So091p137zgvTx7BbPm2ePh0P
 QRfjqrhJFfkGb9453ayLp+zPjxUKwAkA653DtSQJTz6pp7FTYJnHYVWqjk/lM6cEci3zKZfgU2j
 p5BMXYjoL0kO5A6/nhlMm11Qatd1scLJloJBeYmShCQSaglvY9XXMSqtsI1Xe35rklbdDlL+a2M
 7yJSGuy/qDj1MhcMcX2lM0ac4KdD40GfPY5AcwzRhZCo2eNxIRAmn/s9g0DvK05fdaBxRtjHNxC
 ouUQ9p2HWbLG+c52gHmU5kfTqYipAZMdnsN1+i9UJVyADq9UGL4MRiL4KdwEn96dANHkP/ObHKU
 I4Wj+6VnOjKQQM2sun9xo8gAfcAW3nFfH9w7cCMkhAdraLlVc5tl87BfSr5Vm5UFBY6H4qpdAAF
 c3hpgbSWFd/jwTA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_073929_469001_7970FF47 
X-CRM114-Status: GOOD (  15.28  )
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

Add epc_feature argument for pci_epf_free_space(), same as
pci_epf_alloc_space(). Doing so will allow to better handle
the iATU alignment requirements.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvme/target/pci-epf.c                 |  3 ++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 ++
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 16 +++++++++++++---
 drivers/pci/endpoint/pci-epf-core.c           |  2 ++
 include/linux/pci-epf.h                       |  1 +
 6 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 51c27b32248d0137fd3a557728eaab72fc7fca0c..2bbc41f8400837bcb83463b436598b16070e11f5 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2174,7 +2174,8 @@ static void nvmet_pci_epf_free_bar(struct nvmet_pci_epf *nvme_epf)
 	if (!nvme_epf->reg_bar)
 		return;
 
-	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
+	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0,
+			   nvme_epf->epc_features, PRIMARY_INTERFACE);
 	nvme_epf->reg_bar = NULL;
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e01a98e74d211174db3075c20457a3183f37e0a5..44775c41c10b90a56b1167f3f3869a60c686cf9e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -957,7 +957,8 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 		ntb_epc = ntb->epc[type];
 		barno = ntb_epc->epf_ntb_bar[BAR_CONFIG];
 		if (ntb_epc->reg)
-			pci_epf_free_space(epf, ntb_epc->reg, barno, type);
+			pci_epf_free_space(epf, ntb_epc->reg, barno,
+					   ntb_epc->epc_features, type);
 	}
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 50eb4106369f41afa00ed3ae58c84922e0a49e51..8d5df47967226e1f02444e8d45f7aad1394afd04 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -740,6 +740,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 				      &epf->bar[bar]);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar,
+					   epf_test->epc_features,
 					   PRIMARY_INTERFACE);
 			epf_test->reg[bar] = NULL;
 			dev_err(dev, "Failed to set BAR%d\n", bar);
@@ -941,6 +942,7 @@ static void pci_epf_test_free_space(struct pci_epf *epf)
 			continue;
 
 		pci_epf_free_space(epf, epf_test->reg[bar], bar,
+				   epf_test->epc_features,
 				   PRIMARY_INTERFACE);
 		epf_test->reg[bar] = NULL;
 	}
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..8f59a5b9b7adec2c05eebae71c6a246bc5a8e88c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -389,10 +389,15 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
  */
 static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 {
+	const struct pci_epc_features *epc_features;
 	enum pci_barno barno;
 
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	pci_epf_free_space(ntb->epf, ntb->reg, barno, 0);
+	pci_epf_free_space(ntb->epf, ntb->reg, barno, epc_features, 0);
 }
 
 /**
@@ -557,7 +562,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_alloc_peer_mem:
-	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
+	pci_epf_free_space(ntb->epf, mw_addr, barno, epc_features, 0);
 	return -1;
 }
 
@@ -570,10 +575,15 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
  */
 static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
+	const struct pci_epc_features *epc_features;
 	enum pci_barno barno;
 
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+
 	barno = ntb->epf_ntb_bar[BAR_DB];
-	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
+	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, epc_features, 0);
 	pci_epc_clear_bar(ntb->epf->epc,
 			  ntb->epf->func_no,
 			  ntb->epf->vfunc_no,
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8decfa2010469655a4bd58a002993fd..b7deb0ee1760b23a24f49abf3baf53ea2f273476 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -213,11 +213,13 @@ EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
  * @epf: the EPF device from whom to free the memory
  * @addr: the virtual address of the PCI EPF register space
  * @bar: the BAR number corresponding to the register space
+ * @epc_features: the features provided by the EPC specific to this EPF
  * @type: Identifies if the allocated space is for primary EPC or secondary EPC
  *
  * Invoke to free the allocated PCI EPF register space.
  */
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
+			const struct pci_epc_features *epc_features,
 			enum pci_epc_interface_type type)
 {
 	struct device *dev;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..d2d1c60fd5e0487b25aad51fee1b30554f630557 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -222,6 +222,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
+			const struct pci_epc_features *epc_features,
 			enum pci_epc_interface_type type);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);

-- 
2.47.2


