Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822B2F4BB61
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=; b=u3GeUv5WSwBUp27DiunrTMGO6V
	bm4conZSkNbI5yfLjHM7+sGu2UF74L/370kccz31pkI0NmNj6L+Xb3euJfKQMMpUfxfH7vxlM+/wh
	IeGONnRms+BIdXDulVZ+x9Qh4Ei+H6aQQcfSGJG5stAO7vRIA33om1JlDJLpi5qk2J6Dtlgo0mGgf
	8mft/dWok6QAQdBRCSk6LKUskUoND9B1j/CtZFa3Fo+8UC1pN1TD4+VVK/bJ33ZbrmsxZT1R5VSiT
	7tpPO9/O0Bm1dXJkk3TJ8f6xRoLuVeTWes8nt7l2+g+ejPJiEBQ3XYYWgMFoBoTujtK5ZKumeJ6fi
	/7CXQPWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw05-00000002SJz-25qL;
	Tue, 24 Feb 2026 17:15:09 +0000
Received: from mail-yw1-x1163.google.com ([2607:f8b0:4864:20::1163])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvzz-00000002SEr-2VqZ
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 17:15:05 +0000
Received: by mail-yw1-x1163.google.com with SMTP id 00721157ae682-7966d747c84so2960047b3.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771953303; x=1772558103; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=;
        b=C+M7JEZpKp7/y+2Oln/o5CV82eqt5+p8OBOKxlfTt22og6q5iWrV9tOdrhPl3ZUjsa
         h6Pk4KhGFiSKvuZ7FHTxN79mO2kJ2da9VyekgdVXGv9KdLNXhehL6dPabx5fU76uwgTP
         37pqQOC06T4KRgQM2BtJbva2W1ZuFA3aKjBCbfSY6OK74/9Tfbps0SL+aG+gEE43jIeQ
         633JHe3d54fggZ93TanXamx6HTgmCR5qtrbpW5mxsldE5ggxofD1eG7AzYiTQd5tfuDK
         BYSmppyHgN+1EbGlz/KixLNchP/5JDcnlwAkipXoa2KtMWskzjSp3FwW1CFXqljVPhqN
         8FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953303; x=1772558103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chF3cAD1j09EpR3bM9lUaumkQDJZpAeYYRmoTp9QLII=;
        b=uZSPSQ7xLrVpKqZuRWF+zszzRESGdhTO6NCf9FzDIfipckDP8cixOuCv0W6EG7LeEV
         5v4bYT/qfCSaMG7LHfLPPSDGJoI5GzAfLJk3Zp4bl+5ZykEAQ6JsM8wsR+Qlb0yJfmF5
         b/h8QVlyaCWjpgkq+pZIAUr+p6mT6Ivy+TTW4NogCe+m5RkXDNMhTC4K+Nen0ZANAL46
         zFJj4qONaTlvwFCibuEryLFkVWtvAy4zIKUbfmvuszEpXf0FQO7B0QSuIwPN+8V49OpI
         fQrbe7irUSYfLU1E7OzPOhUQ3UQNEc3J3k4jfY2XyNNpZ54I2X+D+Hqf1l8hll2jzD+U
         BE2w==
X-Gm-Message-State: AOJu0YzxGiqJfl9qS5dbymp/7OhC+Qj7/9CPaP57jpdAqRLi65p1i41C
	BfEGnjsL7cKWiaZkjwYZoOT87D6Q2gK2vgmzAYiFQrn45Ync+QZLqXrG4G/RBAQCjrly6Ktqzkv
	D7ixKwu+ZvG5uYuS0+gL5k121aPGbYyQCWZAb
X-Gm-Gg: ATEYQzwCj94CyLZdFPJfnRccczH1tUIXRKZpBi2/rNttIRFE22/ZGAxyYHihVaLaiIJ
	ZEKH9FkHPDJsA2yVCZX5JyOG55kXwUQ9qN6XYzhDjyvC3WnKEU4VCVIgCBFjBZeWf89vt1dzGkL
	p1Q21lP+prElnYjOCjqxamUCyvWg1wdQl6XWoiIQEOKlUfQxiWZUw5EE82hOC9bhSD3Ag8jgTEw
	mlB45BNiZx0sZLqlCj9iwaa1qzDxzci5SEjSplc3zV6CbEnnCa7fgCRfdYU1HgvQC7YEt5wECoA
	NbNMVZnvB6Q84uBaqvI5AyjO+s+mYUAYfT/9jigmwJgMKyzFfgvNwZsb4pzVsVwVVH9HVKpOzpI
	FaNmOJ3ehjNcCFUGa4PoEUQMAUYv1B7My8kei2JJBv3Iqyd3jd22jSA==
X-Received: by 2002:a05:690c:d8a:b0:797:a52d:85cb with SMTP id 00721157ae682-7982913fd0dmr93190697b3.7.1771953302724;
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7982dc2a057sm13159437b3.13.2026.02.24.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0F72B342244;
	Tue, 24 Feb 2026 10:15:02 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0A695E41254; Tue, 24 Feb 2026 10:15:02 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 7/8] nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
Date: Tue, 24 Feb 2026 10:14:36 -0700
Message-ID: <20260224171437.3175993-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260224171437.3175993-1-csander@purestorage.com>
References: <20260224171437.3175993-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091503_640188_D6C351A7 
X-CRM114-Status: GOOD (  15.88  )
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


