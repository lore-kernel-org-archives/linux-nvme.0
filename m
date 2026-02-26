Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D87FD8FFB
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=; b=fkIXoANflnTY53BT/qJBR/JQGA
	asIgU3nFLT5MzYuprpS1JVMYm7S4livKC8ZKR8H/5CUnTP/1JavNC9jF71KPa4zwcoUSZS2drOlk3
	KBbHwOLmlFBeHYej9bnT8qOKk+244mGUWk5oE5102cR+5Nh9s3z5kRLW9MK+HacsiNSyrcNouAWCp
	9bWKqg3zTgQHHjAZJ49X4RRWY6/QuxD0oJwXMWq2VwfdWMk5oz+9hUPCtYceRLCDn+UgJYVkKjNIb
	xMiWSo27w2O1cokLIvXks+rLVFkVmmej9Jrh1mtMpMV/c8aV4e6bfPjjPJ6eE1Zbd0ILS3NtYM8KM
	qcqCzEsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgf1-000000070Yy-1M8g;
	Thu, 26 Feb 2026 19:04:31 +0000
Received: from mail-qt1-x863.google.com ([2607:f8b0:4864:20::863])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvget-000000070S9-1YXb
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 19:04:26 +0000
Received: by mail-qt1-x863.google.com with SMTP id d75a77b69052e-506984b6e65so1490521cf.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772132662; x=1772737462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=;
        b=eRVdSKEZQgUzxdb6ku9E6yhNOT2tnXCv253T+Nrz1jTT3CGH6kaIjefe8xGe7ezuIu
         b42l9knmUgGLyRCjuaOy3yikTdFk9rrYhSTImnpe8QYcyvWajcXHfr4QrVj/qsXjN50N
         GDdskbThy5oSKPX9pLXAZcNsdj8CNlORA12nH2PGhu08HiL3vfT3/JDu4Vtxph8f/sP1
         vEzmRcNuKh+tBqDq6huaFVYJH7ffg0mzLiZWPnuioH9ij6X8U+orup/qJIJ9vOuvoVxy
         rBufgKqgVog+7HsLvBzIXDV0+nRfWlLoFsc1TaQSkw80texdidt6p/ttPl+rDcAqJKXO
         98DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132662; x=1772737462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=;
        b=Jh3b4GMytOqgbTfDNYdyexaLFyjtTPpfPMaVRKW12IVDIOXASUTbfBmCyK7TFYyHGo
         Ph5BGwzZyKNLJQHvXclQXpF+ZKmQHR+rRN5q/MNMxeeJMOW0+TMfLN7Ak6nut4h31NOd
         ellNarQ0lC/MKyZyZNHX4u12MxN19ZJ9mA1z8oVydF5LIgnlIW+edN2iAl0PcCrTIeK9
         bNO5tbki08W44RQflyeB5LrHq4hUhjFdM+ncHxC2MLQ3ANr7fRzopOeJrJHh/lF6kEOg
         HFOhCYtpqw0mp4XskQB5eY6wDCNi1qImKaFcdiKpGtERWv2IZrpZEVki0fSNeRZuWiXP
         461Q==
X-Gm-Message-State: AOJu0YxE8FMWQUpd3k7uwL5T1Y6TbLBDQgIfI78cjH07qK/cGSWtWX0e
	UjrZTETeeh1XWwhhD/IORbRJkm1ZrGLeMOXRbvkgvbVJZ1WDjwpzytVFH/L5pGAMMo6sV68Sjqj
	Vk+eNzXKBWmuI4hWcz7UWBAUXsH6WhY3wRSPe
X-Gm-Gg: ATEYQzyJlGjZAmqcu8iQYGU3ctjaqZwmKtVhjBsGujfouN2gyhmBaW0HXAUQpyEzO3g
	h5KwXxC8ch+QV64SD3Q+yS1vy4PiCJ8/Uuz4XprRxpoIx3lMBH40QWWYTBtFQiYyhPc81DYI/xr
	a58wyTAo7XPxZk6/+njKcc24kuo5TaueJNEWRsXcdW1WWDJo7+V/DXsNA80Z6TuqVd4XvC3lxNh
	4dv6fdr2wgsgdZSkXCW5kCCwqv9/WC61tbRNSNOM+uZNKerNQvO9HAFX8sKx32ugaMah2rGgDoJ
	tcVELkZV5FjNM5kfU3Y8K5VMeEMGJprJplotbh6b3x7O8E8aQck3p2t6dj8uCIXbdEqMbTrW+WO
	0ut79C0uWqNd4nSmfOKzrNmqF0ynBeDijQwqs76lyNzBHfFsqKN3E8A==
X-Received: by 2002:a05:622a:4c7:b0:4ee:87e:dedf with SMTP id d75a77b69052e-507528847dcmr126891cf.8.1772132661604;
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50744a369d9sm3317611cf.5.2026.02.26.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DB507340245;
	Thu, 26 Feb 2026 12:04:20 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D652EE41254; Thu, 26 Feb 2026 12:04:20 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 7/8] nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
Date: Thu, 26 Feb 2026 12:04:14 -0700
Message-ID: <20260226190416.297725-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260226190416.297725-1-csander@purestorage.com>
References: <20260226190416.297725-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_110423_419080_9155CAF6 
X-CRM114-Status: GOOD (  15.77  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


