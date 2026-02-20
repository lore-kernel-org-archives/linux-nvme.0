Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8953C531FE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 03:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A00Y3pDN9iUYHER17pm03ZbljFG3KevPDkg+zFu7U1Y=; b=b1/rV5yVPd1k0aWIqK2i9qeF0V
	n5BZOAvQxSOgcy3eASj0JeNbbg4+PccKSDoITJ5TGOSiN6NVkXbXtGHuo2N6ErP8Cwx8wzdnpJIho
	DMzCN+mJ91F3zSUxSndwbhLMnq2C+9u/FuQjW1yrUpwKvwVk25gBXEeMAjh9ZMukb0PPx7kpnfMiA
	XXovslNki8nHn7D2bAKg3v8k+BWyRBb6BZQ3Vi4aixwqQGLMErVhp9vUyFyC5dGkYtmsH3xaEtGbJ
	WqcNuel9OLt/pTh+rhJAEUKLnQfkF4N5F9u72n2YgtZ2oFisH7wx8ihs6j6MDkKuOfDNfjNy6O1s3
	AGl50FpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBm-0000000DA9e-2jqW;
	Fri, 20 Feb 2026 03:28:22 +0000
Received: from mail-dl1-x1262.google.com ([2607:f8b0:4864:20::1262])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBj-0000000DA82-1l9E
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 03:28:20 +0000
Received: by mail-dl1-x1262.google.com with SMTP id a92af1059eb24-12736a0147cso143860c88.1
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 19:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771558099; x=1772162899; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A00Y3pDN9iUYHER17pm03ZbljFG3KevPDkg+zFu7U1Y=;
        b=WzEBvsM1B9Au4WJfaHcTK1BbaxS1JdprjpvKjWAOU2SJTOMAEpnefuSNgzLAJQtEMQ
         ST3/s/ql/xzxEcKzfa1izmT+k1fNX+nfrW9VuH7gdye3RXuYfJBEHb67zvTnjBt8s3nf
         evbGpTNMoLM0QB/kaiiKPhQob76y58ZC2CaOeAxHmHB0GUpobveT3VCIkI78n9C1Xeds
         aJ+u0XqjjI6GKWEHBRznhW+3VP1+Ow71bce1uIJRRBQ3r5vuTahqmH1+dnPcScRx9EjD
         fAkWTmo+n5T0J/QOQ59haROuzxl/nP0ceK2uEPkfiAVc9+npDcNtruHKagqbT7xx83s+
         tp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558099; x=1772162899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A00Y3pDN9iUYHER17pm03ZbljFG3KevPDkg+zFu7U1Y=;
        b=WyZeW0sSDR8jyLmFV7b6T4D8T80KDbI27mAmRS+NC9/NmAvp+lSI+ZqNyWjrKm2MQl
         s+jtfhUagUaZEeJDf6JO5WF6gOfqjY/bkyJkw4tsxYLW7wJCN3s7QgUTIrZitaGD7ylW
         80lmKkJexnaABPq62k6NOzmQV7LjpGs3enpI9/5UFyx25iCVZG1XvW5vZo4OBXxWwMiX
         nr3RBvEnZzy5teezOROoZ/HotQ/gqB9SF/BvWbCmNYZ3gWFpF67zuIlShKnnaSr8xbV+
         finJgyBXRuGTdRSp+006Zd1bwrcmiAbObWjofpVI0pfy0JGNLs3zKCNbMghF6Pma6qw+
         DS1w==
X-Gm-Message-State: AOJu0Yzm8rWlmE4x0o+3juQ/0cL4cgaHsw4atxtzrOAbiemnSg/Li3k9
	+2dbuIM4zQaudpHxy6JnNVvPW1TMLp4Hli/OfSmdMj4yYgJA/iq/EgLfhocvPmPi8TCNz8IArJg
	YQPyz+9hkXvjzBYmyNXwBILpH49pjv8Hx2AwD
X-Gm-Gg: AZuq6aIPxZTdcNukpNyhSun53DVJCUwaEjZspYlKWaGPMr7Jxb0wl8R2bSWBc6YIXz0
	Q125sT4GYk+1ufgztMPFXOF5rjcqrQGTVCmYlXlEo5vh98zHEnn23NefkClUUsQpvYWGa70R0Vr
	z+7IIxMx6ww+JBorrBuEpTeIDwsmmZ9rEFdCDVs/je6rBr+bU5pWGETisZnNmmR2+usixZPt/y6
	muNRmbAdviNASVD8bAGnEW3F1o0zI53qVE2YB/fK/8wZv4CvTdyL2d4HXwOnjtYtonrh3bTANAA
	57r8iG9pxQhnetQ1DIK05xNeXgfT3I7h225eba/ZN1VNJU1VGmVDSP70REQ0c7YPYGukXN7xdKU
	fYNSOIJaGmBVU3aImaHqe128a026pReGYqipDAkWXqGeRyV5UBwjWWg==
X-Received: by 2002:a05:7022:7e03:b0:127:3480:7ca5 with SMTP id a92af1059eb24-127397d8408mr4869659c88.2.1771558098534;
        Thu, 19 Feb 2026 19:28:18 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12742b60d29sm3074231c88.1.2026.02.19.19.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:28:18 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7CF1F341CC1;
	Thu, 19 Feb 2026 20:28:16 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7A67BE420F8; Thu, 19 Feb 2026 20:28:16 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 5/6] nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
Date: Thu, 19 Feb 2026 20:28:08 -0700
Message-ID: <20260220032809.758089-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260220032809.758089-1-csander@purestorage.com>
References: <20260220032809.758089-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_192819_459864_F8C0252D 
X-CRM114-Status: GOOD (  15.16  )
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

Use the NVME_NS_FEAT_OPTPERF_SHIFT constant in nvmet_bdev_set_limits()
to set the OPTPERF bits of the nvme_id_ns NSFEAT field instead of the
magic number 4.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca604..d94f885a56d9 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -28,15 +28,15 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->nawun = lpp0b;
 	id->nawupf = lpp0b;
 	id->nacwu = lpp0b;
 
 	/*
-	 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
+	 * OPTPERF = 01b indicates that the fields NPWG, NPWA, NPDG, NPDA, and
 	 * NOWS are defined for this namespace and should be used by
 	 * the host for I/O optimization.
 	 */
-	id->nsfeat |= 1 << 4;
+	id->nsfeat |= 0x1 << NVME_NS_FEAT_OPTPERF_SHIFT;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
 	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.45.2


