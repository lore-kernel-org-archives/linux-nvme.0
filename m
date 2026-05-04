Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D67ACD3423
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2026 07:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gm6m1wujkpVy+Hcw4q5fPcV4BPjffKbhoOrFuvKhczI=; b=Db9KAyElI/VPkQBtcFsKYgAQMS
	kvR7ypt7HfegzntpX9bAGJGA4Wu/Qh6me0zQJj6HnvmvKoqWEw2Mm+8N9DUYzr5d7QbGMt8uXbrKM
	/yuN3wFUpySEMPxkjOLdG+yCJESi7iLn0VqXv0zRvBEZcJAH4D3lN3Aj0+fS5ElKuJI671cw/ANrI
	AACw3bNTFjHOc8W8U4nDi31xTlK9rHuGbQ4pUUd2cHvSRO6nfLCvO4fSHRhItC52Xlwe+wXVdYo2s
	FRJTq2XDgSGdoa4QwB+5VY6eN+WxrNTsicEOWrZ0dAhA3MRsAZtxhpskVj3sGKYi9+5oHlDux5Lbo
	QZ7uJQ9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJnyz-0000000Cdoh-2Q8i;
	Mon, 04 May 2026 07:44:49 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJnyw-0000000Cdna-1kyG
	for linux-nvme@lists.infradead.org;
	Mon, 04 May 2026 07:44:47 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-43d77f6092eso2180486f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 04 May 2026 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777880684; x=1778485484; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gm6m1wujkpVy+Hcw4q5fPcV4BPjffKbhoOrFuvKhczI=;
        b=G+zPhDT9JIXRcEh8nkpEeQ4SklfSoTW9IyfNT+7MUhrJ4yNpDJOncOHMdLf3Pj6niN
         NW5JFdM/+GZ1rqnjIYVMNv20DNxkRV/siT4+RrZV0TNBEl+FGKW8ELEWHPKYo8KNfyJH
         bYXtaSSbB7HNmoReZk6QE7ALfm2aotGcMa9/+u2Y1JYB3opy30Ct0e+R3fxdR1+5N/6o
         vOYxZEVG95XzZGNWlBNPHKMIg6XceOtCLF868xFOTwvmChYyQTBwM1cRB0LmDofRRc8l
         9OmcdqFoERBLluqBaQK+Ko+rEj86n8eenOz6foGJOdAb9B3nl5BDJ7rEpuJZj2Gz/1JA
         S+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880684; x=1778485484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm6m1wujkpVy+Hcw4q5fPcV4BPjffKbhoOrFuvKhczI=;
        b=ljXet/m0JSPmG3du24NyW+UH+Jlz0PaP+7xsa+25HpEV3iR4VDlUWsdL7Sto8cw3K0
         N5+ba34/jUY9iMYfprWh1r92L8KhakP1lzosBsaBOxu0A6SAfpGdrB+vt2lnWAE85ohU
         J5dlmo2c0/eTp/5f0hxSJ+lPhzgsm3ZdYDbvyx+04GmUsvQoe2uhI5IIBEncjJlyWhSC
         xux8dNyy9hXLtzRlQJV1IeXvjvbuoDXIMmIwwivAlfckJWVB+D5MzeaFT959FxXVuffq
         jQNN+qSgZkARXPxsyOnseQzgLfv5cqonft64hzU0ZfNTcqxqKH6PEnI+bP14aBX6pQbE
         J4bg==
X-Gm-Message-State: AOJu0YxmpY23nLaKriESheqTJQ9bkL3D7c+cudgcWZrTOjCJqmgKIXXG
	TovEVZn3Gt0s5/3AKuGZX83e0Fap/KnQIjbzs72tjmGf6jsrws8MzwSW
X-Gm-Gg: AeBDiesbBi5goGcFZGWo/9fhtF0K9xrshuV8i4dicPpT7sxYTw9VnuUpVHobdDOzuyE
	GPMx42/iyUr9JFmrf9eNS/DPs0fC2j1Q9irxzczGz2QqwnVcVVsPzWLbtbdTtLLCnQxK6IBijlB
	6iRk80f50sol9Ib9vn6XnW+BPphNastapz0zBvb2/BRQlPEZieZ7TWTN+haGxgST/QUaHKBgpQl
	fbXurw65YnuczV/pwFUI/Q/tq2H2ctbU79WNA2J8ZHSLWR/Y4UzHsfPCZCJwqk3N+MpKdu68qVA
	jqwyZdv1iuijMThjqmaHU+XbHU7Yit3GmxNIRoqrOvdEQQ8ztqTC5gmsWGApNzoFSw4y72YV/IU
	nt2YB3tSfx4H/u5GvX15O8Mo99e6eGgk90MS0abeYKLVWTtRrWg0WOLHliJFzc6taekLx8im/MO
	+e8o6YcW4AUdnjPZeOEkKMgU1Lczrj5Ui1E8tvlbwGtQ==
X-Received: by 2002:a05:6000:2dc6:b0:43d:7e11:1b72 with SMTP id ffacd0b85a97d-44bb2f26f85mr12815058f8f.9.1777880684115;
        Mon, 04 May 2026 00:44:44 -0700 (PDT)
Received: from xyz-asus ([78.211.66.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44acad8f974sm21587062f8f.23.2026.05.04.00.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 00:44:43 -0700 (PDT)
From: Armandas Kvietkus <armundunelis@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Armandas Kvietkus <armundunelis@gmail.com>
Subject: [PATCH 3/3] nvme-pci: add quirks for Lexar SSD NM620 512GB (1e4b:1202)
Date: Mon,  4 May 2026 09:44:33 +0200
Message-ID: <20260504074433.28493-1-armundunelis@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_004446_460098_3A40FBC0 
X-CRM114-Status: GOOD (  10.88  )
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

The Lexar SSD NM620 512GB has an invalid SUBNQN field and reports
bogus namespace identifiers. Add NVME_QUIRK_IGNORE_DEV_SUBNQN and
NVME_QUIRK_BOGUS_NID quirks to suppress the resulting boot warnings
Signed-off-by: Armandas Kvietkus <armundunelis@gmail.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fd04cd7c..f6cc27e28 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4222,6 +4222,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4b, 0x1202), /* Lexar SSD NM620 512GB */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
-- 
2.54.0


