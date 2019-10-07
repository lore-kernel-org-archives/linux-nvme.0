Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4646DECE58C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 18:23:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF9F206BB
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 18:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rKWqzdmn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4SwKD8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF9F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sSgSvAkm13FanDrfRY0uw7GnpxuFkn6ml2LwO+b9muc=; b=rKWqzdmn7qL+QR
	+/U+32VKyG+/MpeTq0yP6xdQP0OGYToHJns6y3UnR24+vQfIEfz10ACC9uVLrUr2IcXTI1xneME7j
	8xCaeBNrt4FP+pXPJuDmZmZ2HXE0qlcl+7lKZMv2ylj6BYg8BA/3A/08uPW9oYirhp96TACafggvD
	NquNz6RYfunN76pdTv7x9HYi4W9x7nNf8RtL7O9HO6+V3bmNMBHyf34XLzyqjkIQx9pAuW6XyCY62
	oLcXOQtuNwfs0z7f05lFDJDUia4Tw8zgbRihv9xRSiYXluiAOuqRzy78Xg9fX8KFd5w20LPW/NVvA
	G81eHMTknvU26xOhgMPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHXeq-0001VB-BP; Mon, 07 Oct 2019 18:22:56 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHXek-0001Ub-Sr
 for linux-nvme@lists.infradead.org; Mon, 07 Oct 2019 18:22:54 +0000
Received: by mail-wm1-x342.google.com with SMTP id y21so508009wmi.0
 for <linux-nvme@lists.infradead.org>; Mon, 07 Oct 2019 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F8hWKersFeHg9eqtE3+Pn3KG+DXmZBGYXXT0QmtnqQQ=;
 b=c4SwKD8L/0g9dMQKprU1VD6TF6JxucoZPytknuteRZl4yRQ1+3KtBD8dWvvf2dUdIo
 cIBww106vcoyN9nTFt9TIqFDVah3fcIRZ6h1VMKT6wPtvfwjHKUqeHaFWi0/QyNxDdGi
 S03ZzlQREVtS8/3Z/khoyxol9DtxCPzBcA+oBgeI/qyQEHdMyZyjH+pUBq0OSHes+4G0
 i55GxYrh0HcIA07KUJVBIi9aUJAfQpqyZMyc1doIrJ8Q9ZnskTaLrDYEJbUCwgOOG1TZ
 axPkcMkOWKyAeNlcoCnPVgqwTgc7JYT4dyOW8hll3pmwihRXzUwimPLNEV8FfCbCJKMm
 cJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F8hWKersFeHg9eqtE3+Pn3KG+DXmZBGYXXT0QmtnqQQ=;
 b=hI7rak7861Vfy9Xq5WkI3KqDTTKCO0mo6j+fVBj1SnN3Bb5i1Yl0J+BHARVupV+ETL
 UERNKOWmQP6f0s8p0xHchssESsIiXimZTEKEJH8rwa9Pd4rAttMSjub9rMt5+J/AHB7Z
 K28SBodWBnVCsjT5w9brQKXrUCdzQbx0Kmv+9+qsh0fD+V5ImO6wR9a77Vssw8l8aFhF
 1cn9wOyKRSc8N4Eo4kP4dINDmGO1l7lUZ8aj8S5s7cbPdktP0/Rqhtb41GFa6bklx0+P
 oUvTwZxJUWGUOQj+MY/h5cJquED1N+Yr/LCM3178EtbXDW5BmVWOiyo8aIUTMZgDeeMz
 PyEg==
X-Gm-Message-State: APjAAAVSdTqynFqTQ2aVsFkzsiprCkWeBAK/4SjG5WPPbymnGsrO3+iR
 SYgaRNsxLqwU9A8Iinf/o+PIqKmiDG19ig==
X-Google-Smtp-Source: APXvYqyM0ZI4Ob+B8NR2wzj+a2TyFjiayENPr1cPjXzh/GO5s7L3l3ICe/EMaGKtJMFKmLl0hLPqww==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr513314wmc.78.1570472569069;
 Mon, 07 Oct 2019 11:22:49 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:b1a4:3fa8:62e8:b8ed])
 by smtp.gmail.com with ESMTPSA id 207sm579400wme.17.2019.10.07.11.22.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 11:22:48 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v4] nvme/pci: Split 8-byte reads
Date: Mon,  7 Oct 2019 20:22:44 +0200
Message-Id: <20191007182244.8516-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_112253_304956_05E51D3D 
X-CRM114-Status: GOOD (  12.83  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 ilias.apalodimas@linaro.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme pci driver had split 8-byte register reads using lo_hi_readq()
due to nvme controllers that do not support that sized access. This
behavior was inadvertently changed to readq(), which may break those
controllers. Restore the previous behavior.

Fixes: 7fd8930f26be4 ("nvme: add a common helper to read Identify Controller data")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v4: update comment and commit text according to Keith's guidance
v3: add comment explaining why we need the split read
v2: drop WARN_ON(), add reference to commit that [re-]introduced the issue
---
 drivers/nvme/host/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb88681f4dc3..3fe0c5185646 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2672,7 +2672,12 @@ static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 
 static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
-	*val = readq(to_nvme_dev(ctrl)->bar + off);
+	/*
+	 * Split the 8-byte read into two 4-byte reads since all controllers
+	 * support 4 byte register reads, but some do not support the larger
+	 * access size.
+	 */
+	 *val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
