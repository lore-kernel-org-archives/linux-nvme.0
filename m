Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5208FC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=; b=K9fUwWOt5A+AML64OPJF2DL2M8
	qLPzMdlz4LZxXx0d5tMIfILjdsaBKDKrFS37mX+0scPxYvifXkjxuQogoHYT72xvGDJ0dkIby06qc
	L0vrgLxTSd9aA6oW4WA1J9KK6l9VE4t8gjIurJ2cRjC9OeLPW+4qECmEBIopT0MCR0q/WuxlZocrq
	Dq1zcybDN4mGJzjrH1N6WkC6Jr2KsdlNh7mz0aKsg2y8PHx0pxZMfx8mtNah6b5aMpcof7vsxjn6X
	a3zTJQt+psXmFtVIE1IupsNTTwylCsHK9qNjjiR+mJ6TV6PEkMzqFsJWq4EC4JHjyPUAlDsOIH3pg
	3Lt6XFwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GYm-00000007vKw-2L7c;
	Tue, 22 Apr 2025 16:33:24 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7F1B-00000007a4R-2gYi
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 14:54:39 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso44143595e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745333676; x=1745938476; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=hQzFx77DsGl5KD+Y33LFa3ZTordDxjNIPBeqau/3Au7kZWQB6kcWcoKSHcUUbDaayG
         E0W6Idnr2Wv9jJ3MdyItYOFV9XGD8u9kBMMgn0ZF2SaLdUQQHxRVUvPs1z7uuuhlHoe2
         ongZYfVNS/HLtKy4QnM/Ki1B74DtgPHMQOrS2DJsUj4tr+8YWP2wxDIHHRNSwF1rmYxW
         YagKdwpETRgzQLesVeBYx4MfJ/GsqRpxTay8P6fKzpZDRMSS2ld5PzhjJNM49rF7FJNm
         CW5R4vfMBdqFxuru4SSFkPZc5DHj5iT/xsuO7WA019C+Nf50Ie+AVFMypBEnqILvFx0z
         NLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333676; x=1745938476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=Ld98WPliy5OtwBXZPV81/DX2G8QcZtdmutaEyWUAT5Pu/TXFE/A9a0Ft0RPPldvZUt
         5O21ckwzo6Txz4h6E3FI33C8r3D26HI9HzF6peJVKxffhJZSbPzM08DcI5lMst0EjMfw
         QwudBEXxdeIXssAlC/6AGQz7PR4usMz02YsSywIBl3PIt9/VUxvrnm+JRGviFs3asp75
         JY4cp11Z7tmDS8ERwoAQMMIROzbApXbukzzeiM6HGwFh6jhTY7ASacL/MHbqmMuijuYj
         YDV37m8QMO/jHqsEnIlQcGWdEidvagbaDf2APjTgsodcLCpMAVZeThq9kSg9ysLZWgqh
         11mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWujeG3yhStojTxptt80+0zRYnjd98smm2I2Za+uPkYflib038m4lmXU8aDebRYmlmxoe1YkDy1a9Pa@lists.infradead.org
X-Gm-Message-State: AOJu0Ywnkpk6geK0wO4eO0l34/9R8nA53cCC7LAWkryZhleXe8sL9PAT
	kR0daV04I+dtdionBGPr2pSEnbaZ4n/LfmEdTIr/JE/TPCD0Svr0Qtc4LnUVvjQ=
X-Gm-Gg: ASbGncsPgaPq3ybKYSZsJNV1GowXdAnKdAZfwhhIbBmXW4j0cambUzqgPAFKcIs5c0A
	lmA+8tmHzLv0z8rK/3YGwBU7u3nDEPpkRNNqt+n3Gp63SSwKArq4XmTqJfO+/lRr2C6al/gb1LX
	2prKmIawOOdJRFpNB8Q4EfBqB/9NIjMK7VZ2B/CgvnbftJXPmpP4y95HK3YszJAkSESEkyWlVjK
	3S2h9gQjt+rmfhulesFtQcoiAYdm6ls23dISJK/9oquUcDaFYfaQoLI/+vnOE4xQmeyhM+FQr2M
	yvJ/ReTiaw0hYqe74Doj4qkuREDUyfoYTmsvoPJTrn1WuGOtfRxUt6E=
X-Google-Smtp-Source: AGHT+IEHe9ogthRxFY7pkZ9zNymwt1Ec/5ZjUlqRd9V4GcqMYQk4PWKK1SwQmMeK1MT1bv8SF2U33w==
X-Received: by 2002:a05:600c:cc4:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-4406ac0fcd2mr156057715e9.30.1745333675957;
        Tue, 22 Apr 2025 07:54:35 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:5f77:7d42:6228:3358])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9de9sm177304635e9.6.2025.04.22.07.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:54:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 22 Apr 2025 16:54:20 +0200
Subject: [PATCH v4 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-pci-ep-size-alignment-v4-2-6bd58443fee9@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=vNv6q0bb1dhXpfiDx4lYdoPPd0v2qIBg86Rmq+6QIeY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoB62oAlm5zh6kLkXaBtIcf8aDVYddmeLBSWeQi
 XhVglIZiCmJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAetqAAKCRDm/A8cN/La
 hSkCD/wNWHhJ4cR/8B3D/R49ys+RdE4Bbqm+jlq1I1CdaFEvLvfu7zqcK2uUCJgEHB/iD/wAKW4
 QGXnhdnuRp6wbcUyqTwLQ/Sph5gS16lt4f0Mni38YYbG/dszfdh75UG42nC6cMc3ygrbCgIzmuG
 lNNawfVSwxxU+D8jPu2Snhi0V4NvlAimuTUvhDkcJfzupu6EoFb9dteMt24N77VXLZG9hP0J26+
 ncsj+RGbYB5clw4CHgk1LgF7BHcHZ/QYRHAfuFqqOcRSrbIQtWsGwPFge8FxvkoJ5pulSf6gtEL
 mWmuOlrToxDkaDqiNTHUDrT/GvKUiSMsfA+zTlbv1oW2bQ015APm0g21MAucgoFLwYX0YXjO7Jy
 MNu1zDU0m+7fg1f09LfG8uubUEn+Dv8Dpp/yYH8v2x5Pfi0ZPFqlXhk35ynAj2G9YbrqarOS5XT
 ykQasjDllM+ulO0ZEQNPZjRKPIa52MWyjOFPloc1ylwcohyQdtUg3VgEmZuSnGvpJmQtOlrJjD5
 +eEMrTMDgaancCIC3bb6CYWs8bzq+/ogx40Ki6dU+9B8Q2YdeYdchCXR/Huo1mXmf3/nNzMEY2F
 6eO1HQ+BhCB95bGVdzq8Wt7N4mjHvC0RkvtCqEBoMq0Vyi+4Hvpw8NROfWKnlVrndqFQFmXBo0S
 CqNTm9baZl4Azzw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_075437_685752_86AE0295 
X-CRM114-Status: GOOD (  15.62  )
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

When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
should not try to handle the size quirks for underlying BAR, whether it is
fixed size or alignment. This is already handled by pci_epf_alloc_space().

Also, when handling the alignment, this allocate more space than necessary.
For example, with a spad size of 1024B and a ctrl size of 308B, the space
necessary is 1332B. If the alignment is 1MB,
epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
been more than enough.

Drop the handling of the BAR size quirks and let
pci_epf_alloc_space() handle that. Just make sure the 32bits SPAD register
are aligned on 32bits.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..e4da3fdb000723e3adad01f0ddf230ecc0e572a7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
-	size_t align;
 	enum pci_barno barno;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
-	u64 size;
 	struct pci_epf *epf = ntb->epf;
 	struct device *dev = &epf->dev;
 	u32 spad_count;
@@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 								epf->func_no,
 								epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	size = epc_features->bar[barno].fixed_size;
-	align = epc_features->align;
-
-	if ((!IS_ALIGNED(size, align)))
-		return -EINVAL;
-
 	spad_count = ntb->spad_count;
 
-	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
-	if (!align) {
-		ctrl_size = roundup_pow_of_two(ctrl_size);
-		spad_size = roundup_pow_of_two(spad_size);
-	} else {
-		ctrl_size = ALIGN(ctrl_size, align);
-		spad_size = ALIGN(spad_size, align);
-	}
-
-	if (!size)
-		size = ctrl_size + spad_size;
-	else if (size < ctrl_size + spad_size)
-		return -EINVAL;
-
-	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
+	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
+				   barno, epc_features, 0);
 	if (!base) {
 		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
 		return -ENOMEM;

-- 
2.47.2


