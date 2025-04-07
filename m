Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C1AC3601E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y7eFcTw1BBmLsXfJBPUwIPNdKPEmqoZIDDhrBsVYvns=; b=Gv9X9a7gd0KI6bW443CJ4Bfvn8
	jUBO63+sbmnCqe0i3z9cOR+xnVYM44sf2y8ZswXwS3RU5s5qGXXqJAvhGHyYqw0BKkPklzpwKlsRL
	riSfGMYsbemVt/iYmZqdt6yRIrvLP59r6LBjZpTjaPSh8+cQRjFDttqa/hmYuCkXsPvx9o32MeFlC
	TG2x3ExgxLlhCksTdg0SWQZ3Iyxof7F7qK6UiB3l3vpFWgONPkYkyTyr7mEMmD8pbe1fjOy+r7hEl
	lyWDHZKAEVZ+542p0aSFBNTiSDpqKlf+lCuEPq1hUMNuEmRBu+uO35+q56P4rppHIghQSMR72BuQ9
	O/XYo9Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1pKW-00000001BV8-0sWa;
	Mon, 07 Apr 2025 16:28:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ndM-00000000ltB-47lu
	for linux-nvme@bombadil.infradead.org;
	Mon, 07 Apr 2025 14:39:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=Y7eFcTw1BBmLsXfJBPUwIPNdKPEmqoZIDDhrBsVYvns=; b=gSZHoa0ezk6UYsNe1LGiSZlfOm
	QGDx2++g8/EjhjYhlZAMzj9rR/V7xY0lVe+UbpoZWfprqNvGEEygyNigN4m1AMuAMsuazLZFI73Ys
	QjsRqjk4I2KZBq1Xk9tpX/5efs4+n0plZoua/Jo4QnLhD3oxlpC3QKtt24QFQP/mdbbcWIXKNfkAF
	V34VKO+B/GgPiJUMUE5L/2vg3J+3XYfw0iAmhaJmJJBPp0KYDGtgNXeCmyweBqKGntvT0sJ0JUFKv
	GhA3W3Ff0MROAcg3WUpmeK0sDplA/txPIHWxlGsBnGgptpXYGvmfGf6JeQbyWaO3m+nBVkYWXdTDZ
	9fbNiw8g==;
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ndK-00000007zWk-0pVM
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:39:31 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so2756700f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Apr 2025 07:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744036768; x=1744641568; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7eFcTw1BBmLsXfJBPUwIPNdKPEmqoZIDDhrBsVYvns=;
        b=zW8IRa8RU4njgJsguUmvjxQZOX6q02jQx+OgjlY8RbR5S7N49xuu+d+QrpUt0uaIvm
         h/AB3oguhAWgpd0l+aXh8S7kjQdW4M1KamqRRixgKrGWJvyCmGT3bfoAodUaiFiHzKBH
         7qMfuiOlEl0yPPPL6X9Eo74LRShtPnubSTEIbkkZ2ZjED7mpZuJtblK2U0lrVX3LYUfs
         Vh6SSKSgbj/v4A8UYDtOBMTW1FeLLEa37Waxu3/bFl4hi0sqku4vXCC3PXArftnTTNm1
         HY7Y9oQkuTdHGGe9xC+lDykPIpQKHOEIoYIZYHWetSiNpuI+hT+oGHAwPPjognCCAhTi
         3nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036768; x=1744641568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7eFcTw1BBmLsXfJBPUwIPNdKPEmqoZIDDhrBsVYvns=;
        b=T5AdLUptEt0HHetJcr2S5IKo7MA0l1APsZ8mTDq9Ogrbxb3G78YK/Ms/yhnReyTWau
         1WoT/x3E24SakRiXglv6pdlJwoF87EHYR47C3xpTMw3rcT4r1Ad5FzYMpqqD0COJkq5Z
         8nbMLMDFAhZ+5iZOtTYLk9SHvu5X4KuOMo8X7r4ec96GleejMqoiu0FSD9kChnOJBGQf
         Ugp/7WacHVyIpirBI+3dhblSsRfAvEOyxTgKUvy8xw2U+GQqwnq0Bg1SzpfdaiDEQisr
         TkunRhDHMLorE+m2vt6AGT533lhG75fDL1FZIR1YJzyWwvTS5leVP8U9ZMW7kltjHUAn
         jRfg==
X-Forwarded-Encrypted: i=1; AJvYcCXuJWQMll4DE/SRzR3rYKvt9FoNWUPlPW3y+4zCN/kybHyIo51p+iZ9PyNo2dTY4ot8oKrUEKPF8zQl@lists.infradead.org
X-Gm-Message-State: AOJu0YwuW1/ksipIOO79lmOsVyepK5qUeT7CJqMYMePy0/vc9xjOgjOo
	YC+wFtHHMTPTQjTnUAq4SgS3+gxBBX3Tl4dftIxPqDoOS+m0l1AMEdQAIm2Zppo=
X-Gm-Gg: ASbGncthlFNoC4wOTu5PSgNFsK05yAOVrr3/NndxZFy8LdIHZRvfd0BKhtenG9XHG1g
	kWx3j2FoOEoXpI5OOiWjyBGuHfJ0G4/4wM6dqxx8hqyO7Msoe4DeLAycff/veu6Mh4LgeIT00vU
	60pc22gAjKHcgPXPmTtlzI+fx5LEylwSBuE2UDFyLsOjwCk1LiB6fNjVg2irQ9Pkg91rYoPOeQ2
	8diq6U3+UJfpSJWENkZrkeH4oa5paHQzHfYkApu9VRWT9GVjiZ20LK/a835wFWhesyceUD6mtj5
	msqA0TJV082C6Y5YbuJw2xm2uzbxrci+oNKCLdVUQMHrl1xxSb92Rzmv0kI=
X-Google-Smtp-Source: AGHT+IHz+UHcCsUtEEJhgEfJlAKbScYm9TcMULxn6JxZWVz6GKeQRERIZCltbN3u7HtrlOzoRjNl/A==
X-Received: by 2002:a05:6000:188f:b0:391:3915:cfea with SMTP id ffacd0b85a97d-39cba93329amr10771859f8f.38.1744036767753;
        Mon, 07 Apr 2025 07:39:27 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm135003705e9.9.2025.04.07.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:39:27 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 07 Apr 2025 16:39:08 +0200
Subject: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling when
 allocating space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3212; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=n0KkujYCmFsi6TCmOtVdMu0bbfrL6UkgnMn4aw3JxJA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8+ObiJpvdYB8bsZnZVvwp+QDS1VlGg2pjvZVF
 AG6RByUfqeJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/PjmwAKCRDm/A8cN/La
 hb2MD/0YQhJLrOZ76T9VTuUia/wCoGBX5EMJnYssupmfuh6Sv5QSaTs5/1bOLyHR64hwp4rgcm+
 NQQxKNgHWHakJNxR5lQGikqtiYKuaVwsAaso6mWmgNsIhumgjAeOhSfpL/arH0zfBIImA/h5Orf
 0YlfqljnT1Ap7yO6n+CLEUK1KkeH0fsk3Hs2O/AD9gtT+ZAMceneheK4VD64dcSWLNU+tT12nX2
 3WcV+F8Oe6eRpjIsyIF56/yFrgAkzM1B/k8ZFqOXDgFqb0aDMH6COVKwSGkdbMyZ1wV/e3mvI6c
 1kZUS1LgH3ESB5Cak1EG+0JZehGnJsbAecqLXxhYNYfyctcDx7cKjk16L+8z3G53VdIHWuTjP8s
 ZxV9TLG9f2U1DZqtudDIwqXX61MNL9Igqvv3co8jizpNIcjM0kTjdFDUas0OZ+nWL9bWtwkohu0
 sXb7xs1tIVyZQ6O3YD22HbpKfpVknQ81WZ3KicMRZOfJ22FHxHxF/alKA0DaNVFBu8efVH6S18/
 pB9RFpc7R8STCGyUpw5u/7UTiXBftL8XarGnrqvwWJ2B8OBg+te82ctgTKFJGGlrBMRHSnnpIY0
 szjPrQuaWsLGEXgGozut/BhnEuMKPPETZnH0PUVrGeGY2cezR2MemHr/dQmI15mSXO7s0iEihfB
 NCY/lGk981j6SYA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_153930_393233_38C73952 
X-CRM114-Status: GOOD (  18.13  )
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
requirement but save the size that matches what is present in the BAR.

Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	struct device *dev;
 	struct pci_epf_bar *epf_bar;
 	struct pci_epc *epc;
+	size_t size;
 
 	if (!addr)
 		return;
@@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 		epf_bar = epf->sec_epc_bar;
 	}
 
+	size = epf_bar[bar].size;
+	if (epc_features->align)
+		size = ALIGN(size, epc_features->align);
+
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].size, addr,
-			  epf_bar[bar].phys_addr);
+	dma_free_coherent(dev, size, addr, epf_bar[bar].phys_addr);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
@@ -266,7 +270,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t align = epc_features->align;
+	size_t aligned_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
@@ -287,12 +291,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
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
+	 * if, for example, the fixed size of a BAR is smaller than align
+	 */
+	aligned_size = align ? ALIGN(size, align) : size;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -303,7 +312,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;

-- 
2.47.2


