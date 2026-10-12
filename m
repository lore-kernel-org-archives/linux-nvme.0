Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A03CA9EC5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wZoOoHAtBKyUqJYvkGqSuamBRb2ixZoZPiDn5D95M/I=; b=AbIvhfbhEY62raW0hKQBvWrnDK
	6a2lLPmZoIc4zYv2i06/fi0aRZlOy7AP/cAVnmK28Oe8b/wq2R60QHCa4+Gpi/M20EtSUsESTdXEx
	UuG0ghgb7xXcryblxJHEsm4EFccGwVGIcD+qHR19cwY0DaygDfLTyZSjPhsPgMZNVQicQKNINIzBd
	5oBi4z6XWqkLcoLZYrFSQHW7/YyU3U42jtPSEnNuug0fJbUu/bvty/fx6Z6EbMwt4ncgb1Q4W4YwX
	nqWPK/2DFdfIsuA9SdsOEPDaJBh11H3UfKjQ7KCA7T9/xrBmywEfjXuag1Dx5krjJWQKTRSkiTubg
	qbxdocKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGm7-0000000AehA-279m;
	Mon, 12 Oct 2026 14:13:11 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGm3-0000000Aedd-2G17
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 14:13:10 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-48b042c0759so1450209f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814385; x=1792419185; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wZoOoHAtBKyUqJYvkGqSuamBRb2ixZoZPiDn5D95M/I=;
        b=CXgsOyZ3X96uTdvzJeqHzQZvyYIFK7KxylPhwx7UjFdrQ3K76VtjOnj/JMBEYH9ESF
         pCWlR2Z/M9qduUq6SiO2cb7+iOtftxpdjNXHq7K6v7KHkjK+Xx4t1BRutxQZ2acNRJy2
         d8oDIU4gHSGrrJ7SoPK4tRKwm5cOOc7vNV1VvwWTVytu48zE3r44S+lpA/uVcC93kUht
         I1XtWOBCWqhGQ1iuRl86BhSJ0pCjeqS56yN3jrN7gtYWhNWJKAx5XbTk/Ci7Jddslz8I
         BfPvAPVx/ZLI+yccweGoPfyv/7jWhQ0FPoiiSmYAQMV9An/hioZxpQphfkmDHf0CGN28
         8IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814385; x=1792419185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wZoOoHAtBKyUqJYvkGqSuamBRb2ixZoZPiDn5D95M/I=;
        b=m4Wdqz4c99nybB+yD6xiMIi7YkWyasl8dbjBQiS6seF1kEfKyH3SMVQkS1UYWfGoKx
         0e9BgQPP5q4CvPUJbQeTTHpm4YusC3aYlB84mmsj04+DLfquMsdcFj7oOlCN/wYCbMih
         ilz5OmLWtzpESleO0cSLOlzD5PHZHLUxpT8wykHej2vsuhsbSaSfZxu1E/fGyaRuZNhG
         zoYOjPxoWPNUgkft7c+lNSn1Y8mDVfXBIBBUI9uPpShYsEGcWHQ0BA+fLTJBFSpFIx4q
         eJZEpPH+Un2Mkt+JZD1MViB9+RskcdTPBbxP55r+qRIW0oKajP/I8gE0whsvdJF9iVE+
         cwIw==
X-Forwarded-Encrypted: i=1; AKwUvBwlvNnLY86xtLDi9SP1tdkzc0WYM5Qt9CiGJxgkAl+tZwtj+fqf9dSz21BOf8s/PrI32jrBWgEXVc6+@lists.infradead.org
X-Gm-Message-State: AFq9FYIXg7XhyU7cKhG2t+i/CPPUkLI3eYwQ0TDrQgf8k7Y+p/IJYM+2
	XR9ulBMXh6CYso/A67koSm4nwlElHIh3jZ1ZGAkXnvVqp6RESdbKlNry
X-Gm-Gg: AYBFou2tvg+GzrAWhDix8XQ8CHvGhnU7CW0m/whHyXMcj7qcKghM8sq1aDwauiIKUIX
	k7/+atgbZS8a1/I2uIIPzBUG+KHpc+CPhbW+aFDT8ykGGMewjA0UZieHexQX9CPGTTpo0WZu5xT
	RiWAT43xdjL7Ns4zHD3T7wCWrqMrEM0z1vuw53/afiF0YxdY+vZxV7FxgitpT9V+KnHUm95cXN0
	7f6f3xawKLnxmEB3h8KvKX+SltE7tFIieYZLtMndm6FPMH4AFDZDjSo2mPDuixzwMAwal3E+4vD
	eRO6Vw2PhfleIICqZ7b1vUZ2oaPnYvCjedBg6pKc/SIcojZqrbTZ4vQD8sZC9Uhe8OfbfpMJLfV
	InktnKcd3D/UkfwbfplqhXF6gqXO+VHuZnhvxNd71SFhgl9QUnt+y1TBUQJdfPz7cs86cejYuUc
	noouvv9BqQCIsMkod95FyQNLO5bzwsV/TIaunXaV6lb07HLwKzG3eoapf7BvwbA/6tiJvY+7JeH
	dddPwMeuY6oNnriljmbr8dVJZBgUZLXhmO+lpPKNLJu
X-Received: by 2002:a05:6000:491c:b0:488:8a5d:ffcc with SMTP id ffacd0b85a97d-48dba9e6715mr18187313f8f.13.1791814385235;
        Mon, 12 Oct 2026 07:13:05 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm18703035f8f.39.2026.10.12.07.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:13:04 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5/5] nvmet: pci-epf: require SGLs to match the command data length
Date: Mon, 12 Oct 2026 16:12:32 +0200
Message-ID: <20261012141239.156408-6-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012141239.156408-1-parri.andrea@gmail.com>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_071307_594276_08B78FC4 
X-CRM114-Status: GOOD (  19.86  )
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

The PCI endpoint target sends the host every byte a read command's SGL
describes, even when the SGL describes more than the command transfers.
The excess is kmalloc() memory the command never wrote, so the host
receives stale target memory. Any successful read can do this,
including Identify.

nvmet_pci_epf_alloc_iod_data_buf() allocates each segment at the length
of its SGL data descriptor, but sets req->transfer_len from
iod->data_len, the length the command implies. Once the command
completes, nvmet_pci_epf_transfer_iod_data() sends every segment in
full. Nothing compares the descriptor lengths with iod->data_len, and
the MDTS check only bounds iod->data_len.

Fail the command with Data SGL Length Invalid when the data descriptors
do not add up to iod->data_len, before any segment is allocated. The
tcp and rdma transports take the data length from the SGL itself, so
there most commands already reject a mismatch in
nvmet_check_transfer_len(). PRP lists are built from iod->data_len and
are unaffected.

Found by code inspection. Build-tested only (x86_64, W=1): no PCI
endpoint hardware was available to run it.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
For stable, this depends on patch 4/5: without it, the new Data SGL
Length Invalid error is still reported to the host as a success.

 drivers/nvme/target/pci-epf.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4c5fff232fb99..a8df176c1a574 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1073,10 +1073,22 @@ static int nvmet_pci_epf_iod_parse_sgl_segments(struct nvmet_pci_epf_ctrl *ctrl,
 	return 0;
 }
 
+static u64 nvmet_pci_epf_iod_data_segs_len(struct nvmet_pci_epf_iod *iod)
+{
+	u64 len = 0;
+	int i;
+
+	for (i = 0; i < iod->nr_data_segs; i++)
+		len += iod->data_segs[i].length;
+
+	return len;
+}
+
 static int nvmet_pci_epf_iod_parse_sgls(struct nvmet_pci_epf_iod *iod)
 {
 	struct nvmet_pci_epf_ctrl *ctrl = iod->ctrl;
 	struct nvme_sgl_desc *sgl = &iod->cmd.common.dptr.sgl;
+	int ret;
 
 	if (sgl->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
 		/* Single data descriptor case. */
@@ -1084,10 +1096,23 @@ static int nvmet_pci_epf_iod_parse_sgls(struct nvmet_pci_epf_iod *iod)
 		iod->data_segs = &iod->data_seg;
 		iod->data_seg.pci_addr = le64_to_cpu(sgl->addr);
 		iod->data_seg.length = le32_to_cpu(sgl->length);
-		return 0;
+	} else {
+		ret = nvmet_pci_epf_iod_parse_sgl_segments(ctrl, iod);
+		if (ret)
+			return ret;
 	}
 
-	return nvmet_pci_epf_iod_parse_sgl_segments(ctrl, iod);
+	/*
+	 * The command executes on data_len bytes, but each segment is
+	 * allocated and transferred in full, so they must describe exactly
+	 * data_len bytes.
+	 */
+	if (nvmet_pci_epf_iod_data_segs_len(iod) != iod->data_len) {
+		iod->status = NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int nvmet_pci_epf_alloc_iod_data_buf(struct nvmet_pci_epf_iod *iod)
-- 
2.53.0


