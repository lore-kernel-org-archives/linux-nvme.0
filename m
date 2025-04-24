Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B840C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=; b=SxYh5/pihS+G17TX1tOfMPKPeG
	UfVdXoOrzx4UTNDiMVeYw8FOyMfCyXrTF3jqK8m54mCMCy2u94QwTujn8B/OCoabR5dfJQSvu83y7
	43G7jt84qy+50jNnj3Pfghhm1tBidJwyEF8xqNSQHZA/kuq5abnxtaFW1gHVpZmUZD2CVwdj2gZZ0
	OZ6yxJ2vCMZHmiUQYcZc4M74VLIlOIObN4/7okPnLRnZlnncJzGKY4rWMA8fKSY64uWe+gThOrZkA
	PExUqvv/6D9C1ZNDZwNYzArQKNAZBDtOyHHk9JsSVSIus1FUYJrBdwG+4cyh3vaUV6yjFzWPd1OxL
	BK3n7SOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7t1I-0000000DWjx-0pnL;
	Thu, 24 Apr 2025 09:37:24 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7s2M-0000000DKuj-3soJ
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 08:34:28 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso503283f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745483665; x=1746088465; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=TbKpF7IeQF92HZRULJDWCocUr4jTMby27NkZ38ShpU9IwlfTFfLNbPPQFyQ4wPNIh3
         oEeMbgXHxxgAwaMyHy2ftVCcj/EO/2tLtfjtN/P7DdGIHVmkQ86Q5fLMQRibVQ97pNeq
         7MVr8vbj1y6DdIqEYMUEzqIuO5FynKeKUiyD+xyQG6slr4jGakkRvcvSi7X8QSOxZtxR
         mzvJLa6NQMmOUR1e+7KoW/mRolQoZa4ZDD3rIlADfyG92tIFE2aKVED8Ey0Yeex16TfS
         xBNwij21xQxXsntp9b4c/4EWwsin36htayy2Ku+g3a3bvVnGXXpi8egNd6Jkt8GmxJYj
         s0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483665; x=1746088465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=n5jiKoYAmqjmbAAo9S0mYuEfe2yrAzzuc2VbYm3R5KT+MaIr3YdwuQboAUZXNw6cef
         LOJ3sMiR+7jsVbB5pm1E2lwGIsww6IT9vW8tyO7Wk20yGWEcB7D/moJJWwawSKKw7lx1
         4+NZc+378B1cS9NjXApjdRcHXxH5ewmc0S+Q6CnhEHHfH4j1X7dfDnHHnp/pe6SBBWdr
         sUIgoYX5h6VntfclbCoKSUP/7iQh9/Ld9gjUPWbdseNp13aNWl6lbECMRXukIgLwrwI5
         fCZTtr4r3uFswZKqQawijTxupfdcokFePIXSsiz/cXdNrc2fkJI9E2J2brSVFpdEAOzj
         4cuA==
X-Forwarded-Encrypted: i=1; AJvYcCWC6nRVW4DahDZZJKtMv6WcS1EGskzWzv2OmGa/BpMehuOxavwzIl7tU2JMEj+bkEbmaXPaz2T2052A@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2Vr9TGd4TP7tewdn3CdUUoHGQPAL7194ZJ0mzmpPd2/6a6bGp
	DdsLI/2iVJJtCOQ3i4ReTKw7rlnFp7VLrai0SF35dzi7lt7yMkfMNKX5RyIbxNA=
X-Gm-Gg: ASbGncvbzE5fSHSrZ8sJgrBLn2Ieu7exGsF0Kx47c+giNxP1Y/NQQUAXGklD7H4Vv47
	8E+mtR2/e3m6bDYPNz5Wq+G8BlsCcs6GkffXU2Hx1FsdlrxhPOKnzS+TmP+Gp40fFFu5nG2vjHh
	+ebGqi/BBpZueEIKw22Oxu3Uv1KslNdckOhqKEeUtGxwts0Z2sT8kO2gB4VS5lKlivx+Rv0h0x6
	W/KlUSuMdW2/JNB8XR8UwqLlNX3WTiH7GYZAWhUcpDE2b4km21V01FO92v4ebFV/R4eIL9fQxos
	hKaBn/dVYx1Cb66sI2KUdMbFZEJmZh8fcXfQwcjRlAPdHKdeQAMoRQ==
X-Google-Smtp-Source: AGHT+IHB/1fPMi8W8gNYBZX9ahiEF0UFgajqPwu4G1ECbDegN3oYFc0PmydKXsVY2MSnx6gtJ+HsoQ==
X-Received: by 2002:a5d:47cb:0:b0:39c:2661:4ce0 with SMTP id ffacd0b85a97d-3a06cf5ac06mr1515723f8f.13.1745483665163;
        Thu, 24 Apr 2025 01:34:25 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f74:6a9a:365b:4453])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a06d4c6c56sm1323881f8f.60.2025.04.24.01.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:34:24 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 24 Apr 2025 10:34:05 +0200
Subject: [PATCH v5 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pci-ep-size-alignment-v5-2-2d4ec2af23f5@baylibre.com>
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
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=vNv6q0bb1dhXpfiDx4lYdoPPd0v2qIBg86Rmq+6QIeY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoCfeNM/XnkovbNkugaUgh+qynHCUCtYyhIWFEg
 Mnjh1220EuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAn3jQAKCRDm/A8cN/La
 henkD/kBk6sa7qTps24wEDvGqFqWVTIMapEBlE7MOo2mVVheqN1DbKKPyXp+48xcqqo8mSJ6y6k
 HDSdfWCOuf0uq9OGCHGxshry3J0/RdzHPn70ZRsT9f1zAt3SooEvxkL5mA0h9NWJaQc4Mjmsx8v
 YkjxiCooDpDHAQodmmZoGJf86HQLybBrSskdskNA9w4+4C7FfPOeXl+QhtjTZhPQp0NR8jvPoDU
 ywoj23FUzDHXoarguypcLl731tXJMsbJKYViABXBcWXD6YH8lPE4aooJnOAzOvDL6ENz2hxmDTu
 fTeYO9LgGa+H2WGmZF+cBCwQlgu+Ezk/mbQap7S5qbJHtXplFrNRY38Tph5tRGYK+ruB8ie3bt9
 wFhs3SN9FSwFCe1OWxO6LJwlMu1jSfIFOo4QHqtfOjgnnccRcjQp4o7d6ji51GNYl2GyaKc5XwQ
 k/TUGW7BD2nMECwtXKLcobsEj+dLOzEjnx847/4IpfzHCBvunz67EzlZb7iSypHXN9kpdSp1BVN
 qtgc7vck/211s5WWWYbNvQskBEvB27/mx29Yp4OI67ZQ3qn7Gh99oZQq+IJPU9scrsnwrYepWUL
 Da5yGlyxLBV3u33uJjya3KgcvgRBCXS7Ksg2GJcpcbEqV7euamaxHnV8uiYlm2HlTKDUJP3IV2V
 uinIHWXjuwaRucg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_013426_965336_DA8D3EFF 
X-CRM114-Status: GOOD (  14.74  )
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


