Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D46C369A1
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pxPRinaB0R9MRMHkqtzs6Jksu6ZEexxFz8Cu5WJ1Zw0=; b=IEwwpcgvKQeGE7zYg8cC3tWkj+
	h8Eov26IxRzy3s+n5RH6NsdL7WGE58/Hj0GlzdS/xUysPXKB/RFiCWLbZyjyBTxl67UHfzccV6Uzl
	fVGKTWHR0g9fVJWwYnPk56z4kMuQZXvScF8elLhPCsO6J8T92U7D6Jxbuu1R9zPjWxIPw5AsqoKWF
	R52DfL7m/YPReSjNIQWpOBQF2H6UdkIYUBJhCMz/y1MQDUEDWl0/+Gfn02wOux73D0b8IL2bO+ij3
	aLQcxLX1hYw6SLgwJwiAoE61r1NixR3uSpy4cV8thARnAPG9kNG879D7sRnUprbykK4OWhrOEt6AJ
	wNPapTHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1r1H-00000001V2t-39uN;
	Mon, 07 Apr 2025 18:16:27 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ndK-00000000lrv-46IP
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:39:32 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so22826205e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Apr 2025 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744036769; x=1744641569; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxPRinaB0R9MRMHkqtzs6Jksu6ZEexxFz8Cu5WJ1Zw0=;
        b=gid1/Yp3VHfA1jCDVOieVLIUsMKYTjt/Ozry63ElPjDpuUtYAFzi1uAtRZBL57OaSz
         dOD/8WxoREUjjP/SQ4wwjm7U5+e4jUfNb0k1dNYGXaQ4LL/5MJIzTS//bMvSa6CxcjnI
         8d1PuxVZqV8RdmW2LPXxxjgUveppyITdItIPPApdGiHJYxJ5VBd3GSIYVRkcroQqMvRn
         qTu/tvmgPOsUE3ig7AyohQPJKZl3Hr70RuSiHhhBetl3VW2NFOLI6KkLdPq6ToskLJAe
         OOyJezRQXxF7//JaaUwFwKfhroxovh7TK60dVhkKgnIBs7elWRi5tXm7BUFrIBuvO0n8
         SRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036769; x=1744641569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxPRinaB0R9MRMHkqtzs6Jksu6ZEexxFz8Cu5WJ1Zw0=;
        b=Koe5mOwNWQ34JbV1RXglWXQLoyDK6ObNvtyiY+flohdi1ML4gDMa8V8DQf5XL6tmx+
         +WkH8E2t6fiEQLruzYjPvqMkDCGy6NUAqIGHmtoUp501atAR6ZmlcmlTkSqR6yG4sBL6
         Wlipwivru6O2bsDWekJ2Bs5kB6sbh+sVyjNSIrIaKOXGaQBlK3WWrmnR/ql83cR+i6CL
         u/gSCIaATLRLITh5hnvfSU46oFAmKUaJMT3W8YfdsznDyRLfajLSM2p4xNl5qECv3LUD
         B+hTDLVZldKWA1Wrd4dhIJqByKkvBTmKV4f5zDKJ9JQE+QJXd+XrbUVYcEfBs/p1T/l0
         TIAA==
X-Forwarded-Encrypted: i=1; AJvYcCVvosBpCRVD6PcZ1TkkqISiyfOf7ALe8bf1gelLmi3qlYsO9VLEvcSkwPNl/mwuxJev6MHrgz488mgl@lists.infradead.org
X-Gm-Message-State: AOJu0YznA7witEqexOYFjfRZJZeyPprdG9EePk6418M8t5yY6zE0jOtY
	yhE5Cc0Be2vtagD3tuc9eJc/RX8P6vrJ2HUHq6VwKSukWepA1Yv9tjyAobueD0o=
X-Gm-Gg: ASbGncuZuTZT+txGFK56JTIFgmZX/NmyzVPXT24t7yrL53mbeWTpYMA9fks662dwUlg
	RxAFn9Ofh5LUV8b1KfCz+03mE27thO6eMs9xL97tM/QjHkqRBR+7DDu0+2a/qNDD9smvAkg7MWJ
	45p9eFp3JulBT3d+czXtoIbTc8h1yHAgFDILwVlsvB7cEN4kVLwpQuCIa9RsJeNabVrV2EwR3+u
	3x+RHyIQSTlyDV6roX9cx7k1RDWsyy91B5oWxZZU89QB8IahyDSQBD3iTlGzYzc3G2MJEDta7Wx
	oRnflqfutPX7CRDP2D0H60T6/rio/LpDERkxyF/Tlrl3x9YkIAifEwFoW44=
X-Google-Smtp-Source: AGHT+IEubbxZPgQUSRZzvvQhBmDtFalBkcWkhDKsJzJ20didIoJnFHLspvjPaPuLm6u+H9tSSj/f+Q==
X-Received: by 2002:a05:600c:1382:b0:43c:f8fc:f69a with SMTP id 5b1f17b1804b1-43ecf8231a8mr126309295e9.4.1744036769270;
        Mon, 07 Apr 2025 07:39:29 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm135003705e9.9.2025.04.07.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:39:28 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 07 Apr 2025 16:39:09 +0200
Subject: [PATCH v3 3/3] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pci-ep-size-alignment-v3-3-865878e68cc8@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=VMQRvj8CO60hVIlMMgdkTE1dtBACF+fNeO1bhBVnQsU=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8+Ocp5qrU6t7BkdRqC40BGTRhG7GQXtWTrTgD
 yIlZpB1YGOJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/PjnAAKCRDm/A8cN/La
 hWRHD/9g//XvxSZqH7CmO0Os/k5ApJ/k9nXjmH7ZssT55T/YPBza5Ck1OyaluYJjja7C9k1gitK
 Wjln7OTMRKwA0VzH1g1UDleQkt+jb1NBdtHlx8jupKsX8zyjnDaZmZwl7jjNpRxaFw+Wjq8MUg1
 TjpNZssf3Q4kG3iqg+sqziIgeUCk6Xi4WHBlqNolxkkqUSsSRf2KWk8tUBDA+EBPv+/psSmdfFC
 dBIjEtm7dsQoXpApCzIV1+myZh939mnlIPuh/trWJ3dIglJrl6XT5x9tBm6+Nq/cPRfLXHseEIP
 ncliq6apj8jXQMgKFD99eYT8ARDSrJoXhbXhHoHRMrZxmCCHCcsgFXcgovDYLsQWXQRwT7gO3mH
 wGW3a4D+6XUxWihlx8J7UJ2xthK8ZAstsSOdJUXwBkXui6lHUOr+euZFVK43ymcFqfxtqQT2hjR
 nOljtrKlt8MLWFPLORpH9PcYcdzp2lTTRgA3GBzMg9f4tB40N3x0oEUUXpRfWWMDLQFYzQ4J0ay
 hfC7zFLsq/XX6YZbAZwG30s+lL+dkmODzrVaBXC6o//nyL/U0ho7u26khB//KhdPuSPeohl/NZS
 YK2cDoltbNR4i94PvtU86XBOfMK+F2OsqAlsMja7w1OfMEgkZijdiePOiY9asNzKvoKZptEVXPc
 Anao+OnAuOocI/A==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_073931_012004_6664CB59 
X-CRM114-Status: GOOD (  15.50  )
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
index 8f59a5b9b7adec2c05eebae71c6a246bc5a8e88c..bc4a9c7c4338db6cc89fa47de89dc704d0a03806 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -413,11 +413,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
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
@@ -427,31 +425,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
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


