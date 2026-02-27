Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880EAFEFB51
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=; b=lmh4t8lQIfSgJgsdVo6RfG/2xI
	dRBDY0Ixi0MXl32FDDtgEZi2I/Td2giAOMUY+AWn1HOe5c1V4cE2nFbCRFWV1WnvFxKK+KlIVDWnj
	Wt8ceCHmeFuXWmQfH73e+vlo2ERT/A/1plLqlfTfRawICPLQudb3VNaETVje/6go9/LdRwW3uxVoF
	E5ASSG0bXK8bW8N0U8a26LprH2cRb2TMxVBd5b7OF3kb+CGj7db3/R7TIkdQpFg8FmJ+Q4Xp/m5O+
	QsBtZjmH9HOxfhoR1KL9UrYs/+snPjl7QJ0cdslvWDl+qjs9V4jBs12zJcmhhHCHMIlXhc4Dxj9AQ
	e425DH3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Ni-000000096UK-3c4b;
	Fri, 27 Feb 2026 20:24:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Ni-000000096T4-0Biv
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Feb 2026 20:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=; b=q/ZAAHRt8uH75XVnfflcjOkMJA
	2dvpDgejcOo4duW0px309/fQ6KdJKwuH4+qEv38K0g/ZtQevrcGVtB+Js5rnwOCOnP2APABZ0tFCe
	cpQ/6kpYIWSWmshl2KjutfxpX1sduyVXqPvLFIgd2lXaSVvPzjjFigXSskLn2qdiTUneUOqrU5KD5
	U5WQleBct3trNOxRO7UnUOlJZTlnk/f+rnLqS7VYAD2gy/9doshZlsUzSZ+Iu8YjGdUPXV9H4BsOp
	YW6/WaXkmF3WOniWKLvN1wjR7fkl/NxKNySGjwoY2CmqV5HKUnm0TXjRw33sajTgry6tEJQY1KwcQ
	eugJXsWg==;
Received: from mail-pl1-x661.google.com ([2607:f8b0:4864:20::661])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4NZ-0000000Dt79-3yn0
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 20:24:12 +0000
Received: by mail-pl1-x661.google.com with SMTP id d9443c01a7336-2ae1255a90bso2989965ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 12:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772223842; x=1772828642; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=;
        b=ZK9izO8jlgTIw9RaKwlN0MnCBNcnUdXT9pNmYmdxBW0QJjppqB7tItitPhx70EIbQK
         yVTMU7omiPu1XUByE30ExYyAiI4XLwpKJejBBex0HPTACpQAOKCh4dIfM+Iuoo14nNGE
         jp+mmsivCXMQghIelV8dxfoX1keRtNi2lBenhqsYJgg5VOaYvDIECEUP6NuVZU9tFRME
         Ycu/doQmdQ1yYW0+DUkdrcbccK1IbnJkE69h0K8SAo+GfbBQS3gYiMBMsO3Q36kOcJax
         1ffiQIs4TNOFNfn+KQD0Q1oKxuOTsobtdtTZsULmsD4CKlX8Wl9Vq6bw0YDIgoZu0W+j
         Qg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223842; x=1772828642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lG8nfg+ASIKQ9CbyoNXjrLj+myT10j8TFxZs8gb+75o=;
        b=o2LkY41DBZwgMDKscI1kff7MwS3CJtk1nZUE/UurSADHWTGlZ4vXbnaJ/NJuW0B/yj
         F9N4HDj1UPKJ5YAsnTs19NImym95oRLdeuaeLijCnGIU6lxHceLjktfBNjcYEYZAsxZ9
         FN6PpdJzUs8awY7ftfL9vEICfDrArmmHdI33BjQtGnujBbp3DrXIppqHQAvRPBCqriuc
         fu3YIvidN6nugUIRA41KmtCDhdj+1RYiV1RnllKpmlg3+O6MEGOsB64htTwxruHwtiFF
         PBYXWbiNOfvkU1ZAAMJLZNCewYDAc4+AYM0yj5RllscixcCRaBI+LW5nyxK8swGwpuyP
         xCBw==
X-Gm-Message-State: AOJu0Yw+R7SaGwoz2Rc6sIXpTS+42uJxDNMlO+RHsYGZn9eA7rKrDQr2
	TjwMx9C0/iCC0N3JBx5rRhA5QQyu1h+S3rweKIoGHWgN0nYTqyxEXsCQtyLQ69FMPj4trcmkDBf
	Qgk3vBT3DOUAUUxBsUOpo3fN+S7szsKaOw9Sazt8gO2kyMxxJcWrh
X-Gm-Gg: ATEYQzwD746M25AJFLAOiOeXJhjNX4gW7TzDKMgANZrinqS0eXuaDCYodHdB9r5XsxR
	4gq9rM/tHIE/iPjrtAysQX7N5QfPqRA51ENIROL+uIg1jh8fsI+/TxaV/S4rOsTwNrNPs8+2kej
	IZa0BI26s9iFU43O8nzH/WCcq+UNwrEqZ+lzAVvxhJVh8+1KP8DEix9AuQNoHD6OMCxypRemgV7
	QbZqpudyxOrEPN8JC2dgSoDdgSr1Z7dZiUr4joQBDJ4DmWBmCq7m8P7OUXiM/TJonrtZTaLQMUN
	hQd2c5A9aN4fgyShbtHCXnQkZRgTiMsNT+0rBr79aBXxV3YU9Dg5yp9jgQKr7avEUO68r5UBvBH
	mcn0L3skXEcTgOJBLMm8L3wlckDS6ySi50DUbDvE=
X-Received: by 2002:a17:903:1c2:b0:2aa:df82:ed85 with SMTP id d9443c01a7336-2ae2e3e3cbdmr29408695ad.1.1772223842360;
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5fbd8esm7393695ad.47.2026.02.27.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0D1E3342295;
	Fri, 27 Feb 2026 13:24:01 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 05ED6E420D8; Fri, 27 Feb 2026 13:24:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 5/8] nvme: add from0based() helper
Date: Fri, 27 Feb 2026 13:23:50 -0700
Message-ID: <20260227202354.1012322-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227202354.1012322-1-csander@purestorage.com>
References: <20260227202354.1012322-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_202410_583399_742A1D4E 
X-CRM114-Status: GOOD (  11.44  )
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

The NVMe specifications are big fans of "0's based"/"0-based" fields for
encoding values that must be positive. The encoded value is 1 less than
the value it represents. nvmet already provides a helper to0based() for
encoding 0's based values, so add a corresponding helper to decode these
fields on the host side.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/nvme.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9971045dbc05..ccd5e05dac98 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -760,10 +760,16 @@ static inline sector_t nvme_lba_to_sect(struct nvme_ns_head *head, u64 lba)
 static inline u32 nvme_bytes_to_numd(size_t len)
 {
 	return (len >> 2) - 1;
 }
 
+/* Decode a 2-byte "0's based"/"0-based" field */
+static inline u32 from0based(__le16 value)
+{
+	return (u32)le16_to_cpu(value) + 1;
+}
+
 static inline bool nvme_is_ana_error(u16 status)
 {
 	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
-- 
2.45.2


