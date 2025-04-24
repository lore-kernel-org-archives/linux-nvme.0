Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DB2C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 08:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DTdAIP1mKg4CjTYlY4/zlF2CtboYkKhoA+PQ2jqYOBk=; b=YOsEUONuS0kLnWFWBP99VCT77T
	ip8Qc0IDuPETVkfd+uujiPXfbXCusDopseF1GLXo1E3/xYXuSn9M8eXI4K8vIDmZKzwk0gJgoiyMb
	Fp3JLJaRHAtdtTlI1uhc/QliR/FFIGT/KILsHbBm9F4+oN8RsWTUB54H8ObgNOv3qYZD3nLr6syUT
	fMXT6RwfRApwSIkwLW0Nq1KU+aIoHcrL6XtfZT8BbEte4DJaKKqrPeuXJYUOqaUL8XiBcfNurD62l
	trdvA5iYzQEtSvP2QlHPeVQT/xJfJ+v7b6gms9lygUTuFNAt+Aa0VME/fc6A5nBqtDBiNCXFkf3jD
	lNEd+JWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7s54-0000000DLSG-3Gag;
	Thu, 24 Apr 2025 08:37:14 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7s2M-0000000DKuU-0Hm0
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 08:34:27 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so499123f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745483664; x=1746088464; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTdAIP1mKg4CjTYlY4/zlF2CtboYkKhoA+PQ2jqYOBk=;
        b=gZwgsHdTOfqCRbGVa19nr3XzdqDiDGox3N+zPUkiOXIumYy6LyBwSzWxXezuN5gnab
         DLt4fBACdnh0eJWhLnHO4kYBhhfgdloB9qkhWf3Bxgum/S9gywF0CK1RwuHziURmzQdJ
         iqyZTnB5yXbb34HrmsA/So43Q+1BGrWzCaXLhkrgiTPnlU26OYu4yAFlZokiSzeOEkTq
         S8n6AKUFmFfhehk1W4VSJHBOGL9I1JUrSsJl9JAN7BkGMxc3OEAjfaomf1jPtnap3Ae6
         SUBVnh9BLqCB1bGvZgh5PmM9UXrKGT0bBp2mj5MNJyAL6KfdAnyjSNLLW2BU0kEKIR5u
         dTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483664; x=1746088464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTdAIP1mKg4CjTYlY4/zlF2CtboYkKhoA+PQ2jqYOBk=;
        b=TgeEj3Tn9tdLon0UEaUPcgbcFcZzCcU7HT6eVu8AG+sk2uvaBYfsKHNUcaHjQWLsLL
         m7XhRvi6bEP1Jx3yfq0nMdqFDhDRh6mexirWzzrELzG0KYxMnjEVCY6osaJVg/MpviDH
         VYREKu3OcSP1HG98l/59TyHELph3Xq6+Q3r4/yfETCZ/++0iOUbuKv4UdVe5QyVr0vaT
         j6vFJC87DUzh23GS4qxSsTw+OQWloSgpn+YxVr3tu6rba85CwmUE5k/moDSDDHnscTqq
         NxydtoLV4MMnJo3wwGGCMW1HHzkRsbV+IJWc+Cuwx5bocn2w83LxBn5GYeZUMOm8VPqY
         2i4A==
X-Forwarded-Encrypted: i=1; AJvYcCWR3fB1H2bauumK/7Gs5AV8Q0MLILhaJk+yDASKAAdudz6CDT9YN2qslVNEuuvd0I0H/QQT5vEO/3Qo@lists.infradead.org
X-Gm-Message-State: AOJu0YwIOA7lgKfzJyKAOns+MIQMzDUZ8wVi4tgSfClQM45KSdc0LW2f
	JykJxbsXWzKvErP/Y1WOGnSqEZL9F08vN3zGfAxZl76kU7lF/RqVZTA3vzMozfc=
X-Gm-Gg: ASbGncsNoL9vil/RFqZqyjLMd2ASYFdyaafE6B0Pm6rNlU03oiBjjLgJhq8Abt2CfWY
	f1Hegvl3YRt+RUN8QY6nPnbdj8wEKLXJAobJpctRUEdYhe4BjhHhqevqGsAa3wLSi+65BKIcng4
	+MLvMXU1zshFl1Gsom7sVtZudnrbOZ35w8kkoMFo/Gcvu05GZXfo352yCdZZvaB9tj0jSpEMU7n
	FxhqXFY7tc1zVAIHewfrZSabe+xyO7U07bPJ6Mz0kMThBEBw2fBuqd7vDUxDVtVpzHxVwvKtfQJ
	k1vZ1kYui96587xUAzS48wsuFDjoFh5PoUK/lDM2H1hCIYVgCHPqdQ==
X-Google-Smtp-Source: AGHT+IHCyKzJ42aHroSUm8dSFe+zZZelO2D51+fPKE0kfSithPmCpekbPV1qFCzXw6Neqmf+66ygKw==
X-Received: by 2002:a05:6000:402a:b0:39a:ca40:7bfb with SMTP id ffacd0b85a97d-3a06cfc603cmr1159155f8f.54.1745483664218;
        Thu, 24 Apr 2025 01:34:24 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f74:6a9a:365b:4453])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a06d4c6c56sm1323881f8f.60.2025.04.24.01.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:34:23 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 24 Apr 2025 10:34:04 +0200
Subject: [PATCH v5 1/2] PCI: endpoint: improve fixed_size bar handling when
 allocating space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pci-ep-size-alignment-v5-1-2d4ec2af23f5@baylibre.com>
References: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
In-Reply-To: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
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
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Niklas Cassel <cassel@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4296; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=K1O/ZXnuPZvlJKjkZceWhCJx16Ps0pz6fRC0LfxqGpc=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoCfeM6J6+pCgmEwgvc/aDPPGIR4Mg3nyBaNxNK
 M9t502XUfKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAn3jAAKCRDm/A8cN/La
 hauFEACy9VCXN23DaPGmIJvmbM9qPENNPeRyGmzMlpjo9DyMfrnp/xORgiKYBJ/WDqk2ZCTuzb5
 LVUqVG9RH5jxpaeKqIrotYbDMNSlgLhWOuaBQP1T8a+JDJLM4rtQ/0lnJ8yZvdgRKogdt5WwE7+
 zmcccvWz6URwDuAoSOkmv1W0HGXru4wb25nksRsusTUX8d5ysjesdqnKgTraDayvGYPBuSVi2Oq
 ztUkpECUs/l+jC1EvmEqpzGo+VsHdjlCqVbSBJVp5jHPNAAihAuzmZMjTgpW3j/DJqHZ0+pu2We
 SEigB2bd8LKgw8zfgaHExZvR/KG/7I+Ifm+JNn8bLsi3Ed8WKC/MB/pmwZlnLHtoyyXMmiHkjnd
 lS2fcH+Oit21Z5RWOLEcwl6YB00c4HxgCOe0NtL1pomY/L2dcu+jBDMjEJl0yWtdARoNyeDlICw
 f9/m9I7PT9XtYDe+2/xoG7gzFS6FIq4scZJLRqkySW86rzOp6x48T/nPDbVHNmTScIw5nT/6SH3
 Zx/eGdmu+lte3XBuO9UoLGpgSJ/n71ZSROD3IO2/3RlCIKnWqcxALEnRrAGPGqq0m9NyCa4fgXJ
 f2QbU7wciMaErvjDakmZi/IYHo0aq03r4CrlEizF8oh0vB9ggQwsvDOeNLrqFXzP651wIhJNN6p
 42/4zS67gD2wWxg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_013426_124857_1336B920 
X-CRM114-Status: GOOD (  19.80  )
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

When trying to allocate space for an endpoint function on a BAR with a
fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
size. This is expected by pci_epc_set_bar().

However, if the fixed_size is smaller that the alignment, the size saved
in the 'struct pci_epf_bar' matches the alignment and it is a problem for
pci_epc_set_bar().

To solve this, continue to allocate space that match the iATU alignment
requirement, saving it as .aligned_size, then save the size that matches
what is present in the BAR.

Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 21 ++++++++++++++-------
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8decfa2010469655a4bd58a002993fd..982db6c1fbe77653f6a74a31df5c4e997507d2d8 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -236,12 +236,13 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].size, addr,
+	dma_free_coherent(dev, epf_bar[bar].aligned_size, addr,
 			  epf_bar[bar].phys_addr);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
 	epf_bar[bar].size = 0;
+	epf_bar[bar].aligned_size = 0;
 	epf_bar[bar].barno = 0;
 	epf_bar[bar].flags = 0;
 }
@@ -264,7 +265,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t align = epc_features->align;
+	size_t aligned_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
@@ -285,12 +286,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			return NULL;
 		}
 		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
 	}
 
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
+	/*
+	 * Allocate enough memory to accommodate the iATU alignment requirement.
+	 * In most cases, this will be the same as .size but it might be different
+	 * if, for example, the fixed size of a BAR is smaller than align.
+	 */
+	aligned_size = align ? ALIGN(size, align) : size;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -301,7 +307,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;
@@ -310,6 +316,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
+	epf_bar[bar].aligned_size = aligned_size;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..749cee0bcf2cc0600ad3be1582b0c497c5a21bed 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -114,6 +114,8 @@ struct pci_epf_driver {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
+ * @aligned_size: the size actually allocated to accommodate the iATU alignment
+ *                requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
  */
@@ -121,6 +123,7 @@ struct pci_epf_bar {
 	dma_addr_t	phys_addr;
 	void		*addr;
 	size_t		size;
+	size_t		aligned_size;
 	enum pci_barno	barno;
 	int		flags;
 };

-- 
2.47.2


