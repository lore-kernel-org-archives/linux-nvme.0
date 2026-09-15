Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824E4C88E75
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 03:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t89rpHiNw/rNyrb5GPmXpT24rGMM1iH3V/Eh470//LU=; b=ASL5iJ3NV4OVJrqm+6qLRJwNOd
	jlEHKR3ikJ1QFwiNuD/ncW0/0yRkca86UI/lY4vJzoO49C/inCa0RVvxw5sS2rLTw3PlkhYQGDY83
	xUmLjHUpRjM+yxiGXH1Xgc//6qAVkght1G9C50KWVZQOi7gtv68oacVcidNJq5X50sekrm/uQtZU+
	sjNKvC3m2oFfihFlwp3Qo/rSWCDSplQSV4ZhU4uoiVRFXMYwzJqc7Nf5TqKt3es290ZtSPdnOiVEE
	PTUfGGeFIdVRGZf8vT2y6MW0KayOcIE76ujb5RCM1IxvWewrdCpG8v75rWzDRxruyzdduk7XVxf37
	7hFG/dwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6KCq-000000059gB-3s9G;
	Tue, 15 Sep 2026 03:51:40 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6KCn-000000059fe-3N2h
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 03:51:38 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso5864447a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2026 20:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789444297; x=1790049097; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t89rpHiNw/rNyrb5GPmXpT24rGMM1iH3V/Eh470//LU=;
        b=ldAhIOfp6qP1s9wDy5hIDvHHEVzQ4+v/YCzMu2SBHtnuATaW2Q/M9iH+LNn3hgY9ic
         lHdB3ACVwXGc+WPaFum7uxtWAHB/ECvemTHf44s3puPtuD8bG+6FCY9FmbayK1fAGlgV
         gXDgNqHAMQHb1NvJoo09nsV/Ys/yAnXITp4x/Uq61/ddEPGuVxsKgW3sLAN+u1CJlqFr
         ERPtZ8skgXP9AMnvfL8TfEga9YdbrQsqtCOgbFX73DDwR2T7Q6K0nUMTyMZcPi89khXj
         iHAaBiBH20PCDdlk52KCBgKXDtQRYUox2XZDOC9UE6zxf1vrn8ENkItoIugTv43ueroT
         GcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789444297; x=1790049097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t89rpHiNw/rNyrb5GPmXpT24rGMM1iH3V/Eh470//LU=;
        b=T7lGFqklHycoPBnEHmXKpgepJyHevz+ypx5vnHjHArjS+iUEQe4dgUWHHtsqJteMbu
         KVJ7Tay3MmX2pZZgXR2v222jmulfbw5qD4vzUf3cbEpaTVCJL1iiQFOr4p374MdE+zPF
         66m+WkQYYfqefRDfpIv8gyauY0i1CnLuwpvUqq9SsMQNy7aKdVlAmN9bg51ZZBiE1RsY
         3Af5T4IJqcw2Vd5Buf42Rm43g2gg1HUGFYSMWpwz23BwZPMOD9kP827QaQLSg8WsoEuE
         1kT0lYddCzVjzkvP+LIIj+maxiYaf1/TAlhk1EQH08CRTeGNZ35Yi7PGUSREKS3MJC4A
         xp8w==
X-Gm-Message-State: AFuF++mT6ihIOheBUuICpfB+Pk27249tIYrqh7e2H6C4bbKnSrUC5nDD
	TLyANzXmBV9ej9ySucknoc1jeDieFDLT9hnA9ZfBscXFXx9mkF+tUdEO
X-Gm-Gg: AYBFou2FtAuybl9787zQqxyhMSP1SDH1w3y7bngGHQMjs8taDG47RkIP0fh2Olp68hv
	oiaDrvM4dR5VSEEOSOfwJjYZmh7XPtIqaMoTlo/epGISIB0DlKXLca1affqBqe3nYALnW2LpQoP
	8DySngoJrLVolxeoEFMo6B5/a4OkdPv0p3wgUGwlx77sP0l+EUeNS0spfPmT4DrEr+xQmFsa8qP
	0qyOnwgjqvcXJfPY4e5Pt8pPzH/oHbAnMNG2Q1ZT7e2ClUf7vYFKA5+il1SHxfCqJOugffstabf
	uEMCpQ9JHg10T3vhi4iJ7iiuuodycx7nDMmVa51MrkQLIC6M4/UdxdzrNs4TBQNYHO9qKjgTRKA
	Xosc+I13UMX8VpJNj72SYf83FHhdbNrCHvICyT/luBiikuifnTNW5eUyZtiPgynn4YNg05g3NeX
	vRafeiQ6a0diTAi6WS6dbDI0NjKnO8qII+KFNK/ST4ravB3MGdrLJuN2td1+VIkqSQE/qMsIAqN
	6y0jw1jQkY=
X-Received: by 2002:a17:90a:d888:b0:39d:f5b1:e365 with SMTP id 98e67ed59e1d1-39df5b1e47amr8246438a91.25.1789444296846;
        Mon, 14 Sep 2026 20:51:36 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd7545asm2389935a91.14.2026.09.14.20.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 20:51:35 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: pci-epf: reject too-short SGL segments
Date: Tue, 15 Sep 2026 12:51:23 +0900
Message-ID: <20260915035123.3792935-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_205137_865987_C2173C9F 
X-CRM114-Status: GOOD (  12.32  )
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

The host controls an SGL segment's length. A nonzero length smaller than
one SGL descriptor makes nr_descs zero, so
nvmet_pci_epf_get_sgl_segment() reads the type byte of sgls[-1] outside
the allocated buffer. If that byte contains a segment descriptor type,
the function also copies the preceding 16 bytes and returns a negative
descriptor count.

The read was reproduced in 3/3 KASAN boots with only the host transfer
mocked by a KUnit test:

  BUG: KASAN: slab-out-of-bounds in nvmet_pci_epf_get_sgl_segment
  Read of size 1 by task kunit_try_catch
  Call Trace:
   nvmet_pci_epf_get_sgl_segment
   nvmet_pci_epf_short_sgl_test
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Reject segments that cannot hold one descriptor before allocating or
transferring their contents.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Affected since v6.14-rc1; verified in current mainline 587858367581,
Linux 7.2.6, and Linux 6.18.52. Triggering requires
CONFIG_NVME_TARGET_PCI_EPF and CONFIG_PCI_ENDPOINT, with a PCI host
supplying an SGL segment length from 1 through 15.

No PCI endpoint hardware was available. The fixed KASAN kernel passed
the same test in 3/3 fresh boots. Reproducer source is available privately
on request and is intentionally omitted from this public AI-assisted
submission.

 drivers/nvme/target/pci-epf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 9c28367435a5..c683450df422 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -978,6 +978,9 @@ nvmet_pci_epf_get_sgl_segment(struct nvmet_pci_epf_ctrl *ctrl,
 	int nr_descs, ret;
 	void *buf;
 
+	if (length < sizeof(struct nvme_sgl_desc))
+		return NULL;
+
 	buf = kmalloc(length, GFP_KERNEL);
 	if (!buf)
 		return NULL;

base-commit: 587858367581b9c55c3690f4e63382ad622719d4

