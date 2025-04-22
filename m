Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CA0C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ExdkWFS3PjXe/Dbc/bXhKvoVp3dzgWOeR9qxYAnKhmY=; b=uYzwuZMpiyG9kTN1pK8PBBvrVr
	vKPE6EzAL8HhgZ8uVAEMHTtJlxgC31UrVgbs5+uKpYV7FDrGwV/fn3RvT/pwWBPOGo+fyjfh4qwfi
	2JSdpad73/vrUsbWqjCDSX3Har89ZeUW5aMSnbvozZAqnMjEcbbcH5ZZnqxTqTsl+92FgWwrCVJE1
	R9OjBfW5XkFfpYKgP/DxEN1b8Mlungx4JGgKlaczx8jW2AA9Xh/MZg6jOYU53xn9Z4GCMxgK2AJQy
	OHpU5MoVBbnPR898Re/wsXWPuJUX9v8+AtrTYzbZp7IsW0eeCXMaATGiQUpN4OrnZGNiJ40OFGkou
	gLUZC7xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GYl-00000007vKW-3s32;
	Tue, 22 Apr 2025 16:33:23 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7F1A-00000007a4I-3OJG
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 14:54:39 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so46578755e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745333675; x=1745938475; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExdkWFS3PjXe/Dbc/bXhKvoVp3dzgWOeR9qxYAnKhmY=;
        b=m8rxDzlXLosVn8sQ4JcO80LCXuiuRk6qLDE66P3ygKvPx/RwaUDs8sUq0UJ4g0tzE2
         7PNzlBETtUVsvhm56vhA6aacvQxc9VkqjtkBiB3uGJmZm3oVeYRd+Q7QQ+CwpHcpLXwI
         7YxxyJCxAi39qTv0/4EJFemlmPkUDvDbhiaPrk4rRr2m4mIoBi2TXposGcR2pngTQBa+
         5RfNJmnYHIYoVBeBdFQjFrqWSfPUWfJXy5lp4GNnqaQ3Z5CEOmLCyv61m/jeh0qiskhJ
         53YOst71GrqhqyxvSkdk+K9R49AFnu0GUnTS2/3PzDRagFFMfwSCRx7IKnC5DQX4BJh6
         DVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333675; x=1745938475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExdkWFS3PjXe/Dbc/bXhKvoVp3dzgWOeR9qxYAnKhmY=;
        b=msIuTOQH7TbOVR7lF+7RWOh1Yoxe/MqHo8JWmvE3l7oFldIVY8JwBCpZb6JdaMI/HY
         YDIImP7H33rdDeBrCCMvFBYVXMp/Ul4fn2sRnFKw4gi6hZhQ4+qBN4uMVcBAj69xJgHG
         zItDb8lzzJyahRndGFIHX9fq6tH8oOZj1eL8bW4o87ypCSBYzWQj/As2oe51QAjw5Vb5
         8aQg4Z+yDnKgQAWoeojaekycY9p/r22x1reTveQ/rUhZaEwbTgtHLqfl/bqbG2fweFbA
         G4TCxXKeoNevkX7/vRQUyMmKWWwOPHZwOITa+pjccyEyS0evKYsFGHzW3OpAVF3OSRI6
         mI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpkL0TvuHfs/D8M+BGWRg8Z2//eMUlzKUlFFJY2ueOx1n/ItV0+1ls+CymLYpYAwwPiMhvZ87hDISz@lists.infradead.org
X-Gm-Message-State: AOJu0YyRQiyztiQ5fLkQybTtKkHwt37Wy/aRSbIEhVtybkKNW4hbx/fp
	TDmflgXM63QK1B6KEVdwAXmoZynASfB2M6snvaEGvLkIw59dO70EA4s/SWZ4414=
X-Gm-Gg: ASbGnctPhnyTpM3iq6uw98ibjLjH5Xp8j7rJkGMQ6H4gjZZMDwzV70FwE+oNPuStjEV
	xTqTVlDAa/XxNCqAH8ScRx/JiS2kX7/JmmInLf6B0rZoxQ/kD5QMVso6g/YWBfjauQAG4h/f02Q
	w18sx1UHURXKD0dtVE65th3aTMxrBnxzExqagP+5GJl48FPP60i+sLQyYK308E+cLeLwE8+x2DB
	sWeNgZMjBWbqqRqqqBu+CZT4E0SavpbBL+5QydD36QcmbEzaZKFLqr076qw9TlR3CvWzM9UWbiB
	0KYgdSF2LB/CS8OdsANKiwK1fDyn9bMcLgeUO37XRRDoiIx5cZK2fqM=
X-Google-Smtp-Source: AGHT+IEETbq5XFAfg5FeeK1CWsmUukRX4l/5LgF2s+uEV4e4L2MV/SS+HmQwhOulznZpXEph1AgW5g==
X-Received: by 2002:a05:6000:2510:b0:39c:12ce:1112 with SMTP id ffacd0b85a97d-39ef90916b5mr14296744f8f.21.1745333675135;
        Tue, 22 Apr 2025 07:54:35 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:5f77:7d42:6228:3358])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9de9sm177304635e9.6.2025.04.22.07.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:54:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 22 Apr 2025 16:54:19 +0200
Subject: [PATCH v4 1/2] PCI: endpoint: improve fixed_size bar handling when
 allocating space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-pci-ep-size-alignment-v4-1-6bd58443fee9@baylibre.com>
References: <20250422-pci-ep-size-alignment-v4-0-6bd58443fee9@baylibre.com>
In-Reply-To: <20250422-pci-ep-size-alignment-v4-0-6bd58443fee9@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4249; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=OeAjeCW91zOMarXM0kb3jzoSPAPF26xRkDPsEfYcHsk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoB62neNdYS0rNPcjwIqteNfi5mysq9qc+xVwMk
 VScu+42jpqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAetpwAKCRDm/A8cN/La
 hQMuD/94sBI1ts5f3oxCtZsY9RoXDtXYwn3cTiRTEDYF7fL8Op98EiGWcTYhB4dutn7hTR2d40g
 cXo+mc7XIljWXLXpETSXbyLwK78PqdA868JyvhPAiQOvjjlncWuU6UAhgNM9eJDjVDdagpC9Dqa
 6evRYZS2SBMqfrEXmUDJx4ElUwI8Em2XEAJWCMiSEjzIqqvTtizlKQGRcTGi4AAOdIUcNa9jsr5
 GCR7RXVOkTlo5FEUsh1zmKQcAd0RGnOxL5csgDfmCCRixRzuR+jXWYingmMIscd2d83l5Yk95jt
 WIpZ4Nl6yfQ45BG080rQMK+NwmPedlOByTsUceehldOGPaRn1rYYgZALkrTogPDpZCxzwTa5iLf
 0x9aSfAH9Fcr2sH9YtZcUtnGGQ6+dR6Ta6tczKD8z9NdvUBlqfgM/v2XWi+U4ETMw48xWW8Q4P5
 2d5l1eDB33gO059069B27rorvqYrc2ch6VA6cwIuY1/uJo2AjqLYRaxU7y5gflP/aOGEWZ4a317
 hHX9bRQwouG/qElI3eGPtxQwYeouwFFklJ2n6vdeQmcEvlElMSooKPE3aHO/HKZIvOymUHHw/3J
 xBxL0tAgXRKzZAB5xC1EtcZe53WHlIPCvK9bvr2Pfvcc0AOGfMFJIkD0A+romszh+CWo2Jk/Jwb
 CFFGTHItAq5LAJA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_075436_866187_48257DD7 
X-CRM114-Status: GOOD (  20.79  )
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
index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..23b0878c2665db1c21e6e83543c33149ab1e0009 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -114,6 +114,8 @@ struct pci_epf_driver {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
+ * @aligned_size: the size actually allocated to accommodate the iATU alignment
+ *                requirement.
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


